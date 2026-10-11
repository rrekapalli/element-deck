# Google Play

Signed release AABs for `com.vislesha.element_deck`, following the same keystore and Play Developer API flow as RxFolio. The scripts live in `deployment/android/playstore/`.

In-app product ids the client queries:

- `pack-beginner`
- `pack-intermediate`
- `pack-advanced`

Create those as one-time products in Play Console before a purchase test. Set the price to ₹199. The app shows the store's price string. A legacy `element-deck` receipt still unlocks all three courses.

Create those as one-time products in Play Console before a purchase test. The PWA does not sell them. Web tells the person to buy on Android or iOS.

## Once

1. Create the Play app with package name `com.vislesha.element_deck`.
2. Create the upload keystore. This writes `android/upload-keystore.jks` and `android/key.properties` (both gitignored).

```powershell
.\deployment\android\playstore\scripts\create-upload-keystore.ps1
```

```bash
./deployment/android/playstore/scripts/create-upload-keystore.sh
```

3. Print the certificate fingerprints and add the SHA-1 to the Firebase Android app (package `com.vislesha.element_deck`).

```powershell
.\deployment\android\playstore\scripts\print-signing-fingerprints.ps1
```

4. Put `google-services.json` at `android/app/google-services.json`. The AAB still builds without it. Sign-in and receipt checks need it.
5. Enroll Play App Signing. After the first upload, add the **Play App Signing** SHA-1 in Firebase as well as the upload certificate.

Back up the `.jks` and its passwords outside the repo. A new upload key cannot update an app that already shipped with the old one.

## Build

Release builds read `android/key.properties`. When that file is absent, Gradle still signs with the debug key so a local release run works. Do not upload a debug-signed AAB.

```powershell
.\deployment\android\playstore\scripts\build-release-aab.ps1
```

```bash
./deployment/android/playstore/scripts/build-release-aab.sh
```

Outputs:

- `build/app/outputs/bundle/release/app-release.aab`
- `deployment/android/playstore/artifacts/element-deck-<version>-release.aab`

The build obfuscates Dart and writes split debug info under `build/debug-info` (gitignored with the rest of `build/`).

Upload that AAB to **Testing → Internal testing** in Play Console, or use the API below.

## Listing and API upload

Store copy is in `deployment/android/playstore/listing/metadata/android/en-US/`. `listing/listing.json` sets the package name and the public PWA URL as the contact website. Set a real contact email and privacy-policy URL in that JSON before a production release. Internal testing can start from the console without them.

Screenshots: drop PNGs into `deployment/android/playstore/listing/source-screenshots/` using the names in `listing/screenshot-map.json`, then:

```powershell
.\deployment\android\playstore\scripts\prepare-play-listing.ps1
```

That needs Pillow (`pip install Pillow`).

To upload the AAB and the listing text, copy `env.release.example` to `.env.release` in the playstore folder and set `PLAY_SERVICE_ACCOUNT_JSON` to a Play Console service-account key. The account needs permission to release the app. Then:

```powershell
pip install google-auth
.\deployment\android\playstore\scripts\build-release-aab.ps1 -UploadToPlay
```

```bash
./deployment/android/playstore/scripts/build-release-aab.sh --upload
```

The default track is `internal`. Override with `PLAY_TRACK` in `.env.release`, or:

```powershell
.\deployment\android\playstore\scripts\upload-play-release.ps1 -Track internal -Aab deployment\android\playstore\artifacts\element-deck-0.1.0-1-release.aab
```

`--listing-only` / `-ListingOnly` updates copy without a new AAB. `-DryRun` checks title and description lengths and does not call Play.

Data safety and the content rating stay in Play Console. The script does not submit them.
