#!/usr/bin/env python3
"""Write preview.json and core.json for Element Deck."""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from enrich import DISCOVERY as ENRICH_DISCOVERY
from enrich import apps_for, curriculum, extra_props, summaries
from history import HISTORY
from spectral_lines import LINES as EXTRA_LINES

# z, symbol, name, mass, cat, block, period, group, state, shells, config, ox, lattice
# cat: alkali, alkaline, transition, post-transition, metalloid, nonmetal, halogen, noble, lanthanide, actinide
RAW = """
1 H Hydrogen 1.008 nonmetal s 1 1 gas 1 1s1 +1
2 He Helium 4.0026 noble s 1 18 gas 2 1s2 
3 Li Lithium 6.94 alkali s 2 1 solid 2,1 [He] 2s1 +1
4 Be Beryllium 9.0122 alkaline s 2 2 solid 2,2 [He] 2s2 +2
5 B Boron 10.81 metalloid p 2 13 solid 2,3 [He] 2s2 2p1 +3
6 C Carbon 12.011 nonmetal p 2 14 solid 2,4 [He] 2s2 2p2 +4,+2,-4
7 N Nitrogen 14.007 nonmetal p 2 15 gas 2,5 [He] 2s2 2p3 -3,+3,+5
8 O Oxygen 15.999 nonmetal p 2 16 gas 2,6 [He] 2s2 2p4 -2
9 F Fluorine 18.998 halogen p 2 17 gas 2,7 [He] 2s2 2p5 -1
10 Ne Neon 20.180 noble p 2 18 gas 2,8 [He] 2s2 2p6 
11 Na Sodium 22.990 alkali s 3 1 solid 2,8,1 [Ne] 3s1 +1
12 Mg Magnesium 24.305 alkaline s 3 2 solid 2,8,2 [Ne] 3s2 +2
13 Al Aluminium 26.982 post-transition p 3 13 solid 2,8,3 [Ne] 3s2 3p1 +3
14 Si Silicon 28.085 metalloid p 3 14 solid 2,8,4 [Ne] 3s2 3p2 +4
15 P Phosphorus 30.974 nonmetal p 3 15 solid 2,8,5 [Ne] 3s2 3p3 -3,+3,+5
16 S Sulfur 32.06 nonmetal p 3 16 solid 2,8,6 [Ne] 3s2 3p4 -2,+4,+6
17 Cl Chlorine 35.45 halogen p 3 17 gas 2,8,7 [Ne] 3s2 3p5 -1,+1,+5,+7
18 Ar Argon 39.948 noble p 3 18 gas 2,8,8 [Ne] 3s2 3p6 
19 K Potassium 39.098 alkali s 4 1 solid 2,8,8,1 [Ar] 4s1 +1
20 Ca Calcium 40.078 alkaline s 4 2 solid 2,8,8,2 [Ar] 4s2 +2
21 Sc Scandium 44.956 transition d 4 3 solid 2,8,9,2 [Ar] 3d1 4s2 +3
22 Ti Titanium 47.867 transition d 4 4 solid 2,8,10,2 [Ar] 3d2 4s2 +4,+3,+2
23 V Vanadium 50.942 transition d 4 5 solid 2,8,11,2 [Ar] 3d3 4s2 +5,+4,+3
24 Cr Chromium 51.996 transition d 4 6 solid 2,8,13,1 [Ar] 3d5 4s1 +6,+3,+2
25 Mn Manganese 54.938 transition d 4 7 solid 2,8,13,2 [Ar] 3d5 4s2 +7,+4,+2
26 Fe Iron 55.845 transition d 4 8 solid 2,8,14,2 [Ar] 3d6 4s2 +3,+2
27 Co Cobalt 58.933 transition d 4 9 solid 2,8,15,2 [Ar] 3d7 4s2 +3,+2
28 Ni Nickel 58.693 transition d 4 10 solid 2,8,16,2 [Ar] 3d8 4s2 +2
29 Cu Copper 63.546 transition d 4 11 solid 2,8,18,1 [Ar] 3d10 4s1 +2,+1
30 Zn Zinc 65.38 transition d 4 12 solid 2,8,18,2 [Ar] 3d10 4s2 +2
31 Ga Gallium 69.723 post-transition p 4 13 solid 2,8,18,3 [Ar] 3d10 4s2 4p1 +3
32 Ge Germanium 72.630 metalloid p 4 14 solid 2,8,18,4 [Ar] 3d10 4s2 4p2 +4
33 As Arsenic 74.922 metalloid p 4 15 solid 2,8,18,5 [Ar] 3d10 4s2 4p3 -3,+3,+5
34 Se Selenium 78.971 nonmetal p 4 16 solid 2,8,18,6 [Ar] 3d10 4s2 4p4 -2,+4,+6
35 Br Bromine 79.904 halogen p 4 17 liquid 2,8,18,7 [Ar] 3d10 4s2 4p5 -1
36 Kr Krypton 83.798 noble p 4 18 gas 2,8,18,8 [Ar] 3d10 4s2 4p6 
37 Rb Rubidium 85.468 alkali s 5 1 solid 2,8,18,8,1 [Kr] 5s1 +1
38 Sr Strontium 87.62 alkaline s 5 2 solid 2,8,18,8,2 [Kr] 5s2 +2
39 Y Yttrium 88.906 transition d 5 3 solid 2,8,18,9,2 [Kr] 4d1 5s2 +3
40 Zr Zirconium 91.224 transition d 5 4 solid 2,8,18,10,2 [Kr] 4d2 5s2 +4
41 Nb Niobium 92.906 transition d 5 5 solid 2,8,18,12,1 [Kr] 4d4 5s1 +5
42 Mo Molybdenum 95.95 transition d 5 6 solid 2,8,18,13,1 [Kr] 4d5 5s1 +6
43 Tc Technetium 98 transition d 5 7 solid 2,8,18,13,2 [Kr] 4d5 5s2 +7
44 Ru Ruthenium 101.07 transition d 5 8 solid 2,8,18,15,1 [Kr] 4d7 5s1 +4,+3
45 Rh Rhodium 102.91 transition d 5 9 solid 2,8,18,16,1 [Kr] 4d8 5s1 +3
46 Pd Palladium 106.42 transition d 5 10 solid 2,8,18,18 [Kr] 4d10 +2,+4
47 Ag Silver 107.87 transition d 5 11 solid 2,8,18,18,1 [Kr] 4d10 5s1 +1
48 Cd Cadmium 112.41 transition d 5 12 solid 2,8,18,18,2 [Kr] 4d10 5s2 +2
49 In Indium 114.82 post-transition p 5 13 solid 2,8,18,18,3 [Kr] 4d10 5s2 5p1 +3
50 Sn Tin 118.71 post-transition p 5 14 solid 2,8,18,18,4 [Kr] 4d10 5s2 5p2 +4,+2
51 Sb Antimony 121.76 metalloid p 5 15 solid 2,8,18,18,5 [Kr] 4d10 5s2 5p3 -3,+3,+5
52 Te Tellurium 127.60 metalloid p 5 16 solid 2,8,18,18,6 [Kr] 4d10 5s2 5p4 -2,+4,+6
53 I Iodine 126.90 halogen p 5 17 solid 2,8,18,18,7 [Kr] 4d10 5s2 5p5 -1
54 Xe Xenon 131.29 noble p 5 18 gas 2,8,18,18,8 [Kr] 4d10 5s2 5p6 
55 Cs Caesium 132.91 alkali s 6 1 solid 2,8,18,18,8,1 [Xe] 6s1 +1
56 Ba Barium 137.33 alkaline s 6 2 solid 2,8,18,18,8,2 [Xe] 6s2 +2
57 La Lanthanum 138.91 lanthanide d 6 3 solid 2,8,18,18,9,2 [Xe] 5d1 6s2 +3
58 Ce Cerium 140.12 lanthanide f 6 None solid 2,8,18,19,9,2 [Xe] 4f1 5d1 6s2 +3,+4
59 Pr Praseodymium 140.91 lanthanide f 6 None solid 2,8,18,21,8,2 [Xe] 4f3 6s2 +3
60 Nd Neodymium 144.24 lanthanide f 6 None solid 2,8,18,22,8,2 [Xe] 4f4 6s2 +3
61 Pm Promethium 145 lanthanide f 6 None solid 2,8,18,23,8,2 [Xe] 4f5 6s2 +3
62 Sm Samarium 150.36 lanthanide f 6 None solid 2,8,18,24,8,2 [Xe] 4f6 6s2 +3
63 Eu Europium 151.96 lanthanide f 6 None solid 2,8,18,25,8,2 [Xe] 4f7 6s2 +3,+2
64 Gd Gadolinium 157.25 lanthanide f 6 None solid 2,8,18,25,9,2 [Xe] 4f7 5d1 6s2 +3
65 Tb Terbium 158.93 lanthanide f 6 None solid 2,8,18,27,8,2 [Xe] 4f9 6s2 +3
66 Dy Dysprosium 162.50 lanthanide f 6 None solid 2,8,18,28,8,2 [Xe] 4f10 6s2 +3
67 Ho Holmium 164.93 lanthanide f 6 None solid 2,8,18,29,8,2 [Xe] 4f11 6s2 +3
68 Er Erbium 167.26 lanthanide f 6 None solid 2,8,18,30,8,2 [Xe] 4f12 6s2 +3
69 Tm Thulium 168.93 lanthanide f 6 None solid 2,8,18,31,8,2 [Xe] 4f13 6s2 +3
70 Yb Ytterbium 173.05 lanthanide f 6 None solid 2,8,18,32,8,2 [Xe] 4f14 6s2 +3,+2
71 Lu Lutetium 174.97 lanthanide d 6 None solid 2,8,18,32,9,2 [Xe] 4f14 5d1 6s2 +3
72 Hf Hafnium 178.49 transition d 6 4 solid 2,8,18,32,10,2 [Xe] 4f14 5d2 6s2 +4
73 Ta Tantalum 180.95 transition d 6 5 solid 2,8,18,32,11,2 [Xe] 4f14 5d3 6s2 +5
74 W Tungsten 183.84 transition d 6 6 solid 2,8,18,32,12,2 [Xe] 4f14 5d4 6s2 +6
75 Re Rhenium 186.21 transition d 6 7 solid 2,8,18,32,13,2 [Xe] 4f14 5d5 6s2 +7
76 Os Osmium 190.23 transition d 6 8 solid 2,8,18,32,14,2 [Xe] 4f14 5d6 6s2 +4,+8
77 Ir Iridium 192.22 transition d 6 9 solid 2,8,18,32,15,2 [Xe] 4f14 5d7 6s2 +4,+3
78 Pt Platinum 195.08 transition d 6 10 solid 2,8,18,32,17,1 [Xe] 4f14 5d9 6s1 +2,+4
79 Au Gold 196.97 transition d 6 11 solid 2,8,18,32,18,1 [Xe] 4f14 5d10 6s1 +3,+1
80 Hg Mercury 200.59 transition d 6 12 liquid 2,8,18,32,18,2 [Xe] 4f14 5d10 6s2 +2,+1
81 Tl Thallium 204.38 post-transition p 6 13 solid 2,8,18,32,18,3 [Xe] 4f14 5d10 6s2 6p1 +1,+3
82 Pb Lead 207.2 post-transition p 6 14 solid 2,8,18,32,18,4 [Xe] 4f14 5d10 6s2 6p2 +2,+4
83 Bi Bismuth 208.98 post-transition p 6 15 solid 2,8,18,32,18,5 [Xe] 4f14 5d10 6s2 6p3 +3,+5
84 Po Polonium 209 post-transition p 6 16 solid 2,8,18,32,18,6 [Xe] 4f14 5d10 6s2 6p4 +2,+4
85 At Astatine 210 halogen p 6 17 solid 2,8,18,32,18,7 [Xe] 4f14 5d10 6s2 6p5 -1
86 Rn Radon 222 noble p 6 18 gas 2,8,18,32,18,8 [Xe] 4f14 5d10 6s2 6p6 
87 Fr Francium 223 alkali s 7 1 solid 2,8,18,32,18,8,1 [Rn] 7s1 +1
88 Ra Radium 226 alkaline s 7 2 solid 2,8,18,32,18,8,2 [Rn] 7s2 +2
89 Ac Actinium 227 actinide d 7 3 solid 2,8,18,32,18,9,2 [Rn] 6d1 7s2 +3
90 Th Thorium 232.04 actinide f 7 None solid 2,8,18,32,18,10,2 [Rn] 6d2 7s2 +4
91 Pa Protactinium 231.04 actinide f 7 None solid 2,8,18,32,20,9,2 [Rn] 5f2 6d1 7s2 +5
92 U Uranium 238.03 actinide f 7 None solid 2,8,18,32,21,9,2 [Rn] 5f3 6d1 7s2 +6,+4
93 Np Neptunium 237 actinide f 7 None solid 2,8,18,32,22,9,2 [Rn] 5f4 6d1 7s2 +5
94 Pu Plutonium 244 actinide f 7 None solid 2,8,18,32,24,8,2 [Rn] 5f6 7s2 +4
95 Am Americium 243 actinide f 7 None solid 2,8,18,32,25,8,2 [Rn] 5f7 7s2 +3
96 Cm Curium 247 actinide f 7 None solid 2,8,18,32,25,9,2 [Rn] 5f7 6d1 7s2 +3
97 Bk Berkelium 247 actinide f 7 None solid 2,8,18,32,27,8,2 [Rn] 5f9 7s2 +3
98 Cf Californium 251 actinide f 7 None solid 2,8,18,32,28,8,2 [Rn] 5f10 7s2 +3
99 Es Einsteinium 252 actinide f 7 None solid 2,8,18,32,29,8,2 [Rn] 5f11 7s2 +3
100 Fm Fermium 257 actinide f 7 None solid 2,8,18,32,30,8,2 [Rn] 5f12 7s2 +3
101 Md Mendelevium 258 actinide f 7 None solid 2,8,18,32,31,8,2 [Rn] 5f13 7s2 +3
102 No Nobelium 259 actinide f 7 None solid 2,8,18,32,32,8,2 [Rn] 5f14 7s2 +2
103 Lr Lawrencium 266 actinide d 7 None solid 2,8,18,32,32,8,3 [Rn] 5f14 7s2 7p1 +3
104 Rf Rutherfordium 267 transition d 7 4 solid 2,8,18,32,32,10,2 [Rn] 5f14 6d2 7s2 +4
105 Db Dubnium 268 transition d 7 5 solid 2,8,18,32,32,11,2 [Rn] 5f14 6d3 7s2 +5
106 Sg Seaborgium 269 transition d 7 6 solid 2,8,18,32,32,12,2 [Rn] 5f14 6d4 7s2 +6
107 Bh Bohrium 270 transition d 7 7 solid 2,8,18,32,32,13,2 [Rn] 5f14 6d5 7s2 +7
108 Hs Hassium 271 transition d 7 8 solid 2,8,18,32,32,14,2 [Rn] 5f14 6d6 7s2 +8
109 Mt Meitnerium 278 transition d 7 9 solid 2,8,18,32,32,15,2 [Rn] 5f14 6d7 7s2 +3
110 Ds Darmstadtium 281 transition d 7 10 solid 2,8,18,32,32,17,1 [Rn] 5f14 6d9 7s1 +6
111 Rg Roentgenium 282 transition d 7 11 solid 2,8,18,32,32,18,1 [Rn] 5f14 6d10 7s1 +3
112 Cn Copernicium 285 transition d 7 12 solid 2,8,18,32,32,18,2 [Rn] 5f14 6d10 7s2 +2
113 Nh Nihonium 286 post-transition p 7 13 solid 2,8,18,32,32,18,3 [Rn] 5f14 6d10 7s2 7p1 +1
114 Fl Flerovium 289 post-transition p 7 14 solid 2,8,18,32,32,18,4 [Rn] 5f14 6d10 7s2 7p2 +2
115 Mc Moscovium 290 post-transition p 7 15 solid 2,8,18,32,32,18,5 [Rn] 5f14 6d10 7s2 7p3 +1
116 Lv Livermorium 293 post-transition p 7 16 solid 2,8,18,32,32,18,6 [Rn] 5f14 6d10 7s2 7p4 +2
117 Ts Tennessine 294 halogen p 7 17 solid 2,8,18,32,32,18,7 [Rn] 5f14 6d10 7s2 7p5 -1
118 Og Oganesson 294 noble p 7 18 gas 2,8,18,32,32,18,8 [Rn] 5f14 6d10 7s2 7p6 
""".strip()

