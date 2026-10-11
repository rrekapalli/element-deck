---
name: Obsidian Orbit
colors:
  surface: '#0b1326'
  surface-dim: '#0b1326'
  surface-bright: '#31394d'
  surface-container-lowest: '#060e20'
  surface-container-low: '#131b2e'
  surface-container: '#171f33'
  surface-container-high: '#222a3d'
  surface-container-highest: '#2d3449'
  on-surface: '#dae2fd'
  on-surface-variant: '#bdc8d1'
  inverse-surface: '#dae2fd'
  inverse-on-surface: '#283044'
  outline: '#87929a'
  outline-variant: '#3e484f'
  surface-tint: '#7bd0ff'
  primary: '#8ed5ff'
  on-primary: '#00354a'
  primary-container: '#38bdf8'
  on-primary-container: '#004965'
  inverse-primary: '#00668a'
  secondary: '#ddb7ff'
  on-secondary: '#490080'
  secondary-container: '#6f00be'
  on-secondary-container: '#d6a9ff'
  tertiary: '#56e5a9'
  on-tertiary: '#003824'
  tertiary-container: '#30c88f'
  on-tertiary-container: '#004e34'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#c4e7ff'
  primary-fixed-dim: '#7bd0ff'
  on-primary-fixed: '#001e2c'
  on-primary-fixed-variant: '#004c69'
  secondary-fixed: '#f0dbff'
  secondary-fixed-dim: '#ddb7ff'
  on-secondary-fixed: '#2c0051'
  on-secondary-fixed-variant: '#6900b3'
  tertiary-fixed: '#6ffbbe'
  tertiary-fixed-dim: '#4edea3'
  on-tertiary-fixed: '#002113'
  on-tertiary-fixed-variant: '#005236'
  background: '#0b1326'
  on-background: '#dae2fd'
  surface-variant: '#2d3449'
typography:
  headline-xl:
    fontFamily: Plus Jakarta Sans
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-xl-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.015em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  label-mono-lg:
    fontFamily: JetBrains Mono
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 22px
    letterSpacing: 0.02em
  label-mono-md:
    fontFamily: JetBrains Mono
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 18px
    letterSpacing: 0.03em
  label-mono-sm:
    fontFamily: JetBrains Mono
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.04em
  label-mono-xs:
    fontFamily: JetBrains Mono
    fontSize: 9px
    fontWeight: '700'
    lineHeight: 12px
    letterSpacing: 0.06em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 0.75rem
  gutter-desktop: 1.25rem
  margin: 1rem
  margin-tablet: 1.5rem
  margin-desktop: 2rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1rem
  space-xl: 1.5rem
  space-2xl: 2.25rem
---

## Brand & Style

This design system is engineered for an advanced scientific periodic elements explorer mobile application. The target audience includes researchers, educators, students, and science enthusiasts who demand analytical precision paired with visual elegance. 

The aesthetic synthesizes technical minimalism with high-end dark glassmorphism. It evokes the feeling of interacting with a clean-room instrumentation display or an observatory console: quiet deep space illuminated by crisp spectral emissions. 

Key attributes:
- **Atmospheric Depth:** Deep obsidian and slate foundations eliminate interface glare and direct maximum focus to elemental data.
- **Instrument Precision:** Sharp data demarcation using tabular monospaced notations alongside balanced geometric sans-serif headings.
- **Luminous Differentiation:** Distinct, spectral-grade category hues delineate elemental blocks without visual clutter.
- **Tactile Optics:** Frosted translucent surfaces with micro-borders mimic polished optical glass lenses under darkroom conditions.

## Colors

The palette relies on high-contrast spectral luminescence anchored against deep space canvas tones.

