# Settings and theming

Element Deck splits settings the way RxFolio does. The science rooms stay in the bottom nav (or the wide rail). Account, appearance, and device behavior live under **Me**.

RxFolio reference (behavior to mirror, not screens to copy):

- Settings hub, then **App settings** and **Account settings**
- Theme mode Light / Dark / System
- Color presets plus Custom (hue, saturation, brightness)
- Frosted glass as a switch on top of any preset, not as a preset of its own
- Language applied to UI, to explanatory text, or to both
- Preferences in the on-device learner SQLite database, copied to Firebase when signed in
- Help articles for each settings page
- About: version, disclaimer, privacy, terms
- App Health: local cache, Firebase, and the content pack

The visual skin is [Obsidian Orbit](./design-system.md). RxFolio's Ocean Blue palette is not imported. Sign-in is Firebase Auth with Google. Element Deck does not collect a password.

## Where Me sits

| Form factor | Entry |
| --- | --- |
| Phone | Header **Me** on every room. Also listed at the bottom of Settings only after you are inside |
| Wide | **Settings** pinned to the bottom of the nav rail, same as RxFolio. The header Me icon is omitted so it is not duplicated |

**?** sits in the room header, where the filter control was. It opens the guide for the current page. Category chips on Table still filter the registry. Help is not a science room.

## Settings hub

Purpose: who is signed in, which package they own, appearance, the content pack, legal.

### Who is signed in

| State | Shows |
| --- | --- |
| Signed in | Name, email, and the course packs they own |
| Signed out | **Sign in with Google**. Preview elements still open. Buying and the full pack need an account |

### Rows

| Row | Opens |
| --- | --- |
| Account settings | Purchases, restore, export, erase, sign out |
| App settings | Language, appearance, learning, units, sound, motion |
| App Health | Pack cache, Firebase, learner database |
| Help | Room and settings articles |
| About | Version, educational disclaimer, privacy, terms |

The current element is a navigation fact, not an account fact.

## Account settings

Purpose: the buyer, their packages, and this device's copy of their data.

Signed in:

- Name, email, **Signed in with Google**
- **Packages** — each active purchase: name, store, date. Empty state offers **Buy Element Deck**
- **Restore purchases** — asks the store, then Firebase reconciles
- **Content pack** — cached version, or **Download** when a package includes it and the file is missing
- **Privacy** and **Terms**
- **Export my learner data** — JSON of preferences, bookmarks, and comparisons. Purchases stay in Firebase
- **Sign out** — keeps the local cache. The pack stays until erased
- **Erase this device** — requires typing `DELETE`. Clears the learner SQLite and the pack cache. Does not refund and does not delete the purchase record

Signed out:

- **Not signed in**
- **Sign in with Google**
- Preview still works

## App settings

Purpose: how Element Deck looks, reads, and sounds on this device. Reminder-style medication toggles from RxFolio do not apply. Nothing here is a notification permission except the optional element-of-the-day notice below.

### Language

Locales: English first. The intended later set matches RxFolio's shipped UI languages: Hindi, Bengali, Tamil, Telugu, Marathi. v1 can ship English only if the string table is structured for the rest.

Apply to:

| Choice | Affects |
| --- | --- |
| UI | Chrome, settings, room names, buttons |
| Explanations | Curriculum blurbs, discovery, applications, trend essays, glow sentences |
| All | Both |

Symbols, Z, and units do not go through translation. Help articles load in the UI language when a translation exists, otherwise English.

### Appearance

| Control | Options | Default |
| --- | --- | --- |
| Theme | Light, Dark, System | Dark, so a new install matches the concept screens. System is one tap away |
| Color theme | Obsidian Orbit, Deep Sea, Graphite, Chalk, Custom | Obsidian Orbit |
| Custom color | Hue, saturation, brightness, Cancel / Apply | — |
| Frosted glass | On or off | On for Android, iOS, and desktop. Off for web |
| Reduce glow | On or off | Off. On forces glow shadows off even when glass is on |

**Color themes recolor chrome only:** canvas, surfaces, primary action, focus ring. They do not recolor element families, emission lines, or the neon discharge swatch.

| Preset | Intent |
| --- | --- |
| Obsidian Orbit | The concept. Deep blue-black, cyan action |
| Deep Sea | Cooler, more teal chrome, for people who want less cyan in the buttons while cyan tiles stay cyan |
| Graphite | Neutral dark chrome, family colors do all the work |
| Chalk | The light preset. Used with Theme = Light, and available if someone wants light surfaces while Theme is Light |
| Custom | Seed color through the same chrome roles |

Chalk is the named light preset so Light is designed, not an automatic inversion of Obsidian with unreadable grey type. If Theme is Dark and the learner picks Chalk, switch theme to Light. If Theme is Light and they pick Obsidian Orbit, switch theme to Dark. Tell them in one line on the card. Do not leave white type on white.

Preview chips on the appearance page show a mini tile for titanium (or the current element) **in its real family color** on the candidate chrome, so it is obvious the metal stays emerald.

Glass:

- On: blur and translucency per [design-system.md](./design-system.md).
- Off: opaque surfaces, same layout.
- Web default off, because full-screen blur on the table is a known cost. The learner can turn it on.
- Reduce glow is independent. A learner can keep glass and drop the ionization halo.

### Learning

| Control | Options | Default |
| --- | --- | --- |
| Starting depth | Beginner, Intermediate, Advanced | From persona: Student and Educator Intermediate, Enthusiast Advanced. Signed-out: Intermediate |
| Element of the day notice | On or off | Off. When on, one local notification at a learner-chosen time. The catalog does not need the network for the element itself |

