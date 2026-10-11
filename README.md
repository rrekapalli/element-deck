# Element Deck

A periodic-table explorer that teaches every element at three depths — Beginner, Intermediate, and Advanced — in five rooms: **Table**, **Details**, **Compare**, **Spectra**, and **Quiz**.

The app is a Flutter client for phone, tablet, web, and desktop. Firebase stores the full content pack and who bought which package. The app caches that pack in SQLite and reads it locally. There is no custom API. Settings, appearance, and the wide layout follow the same product shape as [RxFolio](https://github.com/rrekapalli/Hi-Doc).

The concept screens still show an older wordmark, ATOMIQ. The product name is Element Deck.

**Status:** Flutter app in this repo. Preview catalog (H, C, Si, Ne, Ti) is bundled. The 118-element pack is `assets/catalog/core.json` and `catalog/output/catalog.sqlite` for Firebase Storage.

```bash
flutter pub get
flutter test
flutter run
# Full pack without the store (debug only):
flutter run --dart-define=DEBUG_ENTITLEMENT=true
```

Firebase: deploy rules and `firebase/functions`, upload `catalog/output/catalog.sqlite` to `packs/core/1.0.0/catalog.sqlite`, and seed `packages` / `contentPacks` from `firebase/seed/packages.json`. Configure `google-services` / `GoogleService-Info` and `firebase_options.dart` for a real project. Preview works without Firebase.

Read [Docs/README.md](Docs/README.md) for the product notes.

## Host the PWA

The web build deploys to an nginx LXC (VMID 6101) with Tailscale Funnel, same pattern as the other apps. Copy `.env.example` to `.env`, then from PowerShell:

```powershell
.\deploy.ps1
```

Open `https://elementdeck.tailce422e.ts.net/` on a phone or tablet. Details are in [Docs/pwa-lxc.md](Docs/pwa-lxc.md).

## Google Play

```powershell
.\deployment\android\playstore\scripts\create-upload-keystore.ps1
.\deployment\android\playstore\scripts\build-release-aab.ps1
```

Package name `com.vislesha.element_deck`. Details are in [Docs/play-store.md](Docs/play-store.md).

