# Object model

Provisional. No schema is implemented. Names here are the words the Flutter client, the SQLite files, and Firebase should share.

| Store | Lifetime | Where |
| --- | --- | --- |
| Preview catalog | Ships with the app | Read-only SQLite in the bundle. Five elements |
| Content pack | Published when we upload a new version | Firebase Storage. Cached as read-only SQLite on the device |
| Learner | This device, copied to the signed-in user | SQLite, and Firestore under `users/{uid}` |
| Commerce | As long as we keep the Firebase project | Firestore `packages` and `purchases` |

The pack is not user content. Learners bookmark and compare. They do not edit atomic mass. See [architecture.md](./architecture.md).

## Identity

**Atomic number Z** is the identity of an element. Symbol is a unique alias. Localized names are labels.

```text
Element id = Z          1 … 118
Isotope id = Z + A      mass number
Spectral line id        stable id from the source catalog, not a row index in a screenshot
```

Renaming a label ("sulfur" / "sulphur") does not mint a new element. A dataset update that corrects a measurement versions the **release**, not the element id.

## Catalog

### Element

| Field | Notes |
| --- | --- |
| z | 1–118, primary key |
| symbol | `Ti` |
| name | English IUPAC name. Other languages live on `Label` |
| atomicWeight | Standard atomic weight or the most stable mass, with `weightKind` so the UI does not pretend an interval is a single number |
| categoryId | Family used for color and chips |
| block | s, p, d, f |
| period | 1–7 |
| group | 1–18, null for the f-block rows that have no group |
| standardState | solid, liquid, gas, or unknown, at 298 K and 1 bar where that is defined |
| electronConfiguration | Full and noble-gas shorthand |
| shellCounts | Integer list for Beginner |
| commonOxidationStates | Ordered list, with `primary` flagged |
| summary | One line for the element-of-the-day card, per depth |

### Category

The chip and tile color. Fixed palette from [design-system.md](./design-system.md). Not a theme token.

| id | Examples | Accent |
| --- | --- | --- |
| alkali-metal | Li, Na | Amber |
| alkaline-earth | Be, Mg | Amber (same metal family hue; chip label distinguishes) |
| transition-metal | Ti, Fe, Au | Emerald |
| post-transition | Al, Sn | Rose |
| metalloid | B, Si | Indigo |
| reactive-nonmetal | H, C, N, O | Cyan |
| halogen | F, Cl | Cyan, with a halogen tag (filter can be narrower than the color family) |
| noble-gas | He, Ne | Violet |
| lanthanide | La row | Crimson |
| actinide | U | Crimson, separate chip |

Halogen is a **tag** on a reactive nonmetal so the color stays honest and the filter can still say Halogen. The benchmark colors fluorine as halogen and oxygen as nonmetal; both may share the nonmetal hue if we refuse two cyans. Open: whether halogens get a distinct accent. See [open-questions.md](./open-questions.md).

### Property

Repeated measurements, so we do not grow nullable columns without end.

| Field | Notes |
| --- | --- |
| elementZ | |
| kind | `covalent-radius`, `pauling-electronegativity`, `ionization-energy-1`, `melting-point`, `boiling-point`, `density`, … |
| value | Number |
| unit | SI unit of storage: pm, eV, K, g/cm³ |
| uncertainty | Optional |
| conditions | Optional ("graphite", "at 298 K") |
| sourceId | Dataset release |

Display units convert at the edge. Storage does not store °C.

### Structure and story

| Type | Role |
| --- | --- |
| Lattice | Crystal system and a short name ("hexagonal (HCP)") |
| Allotrope | Named form, optional preview asset id, which properties apply to it |
| Discovery | Year, names, paragraph |
| Application | Title, paragraph, asset id, sort order. A handful per element |
| Abundance | Crust / cosmic figure, unit, source. Optional in v1 |
| CurriculumBlurb | `depth` × paragraph. Three per element |
| TrendNote | Ordered pair (zA, zB), group or contrast label, essay, swap suggestions |

`TrendNote` is hand-written. The absence of a row is a normal state.

### Isotope

| Field | Notes |
| --- | --- |
| z, a | Identity |
| neutrons | a − z, stored so the UI does not re-derive wrongly for odd cases we have checked |
| massU | Optional |
| spin | Optional string, source notation |
| abundance | Mole fraction, optional |
| halfLife | Optional, with unit |
| decayMode | Optional |
| stability | `stable`, `trace`, `synthetic`, `primordial-radioactive` |
| note | Short chip line ("primary terrestrial", "stellar He burning") |

### SpectralLine

| Field | Notes |
| --- | --- |
| id | Source id |
| elementZ | |
| wavelengthNm | Air or vacuum, recorded in `medium` |
| frequencyHz | May be derived if the source gives wavelength only; flag `derived` |
| energyEv | Same rule |
| transition | Source notation, Advanced |
| spectrum | emission, absorption, or both |
| relativeIntensity | Optional, for which lines we plot |
| colorName | Optional teaching word ("visible red") |
| sourceId | |

The visible strip plots lines in range. It is a view, not a second table.

### AstrophysicalNote

Optional, per element or per line. Body, object name ("NGC 6543"), citation. A match percentage is allowed only with `method` text. Otherwise the field stays null and the UI omits the percent.

### ReactionIllustration