CAT = {
    "alkali": "alkali-metal",
    "alkaline": "alkaline-earth",
    "transition": "transition-metal",
    "post-transition": "post-transition",
    "metalloid": "metalloid",
    "nonmetal": "reactive-nonmetal",
    "halogen": "reactive-nonmetal",
    "noble": "noble-gas",
    "lanthanide": "lanthanide",
    "actinide": "actinide",
}

LABEL = {
    "alkali-metal": "Alkali metal",
    "alkaline-earth": "Alk. earth",
    "transition-metal": "Transition metal",
    "post-transition": "Post-transition",
    "metalloid": "Metalloid",
    "reactive-nonmetal": "Nonmetal",
    "noble-gas": "Noble gas",
    "lanthanide": "Lanthanide",
    "actinide": "Actinide",
}

LATTICE = {
    6: "Hexagonal (graphite)",
    14: "Diamond cubic",
    22: "Hexagonal (HCP)",
    26: "BCC",
    13: "FCC",
    29: "FCC",
    47: "FCC",
    79: "FCC",
    82: "FCC",
}

# radius, EN, IE already in PROPS. Fill remaining with None via lookup miss.

TRENDS = [
    {
        "zA": 6,
        "zB": 14,
        "label": "Group 14",
        "essay": "Descending from Carbon (C) to Silicon (Si) exhibits the classic inner-core shielding effect. The additional 3s²3p² shell increases the atomic radius significantly (+58%), causing valence electrons to experience a diminished effective nuclear charge (Z_eff). C–C bonds drastically outlast weaker Si–Si bonds. Silicon's network is an intrinsic semiconductor.",
        "swaps": [32, 8],
    },
    {
        "zA": 9,
        "zB": 17,
        "label": "Group 17",
        "essay": "Fluorine to chlorine is the textbook halogen step: both want one electron, but fluorine is a much fiercer oxidizer because it is smaller and more electronegative. Chlorine still disinfects and forms a wide oxo-anion ladder (ClO⁻ to ClO₄⁻) that fluorine barely copies.",
        "swaps": [35, 8],
    },
    {
        "zA": 3,
        "zB": 11,
        "label": "Group 1",
        "essay": "Lithium to sodium keeps the ns¹ pattern, but sodium’s extra shell makes the atom larger and easier to oxidize. Lithium’s small Li⁺ ion polarizes anions and dominates battery electrochemistry; sodium remains the everyday salt cation.",
        "swaps": [19, 12],
    },
    {
        "zA": 10,
        "zB": 18,
        "label": "Group 18",
        "essay": "Neon and argon are both closed-shell gases, but argon is denser and far more abundant in air. Neither forms ordinary molecules; argon’s chemistry, like krypton’s, is a specialist topic, while neon is the lighting benchmark.",
        "swaps": [36, 2],
    },
]