### Canvas & Surface Hierarchy
- **Canvas Base:** `#080C14` (Deep Obsidian) — Ground layer for absolute contrast.
- **Surface Elevation 1 (Card/Container):** `#0F172A` at 65%–85% opacity with backdrop blur.
- **Surface Elevation 2 (Elevated Sheet/Modal):** `#1E293B` at 75% opacity.
- **Surface Outline / Border:** `#334155` at 40%–60% opacity for hairline separators.
- **Text High-Contrast:** `#F8FAFC` (95% brightness).
- **Text Medium-Contrast:** `#94A3B8` (Slate secondary).
- **Text Subtle/Muted:** `#64748B` (Metadata and inactive labels).

### Elemental Spectrum System
Category accents must strictly follow elemental classification:
- **Reactive Nonmetals:** `#38BDF8` (Electric Cyan)
- **Noble Gases:** `#A855F7` (Vivid Neon Violet)
- **Alkali & Alkaline Earth Metals:** `#F59E0B` (Golden Amber)
- **Transition Metals:** `#10B981` (Emerald Glow)
- **Post-Transition Metals:** `#EC4899` (Vivid Rose)
- **Metalloids:** `#6366F1` (Spectral Indigo)
- **Actinides & Lanthanides:** `#F43F5E` (Crimson Radiance)

When presenting elements, glow tokens use a 12% to 20% alpha fill of the category accent beneath tiles or border strokes to simulate light-emitting gas discharges without reducing foreground text legibility.

## Typography

The typographic system utilizes a disciplined split between geometric clarity and tabular telemetry.

- **Plus Jakarta Sans** serves as the primary voice for element names, section titles, contextual summaries, and standard conversational text. Its geometric curves soften the technical nature of the content while keeping legibility high on high-density mobile screens.
- **JetBrains Mono** is reserved for empirical data: atomic numbers, chemical symbols, electron shell configurations (`[Ar] 3d¹⁰ 4s²`), molar masses, oxidation states, and measurement units (`g/cm³`, `K`).

Rules:
- Never substitute the primary font for chemical numerical data.
- Atomic symbols in compact cells must use `Plus Jakarta Sans` semi-bold or bold, flanked by `JetBrains Mono` for atomic weight and atomic number coordinates.
- Uppercase tracking (`0.04em`–`0.06em`) is applied to `label-mono-xs` and `label-mono-sm` to ensure zero bleed on OLED displays.

## Layout & Spacing

The layout model is tailored for rapid handheld single-thumb interaction alongside multi-axis canvas panning for full periodic table exploration.

### Grid & Density
- **Mobile Grid (Default):** Fluid layout with 4 base columns, `1rem` outer canvas margin, and `0.75rem` gutters.
- **Periodic Matrix Mode:** Scalable 18-column scrollable grid matrix with fixed element cell aspect ratio (1:1.15) and strict `0.25rem` micro-gutters (`space-xs`).
- **Tablet / Expanded Screen:** 8 to 12 columns with dynamic side-docked split inspector cards; gutters expand to `1.25rem`.

### Spacing Rhythm
Spacing relies on a baseline 4px cadence. Vertical groupings inside element detail dossiers use tight coupling:
- Properties and values use `space-xs` (4px).
- Sibling data chips inside a group use `space-sm` (8px).
- Structural section blocks within inspection sheets use `space-lg` (16px) to `space-xl` (24px).

## Elevation & Depth

Visual hierarchy uses frosted optical glass layers combined with radial backlights rather than heavy opaque drop shadows.

### Glass Stack Architecture
- **Layer 0 (Canvas):** Pure `#080C14`. Receives subtle interactive radial gradients tied to the currently inspected element’s category color at 8% opacity.
- **Layer 1 (Card Default):** `#0F172A` with 70% opacity, `backdrop-filter: blur(16px)`, bound by a 1px solid border of `#334155` at 40% alpha.
- **Layer 2 (Active/Selected Card):** `#1E293B` with 80% opacity, `backdrop-filter: blur(24px)`, bounded by a 1px border tinted in the element's accent color at 70% alpha.
- **Layer 3 (Modal / Bottom Drawer):** `#0B1120` with 92% opacity, `backdrop-filter: blur(32px)`, with a subtle top border gradient transitioning from accent color to transparent.

