#!/usr/bin/env python3
"""Upload a signed AAB plus Play Store listing text/images via the Android Publisher API.

Requires a Play Console service account JSON (PLAY_SERVICE_ACCOUNT_JSON).
Does not submit Data safety or content rating — those stay in Play Console.
"""
from __future__ import annotations

import argparse
import json
import os
import re
import sys
from pathlib import Path

from google.auth.transport.requests import AuthorizedSession
from google.oauth2 import service_account

PLAYSTORE = Path(__file__).resolve().parent.parent
ROOT = PLAYSTORE.parent.parent.parent
LISTING = PLAYSTORE / "listing"
META = LISTING / "metadata" / "android"
SCOPE = "https://www.googleapis.com/auth/androidpublisher"
API = "https://androidpublisher.googleapis.com/androidpublisher/v3"
UPLOAD = "https://androidpublisher.googleapis.com/upload/androidpublisher/v3"

TITLE_MAX = 30
SHORT_MAX = 80
FULL_MAX = 4000

IMAGE_TYPES = (
    ("icon.png", "icon"),
    ("featureGraphic.png", "featureGraphic"),
    ("phoneScreenshots", "phoneScreenshots"),
    ("sevenInchScreenshots", "sevenInchScreenshots"),
    ("tenInchScreenshots", "tenInchScreenshots"),
)


def load_dotenv(path: Path) -> dict[str, str]:
    out: dict[str, str] = {}
    if not path.is_file():
        return out
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        k, _, v = line.partition("=")
        out[k.strip()] = v.strip().strip('"').strip("'")
    return out


def play_env() -> dict[str, str]:
    local = PLAYSTORE / ".env.release"
    root = ROOT / ".env.release"
    data = load_dotenv(root)
    data.update(load_dotenv(local))
    return data


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8").strip()


def pubspec_version() -> tuple[str, str]:
    text = (ROOT / "pubspec.yaml").read_text(encoding="utf-8")
    m = re.search(r"^version:\s*(\S+)", text, re.M)
    if not m:
        raise SystemExit("Could not read version from pubspec.yaml")
    name, _, code = m.group(1).partition("+")
    if not code:
        raise SystemExit("pubspec.yaml version must include +BUILD (versionCode)")
    return name, code


def session_from_json(json_path: Path) -> AuthorizedSession:
    creds = service_account.Credentials.from_service_account_file(
        str(json_path), scopes=[SCOPE]
    )
    return AuthorizedSession(creds)


def check(resp, action: str) -> dict | list | None:
    if resp.status_code >= 400:
        body = resp.text[:2000]
        raise SystemExit(f"{action} failed HTTP {resp.status_code}: {body}")
    if not resp.content:
        return None
    try:
        return resp.json()
    except json.JSONDecodeError:
        return None


def create_edit(session: AuthorizedSession, pkg: str) -> str:
    r = session.post(f"{API}/applications/{pkg}/edits", json={})
    data = check(r, "Create edit")
    return str(data["id"])


def commit_edit(session: AuthorizedSession, pkg: str, edit_id: str) -> None:
    r = session.post(f"{API}/applications/{pkg}/edits/{edit_id}:commit")
    check(r, "Commit edit")


def upload_bundle(session: AuthorizedSession, pkg: str, edit_id: str, aab: Path) -> int:
    url = (
        f"{UPLOAD}/applications/{pkg}/edits/{edit_id}/bundles"
        "?uploadType=media"
    )
    with aab.open("rb") as fh:
        r = session.post(
            url,
            data=fh,
            headers={"Content-Type": "application/octet-stream"},
        )
    data = check(r, f"Upload AAB {aab.name}")
    return int(data["versionCode"])


def set_track(
    session: AuthorizedSession,
    pkg: str,
    edit_id: str,
    track: str,
    version_code: int,
    notes: list[dict],
    status: str,
) -> None:
    body = {
        "track": track,
        "releases": [
            {
                "status": status,
                "versionCodes": [str(version_code)],
                "releaseNotes": notes,
            }
        ],
    }
    r = session.put(
        f"{API}/applications/{pkg}/edits/{edit_id}/tracks/{track}",
        json=body,
    )
    check(r, f"Assign track {track}")


def update_details(session: AuthorizedSession, pkg: str, edit_id: str, listing: dict) -> None:
    body = {
        "defaultLanguage": listing.get("defaultLanguage", "en-US"),
        "contactWebsite": listing.get("contactWebsite"),
        "contactEmail": listing.get("contactEmail"),
    }
    body = {k: v for k, v in body.items() if v}
    r = session.patch(
        f"{API}/applications/{pkg}/edits/{edit_id}/details",
        json=body,
    )
    check(r, "Update contact details")


def validate_copy(locale: str, title: str, short: str, full: str) -> None:
    if not (1 <= len(title) <= TITLE_MAX):
        raise SystemExit(f"{locale} title length {len(title)} (max {TITLE_MAX})")
    if not (1 <= len(short) <= SHORT_MAX):
        raise SystemExit(f"{locale} short_description length {len(short)} (max {SHORT_MAX})")
    if not (1 <= len(full) <= FULL_MAX):
        raise SystemExit(f"{locale} full_description length {len(full)} (max {FULL_MAX})")