REACTIONS = {
    1: {
        "reactants": "2 H₂ + O₂",
        "products": "2 H₂O",
        "conditions": "Spark or flame",
        "beginner": "Hydrogen burns with oxygen to make water.",
        "intermediate": "A highly exothermic combustion used as a teaching reaction and a rocket reaction.",
        "advanced": "Illustration of a known reaction. ΔH is large and negative; it is not a lab result from this device.",
    },
    6: {
        "reactants": "C + O₂",
        "products": "CO₂",
        "conditions": "Heat, excess air",
        "beginner": "Carbon burns in air to carbon dioxide.",
        "intermediate": "Complete combustion of carbon. Incomplete combustion yields CO.",
        "advanced": "Illustration of a known reaction. Graphite and diamond both oxidize; kinetics differ.",
    },
}

LINES = {
    1: [
        {"id": "H-a", "nm": 656.28, "eV": 1.89, "transition": "n=3 → n=2", "color": "visible red", "spectrum": "both"},
        {"id": "H-b", "nm": 486.13, "eV": 2.55, "transition": "n=4 → n=2", "color": "blue-green", "spectrum": "both"},
        {"id": "H-g", "nm": 434.05, "eV": 2.86, "transition": "n=5 → n=2", "color": "blue", "spectrum": "both"},
    ],
    10: [
        {"id": "Ne-585", "nm": 585.25, "eV": 2.119, "transition": "3s[3/2]° → 3p[1/2]", "color": "visible red", "spectrum": "emission"},
        {"id": "Ne-640", "nm": 640.22, "eV": 1.937, "transition": "3s → 3p", "color": "red", "spectrum": "emission"},
        {"id": "Ne-540", "nm": 540.06, "eV": 2.296, "transition": "3s → 3p", "color": "green", "spectrum": "emission"},
    ],
    22: [
        {"id": "Ti-399", "nm": 399.86, "eV": 3.10, "transition": "Ti I", "color": "violet", "spectrum": "emission"},
    ],
    6: [
        {"id": "C-193", "nm": 193.09, "eV": 6.42, "transition": "C I", "color": "UV", "spectrum": "emission"},
    ],
    14: [
        {"id": "Si-288", "nm": 288.16, "eV": 4.30, "transition": "Si I", "color": "UV", "spectrum": "emission"},
    ],
}

