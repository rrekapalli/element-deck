# Wide layout

Tablet, web, and desktop use one shell. Phones keep the bottom navigation from [app-ui.md](./app-ui.md). The gate is the same idea as RxFolio's wide shell.

## When it activates

All of the following:

1. Viewport width ≥ **900**.
2. The form factor is one of:
   - Web or installed PWA
   - Desktop: Windows, Linux, or macOS
   - Android or iOS **tablet**, shortest side ≥ **600**

Phones, including a foldable whose shortest side is still under 600, keep the bottom bar. A rotated phone does not become the classroom layout.

Name the gate `ElementDeckUi.isWideShell` when the app exists. Do not copy RxFolio's health-specific pane widgets; copy the breakpoint and the chrome regions.

## Chrome

```text
┌────────────────────────────────────────────────────────────┐
│ Element Deck          {room title}              search    help   │
├────────┬───────────────────────────────────────────────────┤
│        │                                                   │
│ Table  │                                                   │
│ Details│                 room body                         │
│ Compare│                                                   │
│ Spectra│                                                   │
│        │                                                   │
│        │                                                   │
│ Settings                                                  │
├────────┴───────────────────────────────────────────────────┤
│ {persona · on this device}                    Element Deck │
└────────────────────────────────────────────────────────────┘
```

| Region | Contents |
| --- | --- |
| Title bar | Wordmark, active room, search field, Help |
| Nav rail | The five rooms. **Settings** pinned at the bottom |
| Body | Room-specific, below |
| Footer | Persona and "On this device", plus the product name |

App Health stays inside Settings. It is not a permanent lamp in the title bar.

Re-tapping the active rail item scrolls that room to the top and clears a temporary selection where the phone would have popped to root.

Sheets that are modal on the phone (a reaction illustration, erase-data confirm) open as a dialog or a right-hand pane on the wide shell. They do not cover the rail. Help is a full page, same as on the phone.

## Per-room body

The periodic table is the product, so Table does not use a 30% "chat list." RxFolio's master–detail split fits Details, Compare's saved list, and Spectra's emitter list. Table wants the matrix to dominate.

| Room | Left | Right |
| --- | --- | --- |
| Table | About 320 px: search results if the query is active, otherwise element of the day, depth control, category chips, the sparkline | The matrix, filling the rest. Selecting a cell opens a **docked inspector** over the lower right or as a third column when width ≥ 1200: symbol, mass, category, one-line summary, Open dossier, Compare |
| Details | Registry list of elements, filtered, with the current row selected. About 30% | The full dossier. No bottom sheet |
| Compare | Saved pairs and the fast swaps. About 30% | The two elements **side by side**, metrics in a single grid, trend essay under them. Export stays visible |
| Spectra | Emitter list (recent, bookmarked, search). About 30% | The bench: strip, selected line, listen, glow, astrophysics, isotopes |

At width ≥ 1200, Details may show the orbital diagram in a sticky header while the metrics scroll.

Depth stays in the left column on Table and Details so a projected screen can change it without hunting the scroll.

## Classroom projection

An educator's tablet or a browser on a projector is this shell, zoomed by the OS or the browser, not a separate "presentation mode" in v1.

Rules that matter at the back of a room:

- Body text and the symbol scale up with the window; the matrix cells have a maximum size so 18 columns still fit at 900 px, and grow when the window is wider.
- Reduced motion is easy to reach from Settings on the rail.
- Sonification defaults on, and is one switch in App settings for a lab where sound is unwelcome.
- Theme can be Dark (the benchmark, good in a dim room) or Chalk (good on a washed-out projector). Family colors stay.

A later "present this element" control can hide the rail. It is not required to ship the shell.

## Web and PWA

The web build is the same Flutter app.

- Installable (manifest, icons, standalone display).
- Glass defaults off. Appearance can turn it on.
- Deep links: `/e/{z}`, `/e/{z}/spectra`, `/compare/{zA}/{zB}`.
- The preview catalog loads with the app. First paint of those five elements does not wait on a network.
- The full pack downloads from Firebase after purchase, then search and the rooms use the cache offline.
- Sign-in and restore purchases need the network.

## Desktop

Windows, Linux, and macOS are the wide shell inside a window. Minimum window about 900 × 600. Below that, the layout may scroll; it does not switch to the phone bottom bar inside a desktop window unless the window is narrower than 600, in which case the compact layout is honest.

Keyboard:

| Key | Action |
| --- | --- |
| `/` | Focus search |
| Esc | Clear search or close the inspector |
| Enter | Open the highlighted element |
| Arrow keys | Move in the matrix when the matrix has focus |
| `1`–`4` | Rooms, when no text field is focused |

## Compact rules that stay

Everything in [app-ui.md](./app-ui.md) about honesty, units, bookmarks, and depth still applies. Wide layout changes **placement**, not the model of one current element and one current pair.