| Field | Notes |
| --- | --- |
| elementZ | The element this button hangs on |
| reactants, products | Display strings, pre-balanced |
| conditions | Short |
| blurbByDepth | Three captions or fewer |
| sourceId | A textbook-style citation, not a lab log |

### ContentPack

The file in Storage, plus its Firestore description.

| Field | Notes |
| --- | --- |
| id | `core` for the full table |
| version | Monotonic. The cache stores the version it opened |
| storagePath | `packs/core/{version}/catalog.sqlite` |
| sha256 | Checked before the cache is swapped |
| bytes | Shown on the download row |
| publishedAt | |
| sciencePins | Dataset ids included, such as `nist-asd-3.1` |

### DatasetRelease

| Field | Notes |
| --- | --- |
| id | `nist-asd-3.1`, `iupac-weights-2024`, … |
| title | Printed in the Spectra footer and the PDF |
| version | |
| retrievedOn | |
| licenseNote | What we are allowed to put in the pack |

Learner rows point at Z, never at a pack version, so a corrected radius does not orphan a bookmark.

### Package

| Field | Notes |
| --- | --- |
| id | `preview`, `element-deck`, `classroom` |
| title | Element Deck, Classroom |
| packIds | `element-deck` and `classroom` include `core`. Preview includes none |
| includesClassroom | True only for `classroom` |
| storeProductIds | Play and App Store ids |

### Purchase

| Field | Notes |
| --- | --- |
| id | Our id |
| uid | Firebase Auth uid. This is who bought it |
| email | Copied from the auth profile at verification time |
| packageId | Which package |
| store | `google_play` or `app_store` |
| storeProductId | |
| storeTransactionId | The store's id, unique |
| status | `active`, `refunded`, `expired` |
| purchasedAt | |
| verifiedAt | When the function accepted the receipt |

The client may read its own purchases. Only the receipt function creates or updates them.

### Label

`entity` + `entityId` + `locale` + `field` + `text`. Used for names, blurbs, discoveries, applications, trend essays. Symbols and numbers are not labels.

## Learner

### Profile

`users/{uid}`: Firebase uid, display name, email, persona. The same persona is cached in the learner database. Element Deck does not collect a password.

### UserPreferences

One row in the learner database, and the same keys under the user in Firestore when signed in. See [settings-and-theming.md](./settings-and-theming.md). Preferences are not catalog data.

### Bookmark

`(z, createdAt)` locally, and under the uid when signed in. Merge across devices is the union of Z.

### RecentElement

A short ring. Cap at 20. Used by Spectra chips and Compare suggestions. Copied with the rest of the learner data when signed in.

### SavedComparison

`(zA, zB, displayOrder, createdAt)`. Unordered for identity (`6,14` is the same pair either way) but **display order** is stored so carbon stays on the left if the learner put it there.

### ProgressEvent

Optional and quiet. `opened-details`, `switched-depth`, `played-tone`, `exported-pdf`, with Z and timestamp. It does not show a score. It is not the purchase record.

### Entitlement cache

The learner database stores the last verified package ids and the cached pack version, so airplane mode knows the pack is allowed. The source of truth remains Firestore. A refund applies the next time the app can reach Firebase.

### DevicePreferences

Theme and glass are rows in the learner database and sync with the other preferences when signed in. A "this device only" lock can keep a classroom tablet on Chalk. See [open-questions.md](./open-questions.md).

## Classroom

The Classroom package. The class list is Firestore. The science is the same content pack every other buyer downloads.

| Type | Role |
| --- | --- |
| Classroom | Name, owner uid, join code |
| Membership | Uid, role `educator` or `learner` |
| Assignment | Optional pinned Z list, suggested depth, title, due date optional |

Assignments suggest. They do not lock depth and they do not hide rooms. They do not by themselves grant the content pack. Whether a Classroom purchase covers every joined learner, or each learner buys Element Deck, is open. See [open-questions.md](./open-questions.md).

## Relationships

```text
Element ── category, block, period, group
Element ── many Property, Isotope, SpectralLine, Application, CurriculumBlurb
Element ── optional Discovery, Lattice, ReactionIllustration, AstrophysicalNote
TrendNote ── two Elements
Purchase ── User × Package
ContentPack ── included by Package
Assignment ── Classroom × many Elements
Bookmark, Recent ── User × Element
SavedComparison ── User × two Elements
```

Cards in the UI are views. The only first-class science object the learner "has" is a bookmark or a saved pair.

## Epistemic kinds

Every user-visible sentence has a kind so the UI can keep them apart:

| Kind | Examples |
| --- | --- |
| measurement | 1,668 K, 585.25 nm |
| classification | transition metal, hexagonal |
| teaching | curriculum blurb, trend essay, glow sentence |
| illustration | reaction animation, sonified tone, orbital diagram |
| status | dataset version, "not reported" |

Kinds are not a separate database if the table already implies them. They are a rule for writers and for the PDF: teaching paragraphs sit under a heading, measurements sit in the grid.

## v0 freeze

Before scaffolding, freeze:

1. The property `kind` list the four screens need.
2. Whether halogen is a tag or its own color.
3. The curated `TrendNote` pairs for v1.
4. The dataset releases we are allowed to bundle.

Until that list is written down, do not generate 118 JSON files by scraping a page into the repo.
