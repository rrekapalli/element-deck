"""Course contracts for Beginner, Intermediate, and Advanced packs."""

from __future__ import annotations

import re

BANNED_BEGINNER = re.compile(
    r"oxidation|configuration|subshell|electronegativ|ionization|slater|Z_eff|"
    r"nuclear spin|\d[spdf]|noble-gas shorthand",
    re.IGNORECASE,
)

SYLLABUS_Z = {
    1, 6, 7, 8, 11, 12, 13, 14, 15, 16, 17, 19, 20, 26, 29, 30,
}

JEE_NOTES = {
    24: "Chromium is [Ar] 3d5 4s1, an Aufbau exception.",
    29: "Copper is [Ar] 3d10 4s1, an Aufbau exception.",
    4: "Beryllium's first ionization enthalpy is higher than boron's.",
    5: "Boron is ionized more easily than beryllium despite the extra proton.",
    7: "Nitrogen's half-filled 2p set sits above oxygen in ionization enthalpy.",
    8: "Oxygen is ionized more easily than nitrogen.",
    12: "Magnesium sits above aluminium in first ionization enthalpy.",
    13: "Aluminium is ionized more easily than magnesium.",
    3: "Lithium is diagonally related to magnesium.",
    81: "Thallium prefers +1: the inert-pair effect.",
    82: "Lead prefers +2 over +4 in many compounds: inert pair.",
    83: "Bismuth prefers +3 over +5: inert pair.",
    72: "Hafnium tracks zirconium because of lanthanoid contraction.",
}

FORMS = {
    6: [
        {
            "name": "Diamond",
            "note": {
                "beginner": "In diamond every carbon atom is tied to four neighbors. The network is hard and does not conduct electricity.",
                "intermediate": "Diamond is a covalent network of tetrahedral carbon. Each atom is sp3, and the wide gap makes the solid an insulator.",
                "advanced": "The diamond lattice is a giant covalent solid. High bond enthalpy and a large band gap follow from the tetrahedral network.",
            },
        },
        {
            "name": "Graphite",
            "note": {
                "beginner": "In graphite the atoms sit in sheets that slide. A pencil mark is one of those sheets left on paper.",
                "intermediate": "Graphite is stacked hexagonal sheets. Delocalized electrons in a sheet make it a conductor along the layers.",
                "advanced": "sp2 sheets with weak stacking forces explain cleavage, lubrication, and in-plane conductivity.",
            },
        },
    ],
    8: [
        {
            "name": "Dioxygen",
            "note": {
                "beginner": "The oxygen you breathe is two atoms joined together as O2.",
                "intermediate": "O2 is a diradical. That is why it supports combustion and is paramagnetic.",
                "advanced": "The two unpaired electrons in the π* set explain both paramagnetism and its role as an oxidant.",
            },
        },
        {
            "name": "Ozone",
            "note": {
                "beginner": "Ozone is another form of the same element: three oxygen atoms. High in the air it blocks some ultraviolet light.",
                "intermediate": "O3 is a separate allotrope with its own oxidising chemistry.",
                "advanced": "Ozone is a bent triatomic allotrope. Its UV photochemistry is a stratospheric story, not a different element.",
            },
        },
    ],
    15: [
        {
            "name": "White phosphorus",
            "note": {
                "beginner": "White phosphorus is a soft, reactive form of the element. It is not a classroom sample.",
                "intermediate": "P4 tetrahedra make white phosphorus molecular and reactive in air.",
                "advanced": "The strained P4 cage is the molecular allotrope. Red phosphorus is a polymeric network of the same atoms.",
            },
        },
        {
            "name": "Red phosphorus",
            "note": {
                "beginner": "Red phosphorus is a safer, darker form used on matchboxes.",
                "intermediate": "Red phosphorus is polymeric. It is far less reactive than the white form.",
                "advanced": "The network allotrope is the match-safe form. Same element, different connectivity.",
            },
        },
    ],
    16: [
        {
            "name": "Rhombic sulfur",
            "note": {
                "beginner": "Yellow sulfur you can hold is made of rings of eight atoms packed as crystals.",
                "intermediate": "Rhombic S8 is the stable form at room temperature.",
                "advanced": "Crown-shaped S8 rings pack in the orthorhombic crystal that is the standard state.",
            },
        },
        {
            "name": "Monoclinic sulfur",
            "note": {
                "beginner": "Warm sulfur can pack the same eight-atom rings into a different crystal shape.",
                "intermediate": "Monoclinic sulfur is the high-temperature packing of S8.",
                "advanced": "The two molecular crystals differ in packing, not in the S8 molecule itself.",
            },
        },
    ],
    50: [
        {
            "name": "White tin",
            "note": {
                "beginner": "Ordinary tin metal is the shiny white form.",
                "intermediate": "White tin is metallic and the form used in alloys.",
                "advanced": "The metallic β form is stable above 13 °C. Grey tin is a diamond-like semiconductor.",
            },
        },
        {
            "name": "Grey tin",
            "note": {
                "beginner": "In lasting cold, tin can crumble into a grey powder. It is still tin.",
                "intermediate": "Grey tin is a different solid of the same element, closer to silicon in structure.",
                "advanced": "The α allotrope is a diamond cubic semiconductor. The white-to-grey change is tin pest.",
            },
        },
    ],
}


