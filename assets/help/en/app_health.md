# App Health

![App Health](asset:assets/help/images/app_health.png)

Callouts: **on-device catalog** · **content pack cache** · **Firebase** · **purchases**.

## Purpose

App Health answers whether this device can show the table, and from which copy of the data. Open it from **Settings**. It does not change settings. It reports them.

The science rooms open from the on-device catalog even when the network is down. Download, purchase, and restore wait until the network and the store answer.

## Checks

- **On-device catalog** — how many elements are loaded, and the pack version string.
- **Content pack cache** — **using bundled file** means the preview catalog that shipped inside the app. Otherwise it names the version that was loaded from the cache.
- **Firebase** — **configured** when sign-in and the pack service are available. **not configured · preview still works** means the rooms can keep using the bundled catalog.
- **Purchases** — the package names on this account, or **none**.

A cached pack that fails its checksum is discarded and has to be downloaded again from **Account settings**.

## Try this

1. Read **On-device catalog** and note the element count.
2. Read **Content pack cache**. **using bundled file** means you are still on the preview.
3. If Firebase says it is not configured, confirm that Table still opens. It should.

---

*Element Deck explains published elemental data for learning. It is not a lab measurement, a specification for engineering or medicine, or a substitute for the cited dataset.*
