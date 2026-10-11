# Technology stack

Provisional. No application code yet.

Element Deck is a Flutter app. There is **no Java service and no database we host**. **Firebase** stores the content pack and the record of who bought which package. **SQLite** on the device is the cache the rooms read, and the learner's own bookmarks and settings.

The UI shell still follows RxFolio: one Flutter codebase for phone, tablet, web, and desktop, with the same settings and theming shape.

## Client

**Flutter** app. One codebase for phone, tablet, web, and desktop.

| Target | Role |
| --- | --- |
| Android and iOS phones | Primary handheld. Bottom navigation. Store billing |
| Android and iOS tablets | Wide shell when the shortest side ≥ 600 and the width ≥ 900 |
| Web / PWA | Same wide shell, static hosting. Pack download and sign-in work. How a web visitor pays is still open |
| Windows, Linux, macOS | Same wide shell. Billing path follows the web decision |

| Choice | Why |
| --- | --- |
| Flutter | Same phone-and-desk targets as RxFolio |
| Dart 3, current stable Flutter | Current stable channel |
| Provider (or the same state approach RxFolio uses) | Theme, settings, current element, depth, entitlement |

The web app is the Flutter web build. It is not a second UI toolkit.

## On the device

| Store | Engine | What it holds |
| --- | --- | --- |
| Preview catalog | SQLite in the app bundle | H, C, Si, Ne, Ti, so the shell opens with no network |
| Content-pack cache | SQLite in the app documents directory | The downloaded pack, opened read-only |
| Learner | SQLite in the app documents directory | Preferences, bookmarks, recents, comparisons, progress, and a copy of the active entitlements |

SQLite access is **Drift**. On phones and desktops that is a native SQLite file. On web it is Drift's SQLite WASM. One schema for every target.

Preferences, including theme, live in the learner database.

## Firebase

One Firebase project. No custom server in front of it.

| Product | Use |
| --- | --- |
| Firebase Auth | Google sign-in. Required to buy, restore, and download the pack |
| Cloud Firestore | `packages`, `purchases`, `users`, content-pack metadata, and later class lists |
| Cloud Storage | The content pack file, `packs/core/{version}/catalog.sqlite` |
| Cloud Functions | One function: verify a Play or App Store receipt and write the purchase. The client cannot mark itself as paid |

Security rules:

- A signed-in user reads and writes only their learner documents.
- Purchase documents are created by the function, not by the client. The user may read their own.
- The pack object is readable only when the uid has an active package that includes `core`.

The catalog source in the repo is compiled into that SQLite file and uploaded. Do not scrape Wikipedia at runtime. A correction is a new pack version, not an app-store release, unless the shell itself changed.

## Billing

| Store | Role |
| --- | --- |
| Google Play Billing | Sells `element-deck` and `classroom` on Android |
| App Store | Sells the same product ids on iOS |
| Firebase | Records uid, package id, store, transaction id, status, time |

Restore purchases is a store API plus the same function. Web and desktop billing is open. See [open-questions.md](./open-questions.md).

## PDF, audio, fonts

| Piece | Where |
| --- | --- |
| Comparison dossier PDF | Rendered on device from the cached pack |
| Sonification | A short generated sine. No audio file per spectral line |
| Plus Jakarta Sans, JetBrains Mono | Bundled in the app, not in the content pack |

## Localization

Flutter `gen-l10n` (ARB) for chrome. English in v1. Teaching copy travels inside the content pack, with a locale on each label.

## Analytics

Off until a privacy note exists. The purchases collection is the commercial record. It is not a behavior tracker.

## Hosting

| Artifact | Where it lives |
| --- | --- |
| App binaries | The stores, or a direct install |
| Web shell | Static nginx on LXC 6101 (`elementdeck.<tailnet>`). See [pwa-lxc.md](./pwa-lxc.md) |
| Android release | Play internal track via `deployment/android/playstore/`. See [play-store.md](./play-store.md) |
| Content pack | Firebase Storage |
| Purchases | Firestore |
| Cached pack and learner data | The device |

## What this stack is not

- Not a Java or Spring Boot service.
- Not Postgres.
- Not a public URL for the paid SQLite file.
- Not RxFolio's clinical schema.
- Not an LLM service.

## First scaffold (when authorized)

1. Flutter shell: five rooms, phone nav, wide rail, theme provider.
2. Preview SQLite with H, C, Si, Ne, Ti. Learner SQLite for settings and bookmarks.
3. Firebase project: Auth, Firestore package and purchase documents, Storage slot for a fixture pack, and the receipt function sketched but not required to judge the rooms.
4. Download that fixture pack over the preview only after a mocked entitlement, and read the rooms from the cache.
5. Then fill the real pack with all 118 elements and connect Play Billing and the App Store.

Step 2 still comes first, so the screens can be judged before billing is live.