def upload_listings(session: AuthorizedSession, pkg: str, edit_id: str) -> list[dict]:
    notes: list[dict] = []
    for locale_dir in sorted(p for p in META.iterdir() if p.is_dir()):
        locale = locale_dir.name
        title = read_text(locale_dir / "title.txt")
        short = read_text(locale_dir / "short_description.txt")
        full = read_text(locale_dir / "full_description.txt")
        validate_copy(locale, title, short, full)
        changelog = locale_dir / "changelogs" / "default.txt"
        if changelog.is_file():
            notes.append({"language": locale, "text": read_text(changelog)[:500]})
        r = session.put(
            f"{API}/applications/{pkg}/edits/{edit_id}/listings/{locale}",
            json={
                "language": locale,
                "title": title,
                "shortDescription": short,
                "fullDescription": full,
            },
        )
        check(r, f"Listing {locale}")
        print(f"[OK] listing {locale} (title {len(title)}, short {len(short)}, full {len(full)})")
        upload_images(session, pkg, edit_id, locale, locale_dir / "images")
    return notes


def upload_images(
    session: AuthorizedSession,
    pkg: str,
    edit_id: str,
    locale: str,
    images: Path,
) -> None:
    if not images.is_dir():
        print(f"[WARN] No images for {locale}; run prepare_play_listing.py first")
        return
    for name, image_type in IMAGE_TYPES:
        path = images / name
        files: list[Path] = []
        if path.is_file():
            files = [path]
        elif path.is_dir():
            files = sorted(path.glob("*.png"))
        if not files:
            continue
        r = session.delete(
            f"{API}/applications/{pkg}/edits/{edit_id}/{locale}/{image_type}:deleteall"
        )
        if r.status_code not in (200, 204, 404):
            check(r, f"Clear {locale} {image_type}")
        for img in files:
            url = (
                f"{UPLOAD}/applications/{pkg}/edits/{edit_id}/{locale}/{image_type}"
                "?uploadType=media"
            )
            with img.open("rb") as fh:
                ur = session.post(
                    url,
                    data=fh,
                    headers={"Content-Type": "image/png"},
                )
            check(ur, f"Upload {locale} {image_type} {img.name}")
        print(f"[OK] {locale} {image_type} x{len(files)}")


def resolve_aab(arg: str | None) -> Path | None:
    if arg:
        p = Path(arg)
        return p if p.is_file() else ROOT / arg
    artifacts = PLAYSTORE / "artifacts"
    aabs = sorted(artifacts.glob("*.aab"), key=lambda p: p.stat().st_mtime)
    if aabs:
        return aabs[-1]
    fallback = ROOT / "build" / "app" / "outputs" / "bundle" / "release" / "app-release.aab"
    return fallback if fallback.is_file() else None


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Upload AAB and/or Play listing")
    p.add_argument("--aab", help="Path to release AAB (default: newest artifacts/*.aab)")
    p.add_argument("--track", default="", help="internal | alpha | beta | production")
    p.add_argument("--listing-only", action="store_true", help="Skip AAB; update listing assets")
    p.add_argument("--skip-listing", action="store_true", help="Upload AAB only")
    p.add_argument("--draft", action="store_true", help="Leave release as draft (not completed)")
    p.add_argument("--json-key", default="", help="Service account JSON (else PLAY_SERVICE_ACCOUNT_JSON)")
    p.add_argument("--dry-run", action="store_true", help="Validate copy lengths; do not call Play")
    return p.parse_args()


def main() -> int:
    args = parse_args()
    env = play_env()
    listing = json.loads((LISTING / "listing.json").read_text(encoding="utf-8"))
    pkg = listing["packageName"]
    track = args.track or env.get("PLAY_TRACK") or "internal"
    status = "draft" if args.draft else "completed"

    if args.dry_run:
        for locale_dir in sorted(p for p in META.iterdir() if p.is_dir()):
            title = read_text(locale_dir / "title.txt")
            short = read_text(locale_dir / "short_description.txt")
            full = read_text(locale_dir / "full_description.txt")
            validate_copy(locale_dir.name, title, short, full)
            print(
                f"{locale_dir.name}: title={len(title)} short={len(short)} full={len(full)}"
            )
        print("[OK] listing copy within Play limits")
        return 0

    json_key = Path(
        args.json_key
        or env.get("PLAY_SERVICE_ACCOUNT_JSON")
        or os.environ.get("PLAY_SERVICE_ACCOUNT_JSON", "")
    )
    if not json_key.is_file():
        print(
            "Service account JSON not found. Set PLAY_SERVICE_ACCOUNT_JSON in "
            "deployment/android/playstore/.env.release (Play Console → Users → "
            "API access). See Docs/07-STORE-LISTING.md",
            file=sys.stderr,
        )
        return 1

    aab = None if args.listing_only else resolve_aab(args.aab)
    if not args.listing_only and (not aab or not aab.is_file()):
        print("AAB not found. Build first or pass --aab.", file=sys.stderr)
        return 1

    session = session_from_json(json_key)
    edit_id = create_edit(session, pkg)
    print(f"[INFO] Play edit {edit_id} package={pkg} track={track}")

    try:
        update_details(session, pkg, edit_id, listing)
        notes = [] if args.skip_listing else upload_listings(session, pkg, edit_id)
        if not args.listing_only:
            version_code = upload_bundle(session, pkg, edit_id, aab)
            name, expected = pubspec_version()
            print(f"[OK] uploaded {aab.name} versionCode={version_code} ({name})")
            if str(version_code) != expected:
                print(
                    f"[WARN] Play versionCode {version_code} != pubspec +{expected}",
                    file=sys.stderr,
                )
            set_track(session, pkg, edit_id, track, version_code, notes, status)
        commit_edit(session, pkg, edit_id)
    except Exception:
        session.delete(f"{API}/applications/{pkg}/edits/{edit_id}")
        raise

    print("[OK] Play edit committed")
    if args.listing_only:
        print("Listing/images updated. Data safety and content rating stay in Console.")
    else:
        print(f"AAB on track '{track}' ({status}). Testers: Play Console → Testing.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
