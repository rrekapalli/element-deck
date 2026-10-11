# Firebase seed

After you create the Firebase project:

1. Deploy `firestore.rules`, `storage.rules`, and `functions`.
2. Write `packages/element-deck`, `packages/classroom`, and `contentPacks/core` from `packages.json`.
3. Upload `catalog/output/catalog.sqlite` to Storage path `packs/core/1.0.0/catalog.sqlite`.
4. Confirm the `sha256` field matches the uploaded file.