ISOTOPES = {
    1: [
        {"a": 1, "mass": 1.0078, "spin": "1/2", "abundance": 0.99985, "stability": "stable", "note": "Protium"},
        {"a": 2, "mass": 2.0141, "spin": "1", "abundance": 0.00015, "stability": "stable", "note": "Deuterium"},
        {"a": 3, "mass": 3.0160, "spin": "1/2", "halfLife": "12.32 y", "decay": "β−", "stability": "trace", "note": "Tritium"},
    ],
    6: [
        {"a": 12, "mass": 12.0000, "spin": "0", "abundance": 0.9893, "stability": "stable", "note": "Primary"},
        {"a": 13, "mass": 13.0034, "spin": "1/2", "abundance": 0.0107, "stability": "stable", "note": ""},
        {"a": 14, "mass": 14.0032, "spin": "0", "halfLife": "5700 y", "decay": "β−", "stability": "trace", "note": "Radiocarbon"},
    ],
    10: [
        {"a": 20, "mass": 19.9924, "spin": "0", "abundance": 0.9048, "stability": "stable", "note": "Primary terrestrial"},
        {"a": 21, "mass": 20.9938, "spin": "3/2", "abundance": 0.0027, "stability": "stable", "note": "Nucleogenic origin"},
        {"a": 22, "mass": 21.9914, "spin": "0", "abundance": 0.0925, "stability": "stable", "note": "Stellar He burning"},
        {"a": 19, "mass": 19.0019, "spin": "1/2", "halfLife": "17.22 s", "decay": "β+", "stability": "trace", "note": "Positron emitter"},
        {"a": 24, "mass": 24.0000, "spin": "0", "halfLife": "3.38 min", "decay": "β−", "stability": "synthetic", "note": "Cluster decay product"},
    ],
    14: [
        {"a": 28, "mass": 27.9769, "spin": "0", "abundance": 0.9222, "stability": "stable", "note": "Primary"},
        {"a": 29, "mass": 28.9765, "spin": "1/2", "abundance": 0.0468, "stability": "stable", "note": ""},
        {"a": 30, "mass": 29.9738, "spin": "0", "abundance": 0.0309, "stability": "stable", "note": ""},
    ],
    22: [
        {"a": 46, "mass": 45.9526, "spin": "0", "abundance": 0.0825, "stability": "stable", "note": ""},
        {"a": 47, "mass": 46.9518, "spin": "5/2", "abundance": 0.0744, "stability": "stable", "note": ""},
        {"a": 48, "mass": 47.9479, "spin": "0", "abundance": 0.7372, "stability": "stable", "note": "Primary"},
        {"a": 49, "mass": 48.9479, "spin": "7/2", "abundance": 0.0541, "stability": "stable", "note": ""},
        {"a": 50, "mass": 49.9448, "spin": "0", "abundance": 0.0518, "stability": "stable", "note": ""},
    ],
}

