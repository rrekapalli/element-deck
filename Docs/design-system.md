# Design system

**Name:** Obsidian Orbit  
**Source of tokens:** [concept-images/screen1/DESIGN.md](./concept-images/screen1/DESIGN.md)  
The `DESIGN.md` files under screen2, screen3, and screen4 are the same sheet. Edit the system here and in `screen1/DESIGN.md` together when tokens change.

The concept PNGs are the dark, glass, phone benchmark. Light theme and wide layout reuse these components. They do not invent a second visual language.

## Brand

An observatory console for chemistry: deep obsidian surfaces, spectral family colors, geometric titles, monospace measurements.

Audience: students, educators, enthusiasts. The UI should feel precise without feeling like a terminal toy.

Attributes to keep:

- **Depth.** Near-black canvas so the tile colors carry the table.
- **Two voices.** Plus Jakarta Sans for names and prose. JetBrains Mono for Z, mass, configuration, units, wavelengths.
- **Family color with a label.** Color is never the only category signal.
- **Glass, used as a layer.** Cards are frosted surfaces with a hairline border. When glass is off, the same elevation colors become opaque. See [settings-and-theming.md](./settings-and-theming.md).

## Color

### Chrome

From the token sheet. Canvas in the written spec is `#080C14`. The Material-style surface ramp in the YAML (`#0b1326` and the container steps) is the Flutter `ColorScheme` seed. Implementation should pick one ramp and use it everywhere; the PNG is the judge.

| Role | Hex | Use |
| --- | --- | --- |
| Canvas | `#080C14` | Layer 0 |
| Surface | `#0F172A` | Cards, at 65–85% when glass is on |
| Raised | `#1E293B` | Selected card, sheets |
| Border | `#334155` | Hairline, 40–60% opacity |
| Text | `#F8FAFC` | Primary reading |
| Text muted | `#94A3B8` | Secondary |
| Text faint | `#64748B` | Meta, placeholders |
| Action | `#38BDF8` | Primary buttons, focus ring |

Primary buttons use dark text `#080C14` on the cyan fill.

### Family spectrum (data, not theme)

These accents mark classification. Appearance presets must not replace them.

| Family | Hex |
| --- | --- |
| Reactive nonmetals | `#38BDF8` |
| Noble gases | `#A855F7` |
| Alkali and alkaline earth | `#F59E0B` |
| Transition metals | `#10B981` |
| Post-transition metals | `#EC4899` |
| Metalloids | `#6366F1` |
| Lanthanides and actinides | `#F43F5E` |

Selected tile: family-colored border and a 12–20% fill. Glow is `0 0 20px -4px` at about 35% of the accent. Reduced-glow mode drops the shadow and keeps the border.

Emission glow on Spectra (neon's orange-red) is a **different** color from the noble-gas violet used on the table tile. Do not "correct" one toward the other.

### Light theme

Required, even though the PNGs are dark. It is the same hierarchy inverted: a cool paper canvas, dark text, the **same family accents** slightly deepened so they hold on white. Glass, if enabled, is a white frost, not a grey smear. Exact light hex values are still open; the rule is not. See [open-questions.md](./open-questions.md).

## Type

| Role | Face | Use |
| --- | --- | --- |
| headline-xl → body-sm | Plus Jakarta Sans | Names, titles, blurbs, buttons |
| label-mono-lg → xs | JetBrains Mono | Z, mass, configuration, units, wavelengths, deltas |

Rules from the token sheet:

- Measurements stay in mono. Do not set atomic mass in the title face.
- The big symbol on a tile is Plus Jakarta Sans, bold, in the family color. Z and mass beside it are mono.
- Tiny labels use slight positive tracking so they hold on OLED.

Load both families in the Flutter app and on web. Do not fall back to a default sans for symbols and a default mono for numbers in a way that changes the benchmark.

## Space and shape

Baseline 4 px.

| Token | Value | Use |
| --- | --- | --- |
| Phone margin | 16 px | Screen inset |
| Tablet margin | 24 px | |
| Desktop margin | 32 px | |
| Gutter | 12 px phone, 20 px wide | |
| Tile radius | 8 px | Element cells |
| Chip radius | 4 px | Metric badges |
| Sheet top radius | 16 px | Phone inspector and settings sheets |
| Button / search radius | 12 px | |
| Button height | 48 px | Primary actions |
| Icon button | 40 px | Help, bookmark, me |

Element cells in the matrix aim at an aspect near 1 : 1.15.

## Elevation

| Layer | Dark treatment |
| --- | --- |
| 0 Canvas | Flat `#080C14`. A very quiet radial wash of the **current element's family color** at about 8% is allowed behind the dossier |
| 1 Card | Surface at ~70% opacity, 16 px blur, 1 px border, when glass is on |
| 2 Selected | Higher surface, ~80% opacity, 24 px blur, family border |
| 3 Sheet | `#0B1120` at ~92%, 32 px blur |

Glass off: same colors at 100% opacity, no blur, same borders. The layout must not depend on blur to separate sections.

Web defaults glass **off** because backdrop blur is expensive there (the RxFolio lesson). Native defaults glass **on**, matching the PNGs.

## Components

### Element tile

- Z, top left, mono, muted.
- Mass, top right, mono, fainter. Hidden at Beginner if it crowds the cell; the registry card on the phone benchmark shows it at Intermediate.
- Symbol, center, title face, family color.
- Name, then a depth snippet (state, or shorthand configuration).
- Min size about 64 × 74 px at a zoom the thumb can hit.
- Selected: family border and inner glow.

### Registry card

The phone Table uses a richer tile than the matrix cell: category and state under the name. Same anatomy, more lines. Two columns on a phone width.

### Chips

Category filters: pill, 6 px family dot, muted when off, 15% family fill and family border when on.

Metric badges: mono value, 2 px family bar on the left edge.

### Search

48 px, frosted or solid surface, magnifier, placeholder "Search element by name, symbol, or number." Focus ring uses the action cyan, not the current family color, so focus stays consistent while browsing gold and violet tiles.

### Depth control

Three segments in one container. The active segment is filled. A caption under or beside it states the depth's promise in one line. The control looks the same on Table and Details.

### Dossier blocks

Section title in headline-sm, then a grid of label-over-value pairs. Labels are mono, uppercase, muted. Values are mono, larger, primary text. Prose sections (discovery, trend, curriculum) use body text, not mono.

### Primary button

Full width on the phone where the benchmark shows it: **Explore** actions, **Simulate Reaction**, **Export comparison dossier**. Cyan fill, dark label, 48 px, 12 px radius.

### Bottom navigation

Four items: Table, Details, Compare, Spectra. Icon plus label. Active item uses the action cyan. Family color does not move into the nav, or the nav would change hue every time the learner opens neon.

### Settings rows

Follow the RxFolio pattern: grouped list, chevrons into Account and App settings, switches inline for a single boolean. Specified in [settings-and-theming.md](./settings-and-theming.md). The visual skin is Obsidian Orbit, not the RxFolio health palette.

## Motion

Short and physical. Segment changes cross-fade the caption. Sheet presentation is a slide. The spectra scrubber moves a marker; it does not animate a fake continuous rainbow as data.

Reduced motion: no pulse on the "calibrated" dot, no glow throb, scrubber snaps.

## Assets

Pictured applications and allotrope previews are real images we have rights to, or simple diagrams we draw. A missing image removes the frame. It does not get a random laboratory stock photo.

App icon and splash stay on-brand and do not change with the color preset. Family colors belong to elements, not to the launcher.