The in-app Complexity control writes this same preference.

### Units and notation

Stored values stay SI. These switches affect display.

| Control | Options | Default (matches the PNGs) |
| --- | --- | --- |
| Temperature | K, °C | K |
| Energy | eV, kJ/mol | eV |
| Length | pm, Å | pm |
| Configuration | Noble-gas shorthand, full | Shorthand at Intermediate and Advanced. Beginner always shows shell counts regardless |
| Names | IUPAC English, plus a regional spelling preference only where labels exist | IUPAC |

Mass stays in u. Wavelength stays in nm. Do not offer a "hide units" mode.

### Spectra and motion

| Control | Default |
| --- | --- |
| Sonification | On |
| Reduced motion | Follows the OS setting, overridable |

Sonification off removes the tone and keeps the Listen row visible as "Sound is off in App settings," so a classroom tablet does not look broken.

### What is not in App settings

- Category colors. Those are data.
- A "simple mode" that deletes Spectra. Depth already changes vocabulary. Rooms stay.
- Backend AI, heuristics, or an on-device model. v1 has no parser and no tutor. Do not reserve three mysterious switches.

## App Health

| Check | Meaning |
| --- | --- |
| Preview | The bundled five-element file opened |
| Content pack | Cached version and checksum, or "not downloaded" |
| Firebase | Auth and Firestore reachable, and the published pack version |
| Purchases | Last time receipts were verified, and which packages are active |
| Learner | Local database opened, and when it last copied to Firebase |

The preview rooms open even when Firebase is down. The full pack opens from the cache when Firebase is down. Download, purchase, and restore wait until Firebase and the store answer. A cached file that fails its checksum is deleted and must be downloaded again. See [architecture.md](./architecture.md).

## About and help

About shows the app version, a one-line educational disclaimer (this is a learning instrument, not a laboratory report or medical or industrial specification), Privacy, and Terms.

Help articles, English first:

| Article | Covers |
| --- | --- |
| Table | Search, family chips, periodic table, registry |
| Details | Identity, Details / Properties / History / Uses / Neighbors, simulate |
| Neighbors | Pair, computed deltas, trend, PDF |
| Spectra | Emitter, strip, sonification, isotopes |
| Settings | This hub |
| Account settings | Sign-in, packages, restore, erase |
| App Config | Learning mode, appearance, units, sound |
| App Health | Catalog, pack cache, Firebase, purchases |
| About | Disclaimer |

Screenshots in `assets/help/images/` are captures from the Android emulator. Regenerate them when the room layout changes.

## Preference persistence

Theme and the other App settings are rows in the learner SQLite database, written as soon as they change. When the user is signed in, the same keys copy to Firestore. The content pack is never written by settings. Purchases are never written by the client.

| | Learner SQLite | Firebase |
| --- | --- | --- |
| Preferences, bookmarks, pairs | Working copy | Copy under `users/{uid}` when signed in |
| Content pack | Cache | Source file in Storage |
| Purchases | Cached entitlement only | Source of truth, written by the receipt function |
| Sign out | Keep the local database and the pack cache | Stop copying |
| Fresh install | Preview catalog and default theme | Pull preferences and the pack after sign-in if a package is active |

Keys should be stable string names, versioned when a default migration is required (RxFolio's glass-default migrations are the pattern: one-shot flags, never a silent change on every launch).

Suggested groups:

```text
appearance.themeMode          dark | light | system
appearance.colorTheme         obsidianOrbit | deepSea | graphite | chalk | custom
appearance.customSeed         ARGB int
appearance.frostedGlass       bool
appearance.reduceGlow         bool
learning.depth                beginner | intermediate | advanced
learning.elementOfDayNotify   bool
units.temperature             K | C
units.energy                  eV | kJ/mol
units.length                  pm | angstrom
units.configuration           shorthand | full
spectra.sonification          bool
motion.reduced                bool | system
locale.ui
locale.explanations
locale.apply                  ui | explanations | all
persona
```

These keys are columns or a key-value table in the learner database, and the same names in Firestore. The content pack never reads them.

## Theming implementation rules

When the Flutter theme is built:

1. Start from the active color preset and brightness. Produce canvas, surfaces, on-surface, primary, outline.
2. Apply glass as a component property (`ElementDeckColors.glass`), not as a second `ThemeData` that changes primary.
3. Inject the family palette as a constant `ElementSpectrum` inherited widget. Widgets that draw tiles read that, never `ColorScheme.primary`, for symbols.
4. Emission colors come from the spectral line or a small named glow map (`neon-discharge`), not from `ElementSpectrum`.
5. Status colors (error, success on "stable" isotope chips) are semantic and must pass contrast on both Light and Dark. Stable can be the tertiary green from the token sheet. Synthetic / radioactive uses the error container. Trace uses a muted warning.
6. Nav, settings, and buttons use `ColorScheme`. Tiles, chips, compare accents, and the matrix use `ElementSpectrum`.
7. Custom seed generates the chrome ramp the way RxFolio's custom seed does. It does not generate eighteen family colors.

Contrast: body text on canvas meets WCAG AA in both themes. Family-colored symbols on tiles must still be readable; if a preset lightens the tile too much, the tile surface stays a step darker than the canvas even in Chalk. Do not put amber type on a pale yellow tile.

## Educational disclaimer

Settings, About, PDF export, and Help share one disclaimer:

> Element Deck explains published elemental data for learning. It is not a lab measurement, a specification for engineering or medicine, or a substitute for the cited dataset.

PDF footers repeat the dataset release ids used on that page.
