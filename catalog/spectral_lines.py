"""Prominent atomic lines for the Spectra room.

Air wavelengths in nm, teaching selection from the NIST Handbook of Basic
Atomic Spectroscopic Data (persistent and strong lines). Not a full spectrum.
Lines already listed in generate_catalog.LINES are kept and not repeated here.
"""

from __future__ import annotations


def _band(nm: float) -> str:
    if nm < 380:
        return "UV"
    if nm < 450:
        return "violet"
    if nm < 495:
        return "blue"
    if nm < 570:
        return "green"
    if nm < 590:
        return "yellow"
    if nm < 620:
        return "orange"
    if nm < 780:
        return "red"
    return "near-IR"


def L(nm: float, transition: str, spectrum: str = "both") -> dict:
    return {
        "id": f"{nm:.2f}",
        "nm": nm,
        "transition": transition,
        "color": _band(nm),
        "spectrum": spectrum,
    }


# z -> lines. Ids are filled with the element symbol in generate_catalog.
LINES: dict[int, list[dict]] = {
    1: [L(410.17, "n=6 → n=2")],
    2: [
        L(388.86, "He I", "emission"),
        L(447.15, "He I", "emission"),
        L(471.31, "He I", "emission"),
        L(492.19, "He I", "emission"),
        L(501.57, "He I", "emission"),
        L(587.56, "He I", "emission"),
        L(667.82, "He I", "emission"),
        L(706.52, "He I", "emission"),
    ],
    3: [L(610.36, "Li I"), L(670.78, "Li I")],
    4: [L(234.86, "Be I"), L(457.27, "Be I")],
    5: [L(249.68, "B I"), L(249.77, "B I")],
    7: [L(744.23, "N I"), L(746.83, "N I")],
    8: [L(777.19, "O I"), L(777.42, "O I"), L(777.54, "O I")],
    11: [L(588.995, "Na I"), L(589.592, "Na I")],
    12: [L(516.73, "Mg I"), L(517.27, "Mg I"), L(518.36, "Mg I")],
    13: [L(394.40, "Al I"), L(396.15, "Al I")],
    14: [L(251.61, "Si I"), L(390.55, "Si I")],
    18: [
        L(696.54, "Ar I", "emission"),
        L(706.72, "Ar I", "emission"),
        L(738.40, "Ar I", "emission"),
        L(750.39, "Ar I", "emission"),
        L(763.51, "Ar I", "emission"),
    ],
    19: [L(404.41, "K I"), L(404.72, "K I"), L(766.49, "K I"), L(769.90, "K I")],
    20: [L(393.37, "Ca II"), L(396.85, "Ca II"), L(422.67, "Ca I"), L(445.48, "Ca I")],
    21: [L(391.18, "Sc I"), L(402.04, "Sc I"), L(402.37, "Sc I")],
    22: [L(498.17, "Ti I"), L(499.11, "Ti I"), L(501.42, "Ti I")],
    23: [L(437.92, "V I"), L(438.47, "V I"), L(440.85, "V I")],
    24: [
        L(425.43, "Cr I"),
        L(427.48, "Cr I"),
        L(428.97, "Cr I"),
        L(520.45, "Cr I"),
        L(520.60, "Cr I"),
        L(520.84, "Cr I"),
    ],
    25: [L(403.08, "Mn I"), L(403.31, "Mn I"), L(403.45, "Mn I")],
    26: [
        L(371.99, "Fe I"),
        L(373.49, "Fe I"),
        L(374.95, "Fe I"),
        L(438.35, "Fe I"),
        L(440.48, "Fe I"),
        L(516.75, "Fe I"),
        L(527.04, "Fe I"),
    ],
    27: [L(340.51, "Co I"), L(345.35, "Co I"), L(399.53, "Co I")],
    28: [L(341.48, "Ni I"), L(351.51, "Ni I"), L(352.45, "Ni I")],
    29: [
        L(324.75, "Cu I"),
        L(327.40, "Cu I"),
        L(510.55, "Cu I"),
        L(515.32, "Cu I"),
        L(521.82, "Cu I"),
    ],
    30: [L(213.86, "Zn I"), L(472.22, "Zn I"), L(481.05, "Zn I"), L(636.23, "Zn I")],
    31: [L(403.30, "Ga I"), L(417.21, "Ga I")],
    32: [L(265.12, "Ge I"), L(303.91, "Ge I")],
    33: [L(189.04, "As I"), L(193.70, "As I"), L(228.81, "As I")],
    34: [L(196.03, "Se I"), L(203.99, "Se I")],
    36: [L(557.03, "Kr I", "emission"), L(587.09, "Kr I", "emission")],
    37: [L(420.18, "Rb I"), L(421.55, "Rb I"), L(780.03, "Rb I"), L(794.76, "Rb I")],
    38: [L(407.77, "Sr II"), L(421.55, "Sr II"), L(460.73, "Sr I")],
    39: [L(407.74, "Y I"), L(410.24, "Y I"), L(412.83, "Y I"), L(414.28, "Y I")],
    40: [L(339.20, "Zr I"), L(343.82, "Zr I"), L(349.62, "Zr I")],
    41: [L(405.89, "Nb I"), L(407.97, "Nb I")],
    42: [L(379.83, "Mo I"), L(386.41, "Mo I"), L(390.30, "Mo I")],
    44: [L(349.89, "Ru I"), L(372.80, "Ru I")],
    45: [L(343.49, "Rh I"), L(369.24, "Rh I")],
    46: [L(340.46, "Pd I"), L(363.47, "Pd I")],
    47: [L(328.07, "Ag I"), L(338.29, "Ag I"), L(520.91, "Ag I"), L(546.55, "Ag I")],
    48: [L(228.80, "Cd I"), L(508.58, "Cd I"), L(643.85, "Cd I")],
    49: [L(410.18, "In I"), L(451.13, "In I")],
    50: [L(284.00, "Sn I"), L(317.51, "Sn I"), L(326.23, "Sn I")],
    51: [L(206.83, "Sb I"), L(217.58, "Sb I"), L(231.15, "Sb I")],
    52: [L(214.28, "Te I"), L(238.58, "Te I")],
    54: [L(462.43, "Xe I", "emission"), L(467.12, "Xe I", "emission")],
    55: [L(455.53, "Cs I"), L(459.32, "Cs I"), L(852.11, "Cs I"), L(894.35, "Cs I")],
    56: [L(455.40, "Ba II"), L(493.41, "Ba II"), L(553.55, "Ba I")],
    57: [L(394.91, "La I"), L(407.74, "La I"), L(550.13, "La I")],
    63: [L(459.40, "Eu I"), L(462.72, "Eu I"), L(466.19, "Eu I")],
    70: [L(398.80, "Yb I")],
    74: [L(400.88, "W I"), L(407.44, "W I"), L(429.46, "W I")],
    75: [L(346.05, "Re I"), L(346.47, "Re I")],
    76: [L(290.91, "Os I")],
    78: [L(265.95, "Pt I"), L(306.47, "Pt I")],
    79: [L(242.80, "Au I"), L(267.60, "Au I")],
    80: [
        L(253.65, "Hg I"),
        L(404.66, "Hg I"),
        L(435.83, "Hg I"),
        L(546.07, "Hg I"),
        L(576.96, "Hg I"),
        L(579.07, "Hg I"),
    ],
    81: [L(276.79, "Tl I"), L(351.92, "Tl I"), L(377.57, "Tl I"), L(535.05, "Tl I")],
    82: [L(217.00, "Pb I"), L(283.31, "Pb I"), L(368.35, "Pb I"), L(405.78, "Pb I")],
    83: [L(222.82, "Bi I"), L(306.77, "Bi I")],
    90: [L(401.91, "Th I")],
    92: [L(591.54, "U I")],
}