def spectra_note(el: dict) -> dict:
    name = el["name"]
    n = len(el.get("spectralLines") or [])
    if n:
        beginner = (
            f"{name} can give off coloured light when its atoms are excited. "
            f"This pack stores {n} teaching line{'s' if n != 1 else ''} for the strip."
        )
        intermediate = (
            f"The stored lines are a teaching subset of {name}'s spectrum. "
            "Wavelength, energy, and the colour name sit on the strip."
        )
        advanced = (
            f"Assignments, when stored, are electron jumps in {name}. "
            "They are catalogued data, not a measurement this device just made."
        )
    else:
        beginner = (
            f"This pack does not draw a teaching strip of visible lines for {name}. "
            "The element still has a place on the table."
        )
        intermediate = (
            f"No persistent visible teaching lines are stored for {name}. "
            "Absence here is a pack choice, not a claim that the atom is dark."
        )
        advanced = (
            f"The empty strip for {name} means this pack did not keep a teaching subset. "
            "A specialist atlas may still list lines."
        )
    return {
        "beginner": beginner,
        "intermediate": intermediate,
        "advanced": advanced,
    }


TRENDS = [
    {
        "zA": 6,
        "zB": 14,
        "label": "Group 14",
        "swaps": [32, 8],
        "essay": "Carbon is smaller and bonds to itself more strongly than silicon. Silicon is the larger neighbor used in chips.",
        "essays": {
            "beginner": "Carbon is smaller and holds onto itself more tightly. Silicon is the larger neighbor in the same column, and it is the element in computer chips.",
            "intermediate": "Descending from carbon to silicon adds a shell. Radius rises, electronegativity falls, and C–C bonds outlast Si–Si bonds. Silicon's network is a semiconductor.",
            "advanced": "The extra 3s2 3p2 shell increases radius and lowers Z_eff at the valence edge. Bond enthalpy drops from C–C to Si–Si, and the diamond-cubic network of silicon is an intrinsic semiconductor.",
        },
    },
    {
        "zA": 9,
        "zB": 17,
        "label": "Group 17",
        "swaps": [35, 8],
        "essay": "Fluorine is a fiercer oxidizer than chlorine because it is smaller.",
        "essays": {
            "beginner": "Fluorine and chlorine both sit in the halogen column. Fluorine is smaller and more eager to join other elements. Chlorine is the gas used to treat water.",
            "intermediate": "Both want one electron. Fluorine is smaller and more electronegative, so it is the stronger oxidizer. Chlorine still forms a wide oxo-anion ladder.",
            "advanced": "The F–F bond is weak and the atom is small, so fluorine oxidizes almost everything. Chlorine's oxoacid ladder is a size-and-oxidation-state story fluorine barely copies.",
        },
    },
    {
        "zA": 3,
        "zB": 11,
        "label": "Group 1",
        "swaps": [19, 12],
        "essay": "Sodium is larger and easier to oxidize than lithium.",
        "essays": {
            "beginner": "Lithium and sodium are both soft metals that react with water. Sodium is the metal in table salt. Lithium is the metal in rechargeable batteries.",
            "intermediate": "Both are ns1. Sodium's extra shell makes the atom larger and easier to oxidize. Lithium is diagonally related to magnesium.",
            "advanced": "Li+ is small and polarizing; Na+ is the everyday aqueous cation. The first ionization enthalpy falls down the group as the valence electron sits farther out.",
        },
    },
    {
        "zA": 11,
        "zB": 19,
        "label": "Group 1",
        "swaps": [3, 12],
        "essay": "Potassium is larger and more reactive than sodium.",
        "essays": {
            "beginner": "Sodium and potassium are both alkali metals. Potassium is larger, and it reacts even more readily with water.",
            "intermediate": "Down group 1, radius rises and ionization enthalpy falls. Potassium is more reactive than sodium in water.",
            "advanced": "The 4s electron of potassium is held more weakly than sodium's 3s electron. Flame colours differ because the resonance lines sit at different wavelengths.",
        },
    },
    {
        "zA": 8,
        "zB": 16,
        "label": "Group 16",
        "swaps": [34, 7],
        "essay": "Oxygen is a gas of O2; sulfur is a yellow solid of S8 rings.",
        "essays": {
            "beginner": "Oxygen is the gas you breathe. Sulfur is a yellow solid in the same column. Both like to join two other atoms in many compounds.",
            "intermediate": "Oxygen is O2; sulfur prefers S8 rings. Down the group, catenation grows and the –2 state is still common.",
            "advanced": "The small size and high electronegativity of oxygen shut down catenation that sulfur shows freely. Multiple bonding is easier for oxygen than for sulfur.",
        },
    },
    {
        "zA": 3,
        "zB": 12,
        "label": "Diagonal",
        "swaps": [11, 4],
        "essay": "Lithium is diagonally related to magnesium.",
        "essays": {
            "beginner": "Lithium sits above sodium, but in some ways it behaves like magnesium, the metal one step down and one step across.",
            "intermediate": "The Li–Mg diagonal pair is a Class 11 fact: similar charge density and covalent character in some compounds.",
            "advanced": "Similar polarizing power of Li+ and Mg2+ produces the diagonal relationship: nitrides, carbonates that decompose, and organometallic chemistry.",
        },
    },
    {
        "zA": 7,
        "zB": 15,
        "label": "Group 15",
        "swaps": [33, 8],
        "essay": "Nitrogen is a triple-bonded gas; phosphorus is a solid that burns more readily.",
        "essays": {
            "beginner": "Nitrogen is most of the air and is hard to break apart. Phosphorus is a solid in the same column, and some forms of it burn easily.",
            "intermediate": "N2 has a triple bond, so it is inert at room temperature. Phosphorus has weaker P–P bonds and several allotropes.",
            "advanced": "The N≡N bond enthalpy is why air is a nitrogen reservoir. Phosphorus lacks a stable P2 triple-bond allotrope at room temperature and catenates instead.",
        },
    },
    {
        "zA": 10,
        "zB": 18,
        "label": "Group 18",
        "swaps": [36, 2],
        "essay": "Neon and argon are closed-shell gases. Argon is denser and more abundant in air.",
        "essays": {
            "beginner": "Neon and argon almost never join other elements. Neon glows orange-red in a tube. Argon is a larger part of air.",
            "intermediate": "Both are closed-shell gases. Argon is denser and far more abundant in air than neon.",
            "advanced": "Closed np6 shells suppress ordinary molecules. Argon's chemistry, like krypton's, is a specialist topic; neon is the lighting benchmark.",
        },
    },
]
