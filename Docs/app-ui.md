# App UI

The first shell is the four concept science screens plus **Quiz**. Phone is the benchmark. Tablet and web use the same rooms in the wide shell ([wide-layout.md](./wide-layout.md)).

Visuals:

| Room | Benchmark |
| --- | --- |
| Table | [screen1/screen.png](./concept-images/screen1/screen.png) |
| Details | [screen3/screen.png](./concept-images/screen3/screen.png) |
| Neighbors | [screen2/screen.png](./concept-images/screen2/screen.png) |
| Spectra | [screen4/screen.png](./concept-images/screen4/screen.png) |

Tokens and component rules: [design-system.md](./design-system.md).

## Shell

```text
┌──────────────────────────────────────┐
│ Element Deck                      ?    me │
│ PERIODIC EXPLORER · {ROOM}           │
├──────────────────────────────────────┤
│                                      │
│              room body               │
│                                      │
├──────────────────────────────────────┤
│  TABLE  DETAILS  SPECTRA  QUIZ     │
└─────────────────────────────────────────┘
```

| Chrome | Behavior |
| --- | --- |
| Wordmark | Element Deck. Always. |
| Eyebrow | `PERIODIC EXPLORER · TABLE` (or DETAILS, SPECTRA, QUIZ) |
| Help | **?** opens the guide for this room. **Previous** and **Next** walk the other rooms and the settings pages. Family filtering stays on the Table chips |
| Me | Opens **Settings**. It is not a science room |
| Bottom nav | Phone only. Four destinations. Re-tapping the active destination scrolls that room to the top |
| Selection | One current element for Details, Spectra, Neighbors, and Quiz. Table selection updates the current element. Quiz can also change it from **Change element**. |

The profile glyph on the concept screens is **Me**, the door to Settings, Account, and App settings. See [settings-and-theming.md](./settings-and-theming.md).

There is no chatbot chrome in v1.

## Selection

```text
Table tap
  → sets the current element
  → phone: stays on Table; a second tap or "open" goes to Details
  → the element-of-the-day "Explore Orbitals" goes straight to Details

Details
  → always shows the current element
  → if none yet, the element of the day

Neighbors (Details tab)
  → element A is the current element
  → B is the written course pair when one exists, otherwise the next element down the group

Spectra
  → the current element as the target emitter
  → chips switch the emitter and update the current element
```

Back from a pushed page returns to the room that opened it. The bottom nav switches rooms without losing the current element.

## Table

Benchmark: screen 1. Home of the explorer.

Top to bottom:

1. **Complexity.** Segmented control: Beginner, Intermediate, Advanced. A one-line caption states what this depth is showing. On the benchmark, Intermediate says it shows atomic mass, shell counts, and oxidation states, and points at Beginner and Advanced.
2. **Element of the day.** A glass card: Z, symbol, name, mass, category chip, period, group, lattice, a short character line, **Explore Orbitals**, and a bookmark.
3. **Search.** Name, symbol, or atomic number. A numeric query jumps to Z. A symbol query prefers an exact symbol match.
4. **Category chips.** All, then the families (reactive nonmetals, noble gases, alkali, alkaline earth, transition, post-transition, metalloids, lanthanides, actinides, halogens as a filter that can overlap a family). Every chip shows how many elements it selects, as in All (118) and Reactive Nonmetals (13). Halogen counts the tag, so it overlaps the reactive-nonmetal family.
5. **Registry.** Cards in a two-column grid on the phone benchmark. Each card: Z, mass, symbol in the family color, name, category, standard state, a short configuration or shell summary appropriate to the depth.
6. **View toggle.** List/registry versus **matrix**. The benchmark is the registry ("Atomic Registry · 12 shown" when a filter or search is narrowing). Matrix is the classic 18-column table, pan and zoom, lanthanide and actinide rows called out. Minimum cell about 64×74 px when zoomed; the phone matrix scrolls. It does not shrink 118 cells under a thumb.
7. **Sparkline.** A small trend for the current filter or period, such as the ionization-energy curve on the benchmark (H, He, Li, Ne called out). It is a teaching hint into Neighbors, not a dashboard widget.

Empty search: say what failed ("No element matches 'xyz'") and offer to clear filters. Do not invent a closest element silently. A near symbol (`Na` vs `Ne`) can be offered as an explicit suggestion.

## Details

Benchmark: screen 3. The dossier.