GLOW = {10: {"color": "#FF6A3D", "text": "Pure orange-red ionization. High emission coefficient across 600–660 nm bands.", "kv": "1.2 kV Glow"}}

ASTRO = {
    10: "Identified in planetary nebulae (e.g. NGC 6543) via [Ne III] forbidden lines. Teaching note, not a match score.",
    1: "The Balmer series is the fingerprint of stellar atmospheres.",
}


def _spectral_lines(z: int, symbol: str) -> list[dict]:
    """Curated persistent lines, with the hand-written LINES entries winning on a clash."""
    by_nm: dict[float, dict] = {}
    for ln in list(EXTRA_LINES.get(z, [])) + list(LINES.get(z, [])):
        nm = float(ln["nm"])
        slot = next((k for k in by_nm if abs(k - nm) < 0.05), nm)
        ident = str(ln["id"])
        if ident.replace(".", "", 1).isdigit():
            ident = f"{symbol}-{nm:.2f}"
        by_nm[slot] = {
            "id": ident,
            "nm": nm,
            "eV": ln.get("eV", round(1239.84193 / nm, 3)),
            "transition": ln.get("transition", ""),
            "color": ln.get("color", ""),
            "spectrum": ln.get("spectrum", "both"),
            "frequencyHz": 299792458 / (nm * 1e-9),
        }
    return [by_nm[k] for k in sorted(by_nm)]


