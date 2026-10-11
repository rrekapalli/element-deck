# Open questions

Refinement list. Do not block the concept on answers. Do not write application code to dodge these.

## Product

- The product name is **Element Deck**. The concept PNGs still say ATOMIQ; that wordmark is retired. Closed.
- Four rooms (Table, Details, Spectra, Quiz) and three depths are the product. Closed.
- The preview opens with no account and no network. The full pack is a purchase plus a download, then offline from the cache. Closed.
- Packages are `preview`, `pack-beginner`, `pack-intermediate`, and `pack-advanced`. Each course is ₹199. Closed.
- A purchase is recorded in Firestore only after a Cloud Function accepts the store receipt. The client cannot grant itself a package. Closed.
- v1 has no chat tutor and no general reaction solver. Quiz is a room with on-device XP and streak. Closed.
- Store-listing collision check for "Element Deck" before release. Open.

## Science content

- Freeze the property `kind` list, the v1 `TrendNote` pairs, and the dataset licenses before generating the full catalog. Open until that list is written.
- Halogen is a **tag** on the reactive-nonmetal color. The chip still says Halogen. Closed.
- The header shows **one** atomic-weight number. `weightKind` records whether it is a standard weight or a representative isotope. An IUPAC interval is an Advanced disclosure. Closed.
- Fraunhofer match percentages do **not** ship. Closed.
- Which single `ReactionIllustration` exists per element, and which elements have none. Open until the pack is written; omit the button when none.
- Sonification divisor is **10^12** (`audibleHz = lineFrequencyHz / 1e12`). The button still says sonified. Closed.
- Light theme hex values. Closed that Chalk is a designed preset and that family colors survive it. Dark Obsidian Orbit is the first pixel target. The Chalk ramp is designed after the dark phone screens match.
- Element-of-the-day timezone: the device's local civil date. Closed unless testing shows classroom confusion across a timezone boundary. A traveling student seeing a different element than their class is acceptable.

## Shell and settings

- Dark is the default theme so the first launch matches the PNGs. Closed.
- Glass on for native, off for web, with a switch. Closed.
- Chrome themes do not recolor families. Closed.
- Language split: UI / Explanations / All. English only in v1. Closed. The date of Hindi and the other RxFolio languages is open.
- Whether a later synced theme should let a classroom tablet stay on Chalk while a phone stays dark. Open. v1 is device-local, so the question waits.
- Keyboard map on desktop. Proposed in [wide-layout.md](./wide-layout.md). Open to tweak, not to delete.

## Architecture

- Flutter app. No custom API and no database we host. Closed.
- Firebase Auth, Firestore, Storage, and one receipt function. Closed.
- The content pack is a SQLite file in Storage. The rooms read a local cache. Closed.
- Purchases store uid, package id, store, transaction id, status, and time. Closed.
- Preview of H, C, Si, Ne, Ti stays in the app binary. Closed.
- Web and desktop can sign in and download a pack the account already owns. Selling on web and desktop waits. Android and iOS use the stores. Closed.
- Each learner buys the course packs they need. Owning one pack does not include the others. Closed.
- SQLite access is **Drift**, with the web build on Drift's SQLite WASM. One schema for phone, desktop, and web. Closed.
- Catalog corrections ship as a new pack version, not as an app update, unless the shell changed. Closed.

## Next refinement sessions

1. Walk the four PNGs and list every number they print. That list becomes the v0 property kinds and the fixture elements (H, C, Si, Ne, Ti).
2. Decide halogen color and the atomic-weight header.
3. Choose the first curated comparison pairs and the first reaction illustrations.
4. Scaffold the shell on the preview SQLite, then a Firebase fixture pack and a mocked entitlement.
