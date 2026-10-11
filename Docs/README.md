# Element Deck docs

Inception notes for a periodic-table explorer that teaches every element. The client is a **Flutter** app for phone, tablet, web, and desktop, in the same family of shells as [RxFolio](https://github.com/rrekapalli/Hi-Doc). **Firebase** stores the content pack and the record of who bought which package. **SQLite** on the device is the cache the rooms read. There is no custom API.

The concept screens still show an older name, ATOMIQ. The product name is **Element Deck**.

Read these in order if you are new to the project:

1. [Vision](./vision.md) — what the product actually is
2. [Product brief](./product-brief.md) — users, rooms, depths, naming
3. [Personas](./personas.md) — student, educator, enthusiast; same catalog, different job
4. [App UI](./app-ui.md) — the four concept screens and how they behave
5. [Learning](./learning.md) — Beginner, Intermediate, Advanced on the same element
6. [Object model](./object-model.md) — elements, content pack, purchases, preferences
7. [Design system](./design-system.md) — Obsidian Orbit, from the concept tokens
8. [Settings and theming](./settings-and-theming.md) — Settings, App settings, Account settings, appearance
9. [Wide layout](./wide-layout.md) — tablet and web shell
10. [Technology stack](./technology-stack.md) — Flutter, Firebase, SQLite cache
11. [Architecture](./architecture.md) — content pack, purchases, on-device cache
12. [Market landscape](./market-landscape.md) — adjacent periodic-table products
13. [Use cases](./use-cases/README.md) — student, educator, enthusiast, classroom
14. [Open questions](./open-questions.md) — what still needs refinement

Visual source, already in the repo:

| Room | Screen |
| --- | --- |
| Table | [concept-images/screen1](./concept-images/screen1/screen.png) |
| Details | [concept-images/screen3](./concept-images/screen3/screen.png) |
| Compare | [concept-images/screen2](./concept-images/screen2/screen.png) |
| Spectra | [concept-images/screen4](./concept-images/screen4/screen.png) |

The four `DESIGN.md` files are the same Obsidian Orbit token sheet. Treat [screen1/DESIGN.md](./concept-images/screen1/DESIGN.md) as the token source.

These files are the working memory of the product, not marketing copy. Prefer revising them over adding application code until the object model and the four rooms feel stable.
