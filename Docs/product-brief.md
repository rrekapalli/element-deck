# Product brief

**Product:** Element Deck  
**Status:** inception  
**Client:** Flutter (Android, iOS, web/PWA, Windows, Linux, macOS) — same targets as [RxFolio](https://github.com/rrekapalli/Hi-Doc)  
**Data:** Firebase for purchases and the content pack. SQLite on the device as the cache the rooms read. No custom API  
**Code:** none yet  
**Visual benchmark:** [concept screens](./README.md#element-deck-docs). The PNGs still say ATOMIQ; the product name is Element Deck.

## Problem

Students, teachers, and curious adults meet the periodic table as a poster, a textbook table, or a long article. The poster has no depth. The article has no sense of what to skip. Almost none of them put a neighbor comparison and a real spectrum next to the element, on both a phone and a classroom screen, with the same settings and theme model a finished app already uses.

People currently split this across:

- a wall chart or a grid app, for symbols
- a textbook chapter, for the exam list
- Wikipedia or a vendor table, for numbers
- a separate spectroscopy applet, if they ever see lines at all

Nothing remembers the depth they were reading at, the pair they were comparing, or the units their syllabus uses.

## Product

**Element Deck** is a periodic explorer. The learner opens an element, chooses a depth, and moves among four rooms: **Table**, **Details**, **Spectra**, and **Quiz**. Neighbors is a tab on Details.

The app shell is Flutter. A small preview catalog (hydrogen, carbon, silicon, neon, titanium) ships inside it so the rooms can open immediately. The **full content pack** — all 118 elements — is a SQLite file in Firebase Storage. After a person buys a package, the app downloads that file and reads it locally.

Firebase Auth identifies the buyer. Firestore records **who bought which package**. A Cloud Function checks the store receipt. There is no API of our own to deploy.

Bookmarks, depth, and theme live in a learner SQLite database on the device and copy to that user's Firebase account when they are signed in. See [architecture.md](./architecture.md).

## Users and personas

The catalog does not change. The job does.

| Persona | Entry | Success looks like |
| --- | --- | --- |
| Student | "What is titanium?" or a syllabus element | They can say what it is, where it sits, and one reason it differs from a neighbor, at their depth |
| Educator | A class set, projected on a tablet or the web | The same element reads clearly at the front of the room, and each student can drop to Beginner or rise to Advanced |
| Enthusiast | Curiosity, a glow, a congener pair | They can wander the table, save comparisons, and trust the numbers |

Personas weight copy, the default depth, and the home hint. They do not fork the schema. Details are in [personas.md](./personas.md). Narratives are in [use-cases/](./use-cases/README.md).

## Rooms

| Room | Job | Concept |
| --- | --- | --- |
| Table | Find an element and see its family | [screen 1](./concept-images/screen1/screen.png) |
| Details | Read the dossier at the current depth | [screen 3](./concept-images/screen3/screen.png) |
| Spectra | See and hear the light; read isotopes | [screen 4](./concept-images/screen4/screen.png) |

Phone: bottom navigation, one room at a time. Tablet and web: nav rail, list plus bench. See [app-ui.md](./app-ui.md) and [wide-layout.md](./wide-layout.md).

## Depths

Complexity is global, visible, and switchable on Table and Details. It is also the default in App settings.

| Depth | What leads | Who it fits | Product |
| --- | --- | --- | --- |
| Beginner | Shell count, everyday state, uses, valency in words | CBSE Classes 8–10 | `pack-beginner`, ₹199 |
| Intermediate | Noble-gas configuration, oxidation states, trends, JEE exceptions on the element | Classes 11–12 and JEE | `pack-intermediate`, ₹199 |
| Advanced | Z_eff, spectral assignments, isotopes and decay, trend-break reasoning | Undergraduate periodic-table study | `pack-advanced`, ₹199 |

Rules for what each depth shows are in [learning.md](./learning.md).

## Element of the day

Table opens with one featured element: atomic number, symbol, mass, category, period, group, lattice, and a one-line character ("high strength-to-weight…"), plus **Explore Orbitals** into Details.

The feature is deterministic from the civil date in the learner's timezone, so a class sees the same element on the same day. The titanium card on the concept screen is the visual benchmark, not a hardcoded home.

## Honesty rules

The app teaches measured science. It must not dress an illustration up as a measurement.

| Surface | Rule |
| --- | --- |
| Property value | Quantity, unit, and a dataset pin (for example NIST). Unknown stays unknown |
| Significant figures | Ship the source's precision. Do not invent extra digits for layout |
| Curriculum blurb | Labeled as a teaching summary, separate from the measurement grid |
| Spectral sonification | The UI says the tone is **transposed** into hearing range. 512 THz is not a speaker frequency |
| Simulate Reaction | An illustration of a known reaction for this element, with reactants named. It is not a general solver and not a lab result |
| Fraunhofer / match scores | Do not ship a match percentage |
| Category color | Means the IUPAC-style family. Theme never repaints it |

## Settings, in one glance

Three places, matching RxFolio's split:

| Place | Holds |
| --- | --- |
| **Settings** | Who is signed in, which packages they own, app health, about, help |
| **App settings** | Language, appearance, depth default, units, spectra sound, motion |
| **Account settings** | Sign in, restore purchases, export or erase this device |

Appearance is Light, Dark, or System, plus color presets and a frosted-glass switch. Element-family colors stay fixed. Full behavior is in [settings-and-theming.md](./settings-and-theming.md).

## Packages

The shell is free to install. The preview of five elements is free to use. The full pack is what a package buys.

| Package | Price | Includes |
| --- | --- | --- |
| Preview | Free | H, C, Si, Ne, Ti, all three courses, bundled in the app. No account |
| Beginner | ₹199 (store price) | Classes 8–10 writing and quiz for all 118 elements |
| Intermediate | ₹199 (store price) | Classes 11–12 and JEE writing and quiz |
| Advanced | ₹199 (store price) | Undergraduate writing and quiz |

A purchase row in Firestore is the record: Firebase uid, email, package id, store, transaction id, status, and time. The store charges the buyer. Firebase does not invent the charge. Details are in [architecture.md](./architecture.md#packages-and-purchases).

## v1 scope

In:

- All 118 elements, with the property set the concept screens already imply
- Table (registry and matrix), Details, Spectra, Quiz
- Beginner, Intermediate, Advanced as separate purchases
- Phone shell and wide shell
- Settings, App settings, Account settings, theming
- English UI
- Preview catalog in the app. Full content pack in Firebase Storage, cached in SQLite after download
- Firebase Auth, Firestore purchases, and receipt verification
- Google Play and App Store products `pack-beginner`, `pack-intermediate`, `pack-advanced`

Out of v1:

- A chat tutor or open-ended "ask the element"
- User-authored corrections to the catalog
- A general reaction predictor
- Quizzes and spaced repetition
- A second science domain (compounds, orbitals-only lab)

The three course packs are independent purchases on the same Firebase project.

## Non-goals for inception

- Scaffolding the Flutter app before the preview rooms match the concept screens
- Treating a client-side flag as proof of purchase
- Shipping a light-theme pixel pass before the dark benchmark is specified in [design-system.md](./design-system.md)
- Replacing NIST, IUPAC, or a textbook
- Becoming a laboratory information system
