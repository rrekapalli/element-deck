#!/usr/bin/env python3
"""Generate the Element Deck PWA service worker after `flutter build web`.

Goals:
  - Offline / Add to Home Screen: precache the app shell, CanvasKit, SQLite,
    and assets on the first online visit.
  - Updates: CACHE_NAME includes the main.dart.js content hash so each deploy
    installs a new worker. The in-app strip reloads once the user taps Update.
"""

from __future__ import annotations

import hashlib
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

# Paths under build/web that must never be precached (alt renderers / debug).
SKIP_PREFIXES = (
    "canvaskit/chromium/",
    "canvaskit/experimental_webparagraph/",
    "canvaskit/skwasm",
    "canvaskit/wimp",
)
SKIP_SUFFIXES = (
    ".symbols",
    ".last_build_id",
    ".map",
)
SKIP_NAMES = {
    "flutter_service_worker.js",  # never precache the SW script itself
    "version.json",  # update checks must not SWR this on every navigation
}

SW_TEMPLATE = r"""// Element Deck offline + update service worker (generated).
// CACHE_NAME includes main.dart.js content hash — do not edit by hand.
'use strict';

const CACHE_NAME = 'element-deck-cache-__CACHE_HASH__';
const PRECACHE_URLS = __PRECACHE_URLS__;
// Must be present before we drop older caches / claim clients.
const CRITICAL_URLS = [
  '/index.html',
  '/main.dart.js',
  '/flutter_bootstrap.js',
  '/canvaskit/canvaskit.js',
  '/canvaskit/canvaskit.wasm',
  '/sqlite3.wasm',
  '/drift_worker.js',
];

async function putInCache(cache, url) {
  try {
    const response = await fetch(url, { cache: 'no-cache', credentials: 'same-origin' });
    if (response && response.ok) {
      await cache.put(url, response.clone());
      try {
        await cache.put(new Request(url, { credentials: 'same-origin' }), response.clone());
      } catch (_) {}
      return true;
    }
    console.warn('[Element Deck SW] precache skip', url, response && response.status);
  } catch (e) {
    console.warn('[Element Deck SW] precache failed', url, e);
  }
  return false;
}

async function cacheHas(cache, url) {
  const hit =
    (await cache.match(url, { ignoreSearch: true })) ||
    (await cache.match(new Request(url), { ignoreSearch: true }));
  return !!hit;
}

async function matchFromCaches(request) {
  const url = new URL(request.url);
  const path = url.pathname;
  const names = await caches.keys();
  names.sort((a, b) => {
    if (a === CACHE_NAME) return -1;
    if (b === CACHE_NAME) return 1;
    return 0;
  });
  for (const name of names) {
    const cache = await caches.open(name);
    let hit = await cache.match(request, { ignoreSearch: true });
    if (hit) return hit;
    hit = await cache.match(path, { ignoreSearch: true });
    if (hit) return hit;
    if (path.startsWith('/')) {
      hit = await cache.match(path.slice(1), { ignoreSearch: true });
      if (hit) return hit;
    }
  }
  return undefined;
}

self.addEventListener('install', (event) => {
  // Do NOT skipWaiting until critical assets are cached.
  event.waitUntil(
    (async () => {
      const cache = await caches.open(CACHE_NAME);
      const requiredFirst = [
        ...CRITICAL_URLS,
        ...PRECACHE_URLS.filter((u) => !CRITICAL_URLS.includes(u)),
      ];
      const seen = new Set();
      for (const url of requiredFirst) {
        if (seen.has(url)) continue;
        seen.add(url);
        await putInCache(cache, url);
      }
      let ready = true;
      for (const url of CRITICAL_URLS) {
        if (!(await cacheHas(cache, url))) {
          ready = false;
          console.error('[Element Deck SW] critical asset missing after install:', url);
        }
      }
      await self.skipWaiting();
      if (!ready) {
        console.warn('[Element Deck SW] installing with incomplete critical set; keeping prior caches');
      }
    })(),
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    (async () => {
      const cache = await caches.open(CACHE_NAME);
      let criticalReady = true;
      for (const url of CRITICAL_URLS) {
        if (!(await cacheHas(cache, url))) {
          criticalReady = false;
          break;
        }
      }
      if (criticalReady) {
        const names = await caches.keys();
        await Promise.all(
          names.filter((n) => n !== CACHE_NAME).map((n) => caches.delete(n)),
        );
      } else {
        console.warn('[Element Deck SW] activate: keeping old caches (critical set incomplete)');
      }
      await self.clients.claim();
    })(),
  );
});

self.addEventListener('message', (event) => {
  const data = event.data;
  const skip =
    data === 'skipWaiting' ||
    data === 'SKIP_WAITING' ||
    (data && typeof data === 'object' && data.type === 'SKIP_WAITING');
  if (skip) {
    event.waitUntil(self.skipWaiting());
  }
});

function isRevalidateFirst(url) {
  const p = url.pathname;
  return (
    p === '/' ||
    p.endsWith('/index.html') ||
    p.endsWith('/flutter_service_worker.js') ||
    p.endsWith('/manifest.json') ||
    p.endsWith('/pwa_update.js') ||
    p.endsWith('/flutter_bootstrap.js') ||
    p.endsWith('/version.json')
  );
}

function isCriticalPath(pathname) {
  return CRITICAL_URLS.some((u) => pathname === u || pathname.endsWith(u));
}

async function networkFirst(request) {
  try {
    const response = await fetch(request);
    if (response && response.ok) {
      const cache = await caches.open(CACHE_NAME);
      await cache.put(request, response.clone());
      const path = new URL(request.url).pathname;
      try {
        await cache.put(path, response.clone());
      } catch (_) {}
    }
    return response;
  } catch (e) {
    const cached = await matchFromCaches(request);
    if (cached) return cached;
    if (request.mode === 'navigate') {
      const shell =
        (await matchFromCaches(new Request('/index.html'))) ||
        (await matchFromCaches(new Request('/')));
      if (shell) return shell;
    }
    throw e;
  }
}

async function cacheFirst(request) {
  const cached = await matchFromCaches(request);
  if (cached) return cached;
  const response = await fetch(request);
  if (response && response.ok) {
    const cache = await caches.open(CACHE_NAME);
    await cache.put(request, response.clone());
    try {
      await cache.put(new URL(request.url).pathname, response.clone());
    } catch (_) {}
  }
  return response;
}

self.addEventListener('fetch', (event) => {
  if (event.request.method !== 'GET') return;

  const url = new URL(event.request.url);
  if (url.origin !== self.location.origin) return;

  const dest = event.request.destination;
  const htmlShell =
    url.pathname === '/' ||
    url.pathname.endsWith('/index.html');
  if (
    !htmlShell &&
    (dest === 'worker' ||
      dest === 'sharedworker' ||
      url.pathname.endsWith('.wasm') ||
      isCriticalPath(url.pathname))
  ) {
    event.respondWith(cacheFirst(event.request));
    return;
  }

  if (isRevalidateFirst(url) || event.request.mode === 'navigate') {
    event.respondWith(networkFirst(event.request));
    return;
  }

  event.respondWith(cacheFirst(event.request));
});
"""


