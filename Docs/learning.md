# Learning

Depth is how Element Deck teaches. The element does not change. The leading facts, the vocabulary, and the captions do.

The control is the segmented **Complexity** on Table and Details: **Beginner**, **Intermediate**, **Advanced**. Compare and Spectra read the same value. App settings stores the default. The in-room control updates that default, so the next launch opens where the learner left off.

The concept screens are drawn at Intermediate, with Advanced visible on Spectra's line assignment and isotope table.

## What each depth promises

| | Beginner | Intermediate | Advanced |
| --- | --- | --- | --- |
| Promise | Where it is, what it is like, what people use it for | The numbers a secondary course examines | Why the numbers look like that |
| Configuration | Shell count ("2, 8, 10, 2") | Noble-gas shorthand (`[Ar] 3d² 4s²`) | Shorthand plus the subshell story the screen is teaching |
| Oxidation | Words: "often forms a +4 ion" | The state list `+4, +3, +2` | Same list, with the common state marked and exceptions noted |
| Diagram | Colored shells | Bohr-style diagram, as on the titanium screen | Diagram plus the configuration called out beside it |
| Metrics | State at room temperature, one size word, one use | Radius, electronegativity, ionization, melting, boiling, density, lattice | Those, with units switchable and uncertainties when the dataset has them |
| Spectra | Color name and glow | The strip, wavelength, "visible red" | Transition assignment, energy in eV and joules, isotope spins |
| Compare | Larger / smaller, metal / nonmetal, one sentence | The differential bars | The bars plus the trend-break essay |
| Caption tone | Short sentences, no naked symbols without a gloss | Course vocabulary, symbols allowed | Compact, mono, source-first |

Switching depth never navigates away and never discards the scroll position if the section still exists.

## Curriculum card

Details includes **Curriculum & depth profiles** for the open element. Three short blocks, one per depth, written for that element. The titanium benchmark sketches the pattern: Intermediate states the course facts (oxidation, radius, density, lattice); the other two say what they add.

The card is a map. It is not a quiz and not a completion badge. The active depth is highlighted. Tapping another profile switches depth.

Teaching blurbs are a field on the element (`CurriculumBlurb`), tagged by depth. They are not the measurement table. See [object-model.md](./object-model.md).

## Element of the day

A daily door, not a streak.

- Pick Z by a stable hash of the local calendar date so every device on that date agrees.
- Skip nothing: Z = 1 through 118 all take a turn. A year does not cover the table twice; that is fine.
- The card uses the current depth for its one-line character and its configuration snippet.
- **Explore Orbitals** opens Details and scrolls to the diagram.
- Bookmark is independent of "seen today."

No points for opening it. No guilt for ignoring it.

## Compare as a lesson

The teaching pair in the concept is **carbon and silicon**, Group 14. The lesson to preserve:

- Carbon is smaller, more electronegative, and forms much stronger bonds to itself.
- Silicon's extra 3p shell increases radius and loosens the covalent network.
- The outcome the learner should be able to say: carbon's network is a covalent insulator/allotrope story; silicon's is a semiconductor.

v1 ships curated breakdowns for a defined set of pairs (same-group steps that courses actually teach, plus a few cross-group contrasts such as carbon versus oxygen). Other pairs still compare numerically and show an empty narrative state: "No written trend for this pair yet."

Deltas are computed. If a value is missing on either side, that row says "not reported" and does not draw a bar that implies zero.

Suggested swaps:

- Next element down the group
- Previous element up the group
- A named contrast stored on the breakdown (oxygen, on the carbon–silicon card)

## Spectra as a lesson

Light is part of the element, not a special topic hidden in settings.

The learner should be able to leave the neon screen knowing:

- Neon emits a visible orange-red.
- A selected line has a wavelength, and that wavelength corresponds to an energy.
- The tone they hear is the frequency **brought down** into hearing range by a fixed, stated factor.
- Some neon nuclei are stable and common; some are trace or synthetic and decay.

Sonification rule:

```text
audibleHz = lineFrequencyHz / 1e12
```

512.25 THz is heard as 512.25 Hz. The button shows both the scientific frequency and the word "sonified." Advanced can show the audible frequency. Beginner shows "Play the color as a tone."

Emission and absorption use the same line list, presented differently. Absorption does not invent Fraunhofer lines we did not store.

## Simulate Reaction

A primary button on Details. Scope for v1:

- One **curated illustration** per element that has one, not a free-text equation parser.
- Shows reactants, products, a condition line (heat, water, acid), and a one-sentence why-it-matters at the current depth.
- Labeled **Illustration of a known reaction**. No yield, no "lab result," no balance solver.
- Elements without a curated reaction hide the button. They do not show a disabled tease that implies the feature is broken.

Examples that fit the product, to be chosen when the catalog is written: hydrogen + oxygen, sodium in water, iron rusting, carbon combustion. Titanium may use a real industrial step only if we can describe it honestly in a few lines. If we cannot, omit it.

This is not an AI feature.

## Quiz

Quiz is the only scored room. Table, Details, Compare, and Spectra still do not grade the learner. Opening Advanced is not a level-up. Bookmarks and recents are memory, not a grade.

The Quiz pool is 50 questions for the focused element at the current depth. A correct answer is worth 20 XP. A day streak counts consecutive local calendar days with at least one answer. Tiers count finished pools (all 50 answered), not XP: Observer, Student, Scholar, Fellow, Master.

Element of the day on Table stays a door with no points.

## What we do not do with mastery

Outside Quiz, v1 does not score the learner. See [open-questions.md](./open-questions.md).

## Educator use of depth

On a wide screen the depth control stays visible while the dossier is projected. Switching it is the lesson. Students on phones follow along on the same element; their own depth control is local unless a class assignment suggests a depth. The suggestion is a default they can override. See [use-cases/classroom.md](./use-cases/classroom.md).

## Language of explanations

App settings can apply a language to **UI**, **Explanations**, or **All**, the same split RxFolio uses for UI and AI replies.

- **UI** is chrome: rooms, settings, buttons.
- **Explanations** are curriculum blurbs, discovery paragraphs, application captions, and trend essays.
- Measurements, symbols, and Z never translate.

v1 ships English for both. The split exists so a later Hindi (and the other languages RxFolio already supports) can translate teaching copy without a second layout. See [settings-and-theming.md](./settings-and-theming.md).
