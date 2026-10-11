# Open questions

Refinement list. Do not block the concept on answers. Do not write application code to dodge these.

## Product

- The product name is **Element Deck**. The concept PNGs still say ATOMIQ; that wordmark is retired. Closed.
- Four rooms and three depths are the product. Closed.
- The preview opens with no account and no network. The full pack is a purchase plus a download, then offline from the cache. Closed.
- Packages are `preview`, `element-deck`, and `classroom`. Prices are open. Closed as the set.
- A purchase is recorded in Firestore only after a Cloud Function accepts the store receipt. The client cannot grant itself a package. Closed.
- v1 has no chat tutor, no quiz, no general reaction solver. Closed.
- Classroom is later, and not for minors until the terms exist. Closed as sequencing. The terms themselves are open.
- Store-listing collision check for "Element Deck" before release. Open.

## Science content

- Freeze the property `kind` list, the v1 `TrendNote` pairs, and the dataset licenses before generating the full catalog. Open until that list is written.
- Halogen: a tag on the nonmetal color, or its own accent? The PNGs call fluorine a halogen. Open.
- Standard atomic weight versus a single representative isotope on the header. The screens show one number. The model has `weightKind`. Open how the header reads when IUPAC gives an interval.
- Fraunhofer "99.4%" on the neon concept: define the method or drop the percent. Open, defaulting to drop if the method is not real.
- Which single `ReactionIllustration` exists per element, and which elements have none. Open.
- Sonification divisor (power of ten into ~200–800 Hz). Open the exact divisor; closed that the UI must say "sonified."
- Light theme hex values. Closed that Chalk is a designed preset and that family colors survive it. Open the actual ramp.
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
- Web and desktop billing (the stores cover Android and iOS). Open.
- Whether a Classroom purchase covers every joined learner, or each learner also buys Element Deck. Open.
- Web SQLite package. Closed as "same schema via WebAssembly." Open the library at scaffold time.
- Catalog corrections ship as a new pack version, not as an app update, unless the shell changed. Closed.

## Next refinement sessions

1. Walk the four PNGs and list every number they print. That list becomes the v0 property kinds and the fixture elements (H, C, Si, Ne, Ti).
2. Decide halogen color and the atomic-weight header.
3. Choose the first curated comparison pairs and the first reaction illustrations.
4. Scaffold the shell on the preview SQLite, then a Firebase fixture pack and a mocked entitlement.