1. **Context line.** Stable isotope teaser or standard atomic weight, and a short status such as the benchmark's isotope note. This is a summary, linked to Spectra for the full isotope list.
2. **Complexity**, same control as Table, same stored value.
3. **Identity.** Z, symbol, name, mass, category, block, period, group, and an orbital diagram at a fidelity the depth allows (Bohr-style at Intermediate; a plainer shell picture at Beginner; configuration detail at Advanced).
4. **Quantum metrics.** Electron configuration, oxidation states, radius, electronegativity, ionization energy. Labels in mono, values in mono. Beginner replaces this grid with shell count and a sentence.
5. **Thermal phase profile.** Melting and boiling as a range bar, crystal lattice, density, and the strength or character line from the benchmark.
6. **Discovery.** Year, the people, a short genesis paragraph. Teaching copy, sourced.
7. **Applications.** A few pictured uses (aerospace, medical, sub-sea, pigment on the titanium benchmark). Each card is a use, not an advertisement.
8. **Curriculum and depth profiles.** The three modes explained for *this* element, so the learner can see what they would gain by switching. The active depth is marked.
9. **Simulate Reaction.** Primary action. Opens an illustration of one known reaction for this element. See [learning.md](./learning.md#simulate-reaction).

On the phone the dossier scrolls as one page. Sections are headings, not a maze of tabs. The design-system note about a bottom sheet is the compact inspector while you are still on Table or the matrix. Details itself is a full destination.

### Properties tab

The Properties tab lists compiled values in labeled rows: identity, electrons, physical properties, isotopes, and spectrum. Units follow App Config. Stored values stay in the dataset's units.

Tap a row label, or click it with a pointer, to open a reference article for that property: what it measures, how it was established, and where the unit comes from. The article is about the property, not a second measurement of the open element. Labels that have an article are drawn with a dotted underline.

Bookmark lives on the identity header.

### History tab

Three prose cards, in this order:

1. **History of the element.** The naming story and what people did with the element afterward.
2. **How it was discovered.** The year (or Antiquity), the people, and a short account of the material, the operation, and the evidence. Ancient elements say so, and describe the smelt or the recognition that the substance was already simple.
3. **Formed in the Universe.** The nuclear paths thought to have assembled the element before the Earth existed: Big Bang fusion, stellar burning, cosmic-ray spallation, or neutron capture. Elements with no surviving primordial stock say which decay chain or laboratory reaction produces the atoms that exist now.

## Neighbors

Benchmark: screen 2. A Details tab. Two elements, one argument.

1. **Mode label.** Congener analytics, group and period context, differential mode.
2. **Pair.** Element A and element B, each with Z, symbol, name, category, block, mass. Swap either side. A versus mark sits between them.
3. **Allotrope or form preview.** When the element has a taught form (graphite lattice, silicon wafer), show it. If we have no honest image, omit the preview. Do not use a decorative texture as data.
4. **Physical and quantum metrics.** Paired bars: covalent radius, Pauling electronegativity, first ionization energy, melting point, density, valence shell. Each row states the delta in words ("+58.6% larger", "−25.9% lower") computed from the stored values, not typed by hand into the layout.
5. **Trend breakdown.** A short essay for this pair: why the step from A to B breaks or continues the group trend. The benchmark is Group 14, carbon to silicon: 3p shielding, bond energy, the shift toward a semiconductor. This prose is curated per taught pair. A pair without a written breakdown still shows the metric rows and says the narrative is not written yet.
6. **Fast congener swaps.** One-tap alternates in the same group (germanium, oxygen on the benchmark's carbon/silicon story — oxygen is the cross-group contrast, labeled as such).
7. **Export comparison dossier (PDF).** Renders the pair, the deltas, the breakdown, the depth, and the dataset pin. Generated on device.

Changing depth restates the captions. The numbers stay. Beginner hides term-symbol asides and leads with size, state, and "why we care."

## Spectra

Benchmark: screen 4. The bench. Two tabs sit under the element header, the same pattern as Details.

**Spectra** is the bench below. **Details** is a long reading: first a shared account of what a spectrum is, how a line is made, how it is recorded, and how an element is identified; then an essay on the selected element's own spectrum, its look-alike colors, and its uses. Every element has that essay. A line list under the essay prints the wavelengths the pack actually stores, so the prose and the strip stay tied to the same dataset. The phone is not a spectrometer in either tab.

1. **Calibration line.** "Spectrometer calibrated" means the bundled dataset is the one this screen was built against, not that the phone is a spectrometer. The footer shows the dataset name and version (benchmark: NIST ASD Ref v3.1).
2. **Target emitter chips.** Current element first, then recent emitters (Ne, Fe, H on the benchmark). Horizontal scroll.
3. **Optical spectrum.** Emission or absorption toggle. A visible-window strip (about 380–750 nm on the benchmark) with lines. Selecting a line fills wavelength, frequency, energy in eV and joules, and the assignment (`3s[3/2]° → 3p[1/2]`).
4. **Wavelength scrubber.** Moves the selection along the plotted lines. It does not invent lines between the dataset's lines.
5. **Listen.** Plays the selected line's frequency **sonified** into the audible range. The button text keeps the real frequency and the word sonified. Respect the mute switch in App settings. If the OS is silent, show the tone as available and do not blast audio.
6. **Gas discharge.** A glow swatch in the characteristic color, the voltage flavor as teaching copy where we have it ("1.2 kV glow"), and a sentence on the color. Color here is the element's emission color, which can differ from the family color used on tiles.
7. **Astrophysical match.** A sourced note (stellar nucleosynthesis, a nebula, a Fraunhofer line) when we have one. Match percentages do not ship.
8. **Isotopes and decay.** Z and proton count, then isotopes: mass number, neutron count, mass, spin, abundance or half-life, and a stability chip (stable, trace radioisotope, synthetic). The benchmark's neon list is the pattern.
9. **Footer pin.** Dataset name, version, resolving power note if we show one. Resolution copy must match the dataset, not the PNG.

Beginner still lands here. The strip and the glow lead. Assignments and nuclear spin sit under an Advanced disclosure that is open when depth is Advanced and collapsed otherwise. The data is one scroll away at every depth.

## Quiz

A fifth room. Practice on the currently selected element, at the current learning mode, from a 50-question pool.

1. **Change element.** A button at the top opens a searchable dialog (name, symbol, or Z). Picking a row updates the current element for Quiz and Details.
2. **Learning mode.** Quiz uses the app setting from App Config, not a control on this room. The pool is the 50 questions for that depth. Progress is stored per element and depth.
3. **Streak, XP, and tier.** Consecutive local days with at least one answer, `20 ×` correct answers across every pool, and a tier from finished pools. All stay on the device. Table's element-of-the-day card does not show them.
4. **Question.** Stem, four choices, then a lock: the correct option is marked, a short explanation (and an equation only when the catalog has one). **Previous** and **Next** walk all 50 items without requiring an answer. Finishing all 50 still shows a completion card; the items remain browsable.
5. **Notes, bookmark, report.** Notes and reports are local. Bookmark is the same element bookmark as Details.
6. **Active element bank.** Category bars for this pool.

Deep link: `/quiz` opens the current element; `/quiz/22` focuses titanium.

## Shared behaviors

| Behavior | Rule |
| --- | --- |
| Units | Follow App settings. The benchmark draws K, eV, pm, u. School units (°C, kJ/mol) convert for display; the stored value stays SI |
| Family color | Tile symbol, chip dot, and compare accent. Never the only signal: the category name is always printed |
| Bookmark | Toggles on the current element. Filled state is visible on the card and the dossier |
| Search | Available on Table. Wide shell also exposes it in the title bar |
| Deep link | `elementdeck://element/22` and the web path `/e/22` open Details for titanium. `/e/22/spectra`, `/compare/6/14`, `/quiz`, and `/quiz/22` open those rooms |
| Help | **?** on the room header, and again on each settings page. The article matches the page you opened it from. **Previous** and **Next** walk Table, Details, Neighbors, Spectra, Quiz, then Settings and its pages |
| On device | Preview elements ship in the app. The full pack is read from the local cache after download. Bookmarks and theme are local, and copy to Firebase when signed in |
| Reduced motion | No pulsing glows, no scrubber inertia. See App settings |
| Text scale | Layouts survive the OS text scale. Mono values may wrap; they do not truncate a unit |

## What the first UI is not

- Not a feed. Streak and XP exist only in Quiz, on the device.
- Not a chat column beside the dossier.
- Not a different navigation for educators.
- Not a light theme in the concept PNGs. Light theme is still required; it is specified in [settings-and-theming.md](./settings-and-theming.md) and skinned from the same components.