def short_hash(path: Path, length: int = 12) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()[:length]


def should_skip(rel_posix: str) -> bool:
    name = Path(rel_posix).name
    if name in SKIP_NAMES:
        return True
    if name.startswith("."):
        return True
    for prefix in SKIP_PREFIXES:
        if rel_posix.startswith(prefix):
            return True
    for suffix in SKIP_SUFFIXES:
        if rel_posix.endswith(suffix):
            return True
    return False


def discover_precache_urls(build_dir: Path) -> list[str]:
    """Same-origin URLs required to boot Flutter web offline."""
    required = [
        "/",
        "/index.html",
        "/manifest.json",
        "/pwa_update.js",
        "/main.dart.js",
        "/flutter.js",
        "/flutter_bootstrap.js",
        "/canvaskit/canvaskit.js",
        "/canvaskit/canvaskit.wasm",
        "/sqlite3.wasm",
        "/drift_worker.js",
    ]

    discovered: list[str] = []
    for path in sorted(build_dir.rglob("*")):
        if not path.is_file():
            continue
        rel = path.relative_to(build_dir).as_posix()
        if should_skip(rel):
            continue
        if path.suffix.lower() not in {
            ".html",
            ".js",
            ".json",
            ".wasm",
            ".png",
            ".jpg",
            ".jpeg",
            ".gif",
            ".svg",
            ".webp",
            ".ico",
            ".woff",
            ".woff2",
            ".ttf",
            ".otf",
            ".bin",
        }:
            continue
        discovered.append("/" + rel)

    seen: set[str] = set()
    urls: list[str] = []
    for url in required + discovered:
        if url in seen:
            continue
        if url not in ("/",) and not (build_dir / url.lstrip("/")).is_file():
            print(f"[generate_offline_sw] WARN missing required file: {url}", file=sys.stderr)
            continue
        seen.add(url)
        urls.append(url)
    return urls


def stamp_version_json(build_dir: Path, cache_hash: str, precache_count: int) -> None:
    version_path = build_dir / "version.json"
    data: dict = {}
    if version_path.is_file():
        try:
            data = json.loads(version_path.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            data = {}
    data["build_hash"] = cache_hash
    data["built_at"] = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    data["precache_count"] = precache_count
    data["offline"] = True
    version_path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")


def main() -> int:
    if len(sys.argv) < 2:
        print("Usage: generate_offline_sw.py <build/web>", file=sys.stderr)
        return 2

    build_dir = Path(sys.argv[1]).resolve()
    main_js = build_dir / "main.dart.js"
    if not main_js.is_file():
        print(f"ERROR: missing {main_js}", file=sys.stderr)
        return 1

    cache_hash = short_hash(main_js)
    urls = discover_precache_urls(build_dir)
    sw_body = SW_TEMPLATE.replace("__CACHE_HASH__", cache_hash).replace(
        "__PRECACHE_URLS__",
        json.dumps(urls, indent=2),
    )
    sw_path = build_dir / "flutter_service_worker.js"
    sw_path.write_text(sw_body, encoding="utf-8", newline="\n")
    stamp_version_json(build_dir, cache_hash, len(urls))

    print(
        f"[generate_offline_sw] Wrote {sw_path.name} "
        f"cache={cache_hash} precache={len(urls)} urls"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