def parse_ox(s: str) -> tuple[list[int], int | None]:
    if not s.strip():
        return [], None
    vals = []
    for part in s.split(","):
        vals.append(int(part.replace("+", "")))
    return vals, vals[0]


def default_isotopes(z: int, mass: float) -> list[dict]:
    a = int(round(mass))
    radioactive = z >= 84 or z in {43, 61}
    return [
        {
            "a": a,
            "mass": mass,
            "spin": "",
            "abundance": None if radioactive else 1.0,
            "stability": "radioactive" if radioactive else "stable",
            "note": "Representative isotope for teaching. Not a full natural-abundance table.",
        }
    ]


def parse_all() -> list[dict]:
    elements = []
    for line in RAW.splitlines():
        parts = line.split()
        z = int(parts[0])
        symbol, name = parts[1], parts[2]
        mass = float(parts[3])
        cat_raw = parts[4]
        block = parts[5]
        period = int(parts[6])
        group = None if parts[7] == "None" else int(parts[7])
        state = parts[8]
        shells = [int(x) for x in parts[9].split(",")]
        rest = parts[10:]
        ox_raw = ""
        config_parts = []
        for token in rest:
            if token[0] in "+-" or token.lstrip("+-").isdigit():
                ox_raw = " ".join(rest[rest.index(token) :]).replace(" ", "")
                # ox was joined without commas originally like +4,+3,+2
                break
            config_parts.append(token)
        # Fix ox parse: rest after config
        # Re-parse: config is everything until a token starting with + or - or empty
        config_tokens = []
        ox_tokens = []
        seen_ox = False
        for token in rest:
            if (not seen_ox) and (token[0] in "+-" or (token[0].isdigit() and "," in token)):
                seen_ox = True
            if seen_ox:
                ox_tokens.append(token)
            else:
                config_tokens.append(token)
        config = " ".join(config_tokens)
        oxs, primary = parse_ox("".join(ox_tokens).replace(" ", ",").replace("++", "+"))
        if not oxs and ox_tokens:
            oxs, primary = parse_ox(",".join(ox_tokens))
        cat_id = CAT[cat_raw]
        tags = ["halogen"] if cat_raw == "halogen" else []
        el = {
            "z": z,
            "symbol": symbol,
            "name": name,
            "atomicWeight": mass,
            "weightKind": "representative-isotope" if z >= 93 else "standard",
            "categoryId": cat_id,
            "categoryLabel": "Halogen" if cat_raw == "halogen" else LABEL[cat_id],
            "tags": tags,
            "block": block,
            "period": period,
            "group": group,
            "standardState": state,
            "electronConfig": config,
            "electronConfigFull": config,
            "shellCounts": shells,
            "oxidationStates": oxs,
            "primaryOxidation": primary,
            "lattice": LATTICE.get(z),
            "sourceId": "compiled-v1.1",
        }
        el["summary"] = summaries(el)
        el["curriculum"] = curriculum(el)
        el["properties"] = extra_props(z)
        year, people, text = ENRICH_DISCOVERY[z]
        el["discovery"] = {"year": year, "people": people, "text": text}
        el["history"] = HISTORY[z]
        el["applications"] = apps_for(z, name)
        el["spectralLines"] = _spectral_lines(z, symbol)
        el["isotopes"] = ISOTOPES.get(z) or default_isotopes(z, mass)
        if z in GLOW:
            el["glow"] = GLOW[z]
        if z in ASTRO:
            el["astro"] = ASTRO[z]
        if z in REACTIONS:
            el["reaction"] = REACTIONS[z]
        elements.append(el)
    return elements


def main() -> None:
    elements = parse_all()
    assert len(elements) == 118, len(elements)
    pack = {
        "id": "core",
        "version": "1.1.0",
        "sciencePins": ["compiled-v1.1"],
        "trendNotes": TRENDS,
        "elements": elements,
    }
    preview_z = {1, 6, 10, 14, 22}
    preview = {
        **pack,
        "id": "preview",
        "elements": [e for e in elements if e["z"] in preview_z],
        "trendNotes": TRENDS,
    }
    out = Path(__file__).resolve().parents[1] / "assets" / "catalog"
    out.mkdir(parents=True, exist_ok=True)
    (out / "core.json").write_text(json.dumps(pack, indent=2), encoding="utf-8")
    (out / "preview.json").write_text(json.dumps(preview, indent=2), encoding="utf-8")
    print("wrote", len(elements), "elements")


if __name__ == "__main__":
    main()