### Ambient Luminescence (Glow Tokens)
- **Cell Hover / Active Glow:** `0 0 20px -4px [accent_color_35%]`, creating a soft ionization discharge look.
- **Spectral Halo:** For high-priority values or noble gas representations, an ambient drop blur `box-shadow: 0 4px 30px [accent_color_15%]` highlights structural relationships without obscuring adjacent data.

## Shapes

The design system employs a calibrated rounded geometry (Level 2: `0.5rem` / 8px default radius) that balances clean technical rigidity with touch-friendly accessibility.

- **Periodic Element Cells:** Base corner radius of `0.5rem` (8px). Keeps the dense 18-column tabular grid visually cohesive without touching adjacent corners.
- **Data Badges & Micro Chips:** Compact radius of `0.25rem` (4px) to retain an instrumental, calibrated feel.
- **Property Sheets & Modals:** `rounded-lg` (1rem / 16px) along top edges to provide an ergonomic sheet feel during one-handed pull-up actions.
- **Action Buttons & Search Inputs:** `rounded-lg` (0.75rem / 12px) to clearly differentiate touch targets from data display cells.

## Components

### Periodic Element Tile (Custom Core Component)
- **Dimensions:** Adaptive responsive box (minimum 64px × 74px on zoomed mobile view).
- **Structure:** 
  - Top-left: Atomic number (`label-mono-sm`, Slate 400).
  - Top-right: Atomic weight (`label-mono-xs`, Slate 500).
  - Center: Element Symbol (`headline-md`, Bold, Category Accent Color).
  - Bottom: Element Name (`body-sm`, White, truncated with ellipsis) over electron shell summary (`label-mono-xs`).
- **Surface:** Glassmorphic container with 1px border of `#334155` (alpha 50%). On focus or selection, the border shifts to 100% category accent color with an internal 12% ambient glow.

### Buttons & Quick Actions
- **Primary Action:** Solid background using `#38BDF8` (or active category accent), dark text `#080C14` with `Plus Jakarta Sans` semi-bold. Height 48px, radius `0.75rem`.
- **Secondary / Glass Action:** Surface `#0F172A` at 60% opacity with 1px border `#334155`. Text in `#F8FAFC`. Active state triggers category-colored border transition.
- **Icon Utility Buttons:** 40px × 40px square, `0.5rem` radius, subtle glass fill with centralized monochrome icons in `#94A3B8`.

### Badges & Category Chips
- **Category Filter Chips:** Pill-like containers (`0.5rem` radius) featuring a 6px circular glowing indicator matching the spectral category tone. Inactive state: `#0F172A` background, muted border. Active state: 15% category tint background, category border, glowing dot.
- **Science Metric Badges:** JetBrains Mono inline tag with 2px vertical category accent bar on the left border, displaying values such as electronegativity, melting point, or half-life.

### Input Fields & Filter Bars
- **Search Bar:** 48px height, filled with frosted `#0F172A` (75% opacity), border `#334155` (50% opacity). Left icon in `#64748B`. Placeholder text in `#64748B` (`body-md`).
- **Active State:** Border transitions to Electric Cyan (`#38BDF8`) with a `0 0 12px rgba(56, 189, 248, 0.25)` halo. Monospaced query typing auto-detects numerical atomic numbers or text symbols.

### Element Dossier Card (Detail Sheet)
- Pull-up bottom modal with sticky drag pill handle (`#334155`, 36px wide, 4px high).
- Segmented into collapsible scientific tabs: *Thermodynamics*, *Atomic Structure*, *Electrons & Orbitals*, *History & Abundance*.
- Grid of two-column micro-cards displaying measurement labels (`label-mono-xs`, uppercase, Slate 400) stacked above primary numerical values (`label-mono-lg`, White).