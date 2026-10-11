# Architecture

Provisional shape. No implementation at inception.

Element Deck is a Flutter app with **no custom API and no server we operate**. Firebase is part of the product. It does two jobs:

1. **Purchases.** Who bought which package, verified against the store.
2. **Content.** The full element pack lives in Firebase Storage. The app downloads it and caches it in SQLite.

SQLite on the device is what the rooms read. Firebase is where the pack is published and where a purchase is recorded.

## System sketch

```text
┌────────────────────────────────────────────┐
│ Flutter UI                                 │
│  Phone shell │ Wide shell                  │
│  Theme · Depth · Current element · Pair    │
└────────────────────┬───────────────────────┘
                     │ reads
        ┌────────────┴────────────┐
        │                         │
  Catalog SQLite            Learner SQLite
  (cache of the pack)       (this device)
        ▲
        │ download once, then offline
        │
┌───────┴────────────────────────────────────┐
│ Firebase                                   │
│  Auth          who this person is          │
│  Firestore     packages, purchases,        │
│                pack metadata, classes      │
│  Storage       the content pack file       │
│  Function      verify the store receipt    │
└────────────────────────────────────────────┘
        ▲
        │ the store charges the buyer
 Google Play / App Store
```

## Content pack

The **content pack** is one versioned SQLite file: all 118 elements, properties, isotopes, spectral lines, teaching copy, and the media the dossiers need.

| | |
| --- | --- |
| Published | Firebase Storage, path `packs/core/{version}/catalog.sqlite` |
| Described | Firestore `contentPacks/core`: version, checksum, byte size, published time |
| Used | Copied into the app's documents directory and opened read-only |

Rooms query the local file. They do not query Firestore for a melting point or a wavelength.

A new pack version is uploaded to Storage and the Firestore record is updated. The app downloads it when the signed-in user is online and replaces the cache only after the checksum matches. An open comparison keeps the previous file until the learner leaves the room.

The app binary still contains a **preview** catalog (H, C, Si, Ne, Ti) so the shell can open before a purchase and without a network. The preview is not the content pack.

## Packages and purchases

A **package** is what a person buys. A **purchase** is the record that they did.

| Package | Unlocks |
| --- | --- |
| Preview | Free. The five bundled elements. No purchase record |
| Beginner, Intermediate, Advanced | Independent course packs. One sqlite file; the client shows owned depths |

The ids are `pack-beginner`, `pack-intermediate`, `pack-advanced`. A legacy `element-deck` receipt unlocks all three.

Firestore holds:

| Collection | Document |
| --- | --- |
| `packages/{packageId}` | Title, which pack ids it includes |
| `purchases/{purchaseId}` | `uid`, `packageId`, store, store product id, store transaction id, `active` / `refunded` / `expired`, purchased time, verified time |
| `users/{uid}` | Email, display name, persona. Written at sign-in |

The store takes the payment. A Firebase Cloud Function checks the receipt and writes the purchase. The client does not grant itself a package. Restore purchases asks the store, then the function reconciles Firestore.

Storage rules allow a download of `packs/core/` only when that uid has an active purchase of a package that includes `core`. The file is not public.

Sign-in is Firebase Auth with Google. Element Deck does not collect a password. Buying requires a signed-in account so the purchase can be tied to a person and restored on another device.

## What works offline

| Data | After it is on the device | Before that |
| --- | --- | --- |
| Preview elements | Always, from the app binary | — |
| Full content pack | Yes, from the SQLite cache | Needs the network once, and an active course pack |
| Theme, depth, bookmarks, pairs | Yes, learner SQLite | — |
| New purchase or restore | No | Needs the store and Firebase |
| A newer pack | Keeps the cached pack | Downloads when online |

There is no full-page wall in front of the preview. The full table, when the pack is not cached yet, explains that and offers download or purchase. A cached pack opens in airplane mode.

If the cached pack fails its checksum, delete it and download again. Do not render a half-written file.

## Learner rows

Preferences, bookmarks, recents, and saved comparisons stay in the learner SQLite so the rooms stay fast. When the user is signed in, those rows also copy to `users/{uid}/...` in Firestore so a second device can restore them. Bookmarks merge by atomic number. Preferences use the later timestamp.

Erase on this device clears the local learner database and the pack cache. Delete account removes the Firestore user documents and the purchase records only through the store's refund path plus our status update. A purchase is not deleted by "erase this device."

## Client modules

| Module | Responsibility |
| --- | --- |
| Shell | Phone nav, wide rail, routes |
| Catalog | Open the preview or the cached pack |
| Packs | Download, checksum, swap the cache |
| Purchases | Read entitlements, start a store purchase, restore |
| Learner | Preferences, bookmarks, recents, comparisons |
| Rooms | Table, Details, Spectra, Quiz |
| Theme | Presets, glass, family colors |
| Account | Firebase Auth, export, erase |

## Search

Query the local catalog SQLite. The full index exists only after the pack is cached. Preview search covers the five bundled elements.

## Privacy

- The content pack contains no personal data.
- Purchases store the Firebase uid, the email on the auth profile, the package id, and the store transaction id. That is the record of who bought what.
- A user can read their own purchases. They cannot list someone else's.
- Export of learner data does not include other buyers.

## Relationship to RxFolio

Reuse the shell: Flutter targets, wide layout, Settings, App settings, Account settings, theme mode, color presets, glass. Do not reuse the Java API. Firebase replaces that role for purchases and for the content pack.

## Why this stays small

One pack file. One purchases collection. One function that trusts the store receipt. The rooms keep reading SQLite.
