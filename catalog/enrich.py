"""Teaching copy, properties, discovery, and uses for all 118 elements."""

from __future__ import annotations

# z: (covalent_pm, Pauling_EN or 0, IE_eV, mp_K, bp_K, density_g_cm3)
# 0 means omit. Superheavies often have no condensed-phase numbers.
PROPS: dict[int, tuple[float, float, float, float, float, float]] = {
    1: (31, 2.20, 13.598, 13.99, 20.27, 8.4e-5),
    2: (28, 0, 24.587, 0.95, 4.22, 1.785e-4),
    3: (128, 0.98, 5.392, 453.65, 1603, 0.534),
    4: (96, 1.57, 9.323, 1560, 2742, 1.85),
    5: (84, 2.04, 8.298, 2349, 4200, 2.34),
    6: (76, 2.55, 11.260, 3823, 4098, 2.267),
    7: (71, 3.04, 14.534, 63.15, 77.355, 1.251e-3),
    8: (66, 3.44, 13.618, 54.36, 90.188, 1.429e-3),
    9: (57, 3.98, 17.423, 53.48, 85.03, 1.696e-3),
    10: (58, 0, 21.565, 24.56, 27.07, 9.0e-4),
    11: (166, 0.93, 5.139, 370.87, 1156, 0.968),
    12: (141, 1.31, 7.646, 923, 1363, 1.738),
    13: (121, 1.61, 5.986, 933.47, 2792, 2.70),
    14: (111, 1.90, 8.152, 1687, 3538, 2.329),
    15: (107, 2.19, 10.487, 317.3, 553.5, 1.823),
    16: (105, 2.58, 10.360, 388.36, 717.8, 2.067),
    17: (102, 3.16, 12.968, 171.6, 239.11, 3.2e-3),
    18: (106, 0, 15.760, 83.81, 87.30, 1.784e-3),
    19: (203, 0.82, 4.341, 336.7, 1032, 0.89),
    20: (176, 1.00, 6.113, 1115, 1757, 1.54),
    21: (170, 1.36, 6.561, 1814, 3109, 2.99),
    22: (160, 1.54, 6.828, 1941, 3560, 4.506),
    23: (153, 1.63, 6.746, 2183, 3680, 6.11),
    24: (139, 1.66, 6.767, 2180, 2944, 7.15),
    25: (139, 1.55, 7.434, 1519, 2334, 7.47),
    26: (132, 1.83, 7.902, 1811, 3134, 7.874),
    27: (126, 1.88, 7.881, 1768, 3200, 8.90),
    28: (124, 1.91, 7.640, 1728, 3186, 8.908),
    29: (132, 1.90, 7.726, 1357.8, 2835, 8.96),
    30: (122, 1.65, 9.394, 692.68, 1180, 7.14),
    31: (122, 1.81, 5.999, 302.91, 2673, 5.91),
    32: (120, 2.01, 7.899, 1211.4, 3106, 5.323),
    33: (119, 2.18, 9.789, 1090, 887, 5.727),
    34: (120, 2.55, 9.752, 494, 958, 4.81),
    35: (120, 2.96, 11.814, 265.8, 332.0, 3.12),
    36: (116, 3.00, 14.000, 115.78, 119.93, 3.749e-3),
    37: (220, 0.82, 4.177, 312.46, 961, 1.53),
    38: (195, 0.95, 5.695, 1050, 1655, 2.64),
    39: (190, 1.22, 6.217, 1799, 3609, 4.47),
    40: (175, 1.33, 6.634, 2128, 4682, 6.52),
    41: (164, 1.6, 6.759, 2750, 5017, 8.57),
    42: (154, 2.16, 7.092, 2896, 4912, 10.28),
    43: (147, 1.9, 7.28, 2430, 4538, 11),
    44: (146, 2.2, 7.361, 2607, 4423, 12.45),
    45: (142, 2.28, 7.459, 2237, 3968, 12.41),
    46: (139, 2.20, 8.337, 1828.1, 3236, 12.02),
    47: (145, 1.93, 7.576, 1234.9, 2435, 10.49),
    48: (144, 1.69, 8.994, 594.22, 1040, 8.65),
    49: (142, 1.78, 5.786, 429.75, 2345, 7.31),
    50: (139, 1.96, 7.344, 505.08, 2875, 7.287),
    51: (139, 2.05, 8.608, 903.78, 1860, 6.697),
    52: (138, 2.1, 9.010, 722.66, 1261, 6.24),
    53: (139, 2.66, 10.451, 386.85, 457.4, 4.933),
    54: (140, 2.60, 12.130, 161.4, 165.05, 5.894e-3),
    55: (244, 0.79, 3.894, 301.59, 944, 1.93),
    56: (215, 0.89, 5.212, 1000, 2170, 3.62),
    57: (207, 1.10, 5.577, 1193, 3737, 6.15),
    58: (204, 1.12, 5.539, 1068, 3716, 6.77),
    59: (203, 1.13, 5.473, 1208, 3403, 6.77),
    60: (201, 1.14, 5.525, 1297, 3347, 7.01),
    61: (199, 1.13, 5.582, 1315, 3273, 7.26),
    62: (198, 1.17, 5.644, 1345, 2067, 7.52),
    63: (198, 1.2, 5.670, 1099, 1802, 5.24),
    64: (196, 1.20, 6.150, 1585, 3546, 7.90),
    65: (194, 1.2, 5.864, 1629, 3503, 8.23),
    66: (192, 1.22, 5.939, 1680, 2840, 8.55),
    67: (192, 1.23, 6.022, 1734, 2873, 8.80),
    68: (189, 1.24, 6.108, 1802, 3141, 9.07),
    69: (190, 1.25, 6.184, 1818, 2223, 9.32),
    70: (187, 1.1, 6.254, 1097, 1469, 6.90),
    71: (187, 1.27, 5.426, 1925, 3675, 9.84),
    72: (175, 1.3, 6.825, 2506, 4876, 13.31),
    73: (170, 1.5, 7.549, 3290, 5731, 16.65),
    74: (162, 2.36, 7.864, 3695, 5828, 19.25),
    75: (151, 1.9, 7.833, 3459, 5869, 21.02),
    76: (144, 2.2, 8.438, 3306, 5285, 22.59),
    77: (141, 2.20, 8.967, 2719, 4403, 22.56),
    78: (136, 2.28, 8.959, 2041.4, 4098, 21.45),
    79: (136, 2.54, 9.226, 1337.3, 3129, 19.32),
    80: (132, 2.00, 10.438, 234.32, 629.88, 13.534),
    81: (145, 1.62, 6.108, 577, 1746, 11.85),
    82: (146, 2.33, 7.417, 600.61, 2022, 11.34),
    83: (148, 2.02, 7.286, 544.7, 1837, 9.78),
    84: (140, 2.0, 8.417, 527, 1235, 9.20),
    85: (150, 2.2, 9.5, 575, 610, 7),
    86: (150, 2.2, 10.748, 202, 211.5, 9.73e-3),
    87: (260, 0.7, 4.073, 300, 950, 1.87),
    88: (221, 0.9, 5.279, 973, 2010, 5.5),
    89: (215, 1.1, 5.17, 1323, 3471, 10.07),
    90: (206, 1.3, 6.307, 2023, 5061, 11.72),
    91: (200, 1.5, 5.89, 1841, 4300, 15.37),
    92: (196, 1.38, 6.194, 1405.3, 4404, 19.1),
    93: (190, 1.36, 6.266, 912, 4447, 20.2),
    94: (187, 1.28, 6.06, 912.5, 3501, 19.86),
    95: (180, 1.3, 5.993, 1449, 2880, 12),
    96: (169, 1.3, 6.02, 1613, 3383, 13.51),
    97: (168, 1.3, 6.23, 1259, 2900, 14.78),
    98: (168, 1.3, 6.30, 1173, 1743, 15.1),
    99: (165, 1.3, 6.42, 1133, 1269, 8.84),
    100: (167, 1.3, 6.50, 1800, 0, 0),
    101: (173, 1.3, 6.58, 1100, 0, 0),
    102: (176, 1.3, 6.65, 1100, 0, 0),
    103: (161, 1.3, 4.9, 1900, 0, 0),
    104: (157, 0, 6.0, 2400, 0, 0),
    105: (149, 0, 6.8, 0, 0, 0),
    106: (143, 0, 7.8, 0, 0, 0),
    107: (141, 0, 7.7, 0, 0, 0),
    108: (134, 0, 7.6, 0, 0, 0),
    109: (129, 0, 8.3, 0, 0, 0),
    110: (128, 0, 9.9, 0, 0, 0),
    111: (121, 0, 10.6, 0, 0, 0),
    112: (122, 0, 11.4, 0, 0, 0),
    113: (136, 0, 7.3, 700, 1400, 0),
    114: (143, 0, 8.5, 340, 420, 0),
    115: (162, 0, 5.9, 670, 1400, 0),
    116: (175, 0, 7.5, 709, 1085, 0),
    117: (165, 0, 7.7, 723, 883, 0),
    118: (157, 0, 8.5, 325, 450, 0),
}

# z: (year or None, people, sentence)
DISCOVERY: dict[int, tuple[int | None, str, str]] = {
    1: (1766, "Henry Cavendish", "Isolated as inflammable air; later named hydrogen by Lavoisier."),
    2: (1868, "Janssen and Lockyer", "First seen as a solar emission line; later isolated on Earth by Ramsay."),
    3: (1817, "Johan August Arfwedson", "Found in petalite; Davy isolated the metal soon after."),
    4: (1798, "Louis-Nicolas Vauquelin", "Separated from beryl as a sweet-tasting oxide, hence the name."),
    5: (1808, "Gay-Lussac and Thenard", "Isolated from borates; Davy independently reduced boron compounds."),
    6: (None, "Ancient", "Known as charcoal, soot, and diamond long before it was an element."),
    7: (1772, "Daniel Rutherford", "Isolated as the gas left after oxygen and carbon dioxide were removed from air."),
    8: (1774, "Joseph Priestley", "Prepared from mercuric oxide; Scheele found it independently."),
    9: (1886, "Henri Moissan", "Isolated by electrolysis of potassium hydrogen fluoride."),
    10: (1898, "Ramsay and Travers", "Isolated from liquefied air after argon and krypton."),
    11: (1807, "Humphry Davy", "Isolated by electrolysis of molten caustic soda."),
    12: (1808, "Humphry Davy", "Isolated by electrolysis of magnesia."),
    13: (1825, "Hans Christian Ørsted", "Prepared the metal from alumina; Wöhler improved the method."),
    14: (1824, "Jöns Jacob Berzelius", "Isolated from silica after earlier work by Gay-Lussac and Thenard."),
    15: (1669, "Hennig Brand", "Prepared from urine; the first element discovered in recorded experiment."),
    16: (None, "Ancient", "Known as brimstone in ores and volcanic deposits."),
    17: (1774, "Carl Wilhelm Scheele", "Released from hydrochloric acid and pyrolusite."),
    18: (1894, "Rayleigh and Ramsay", "Found as a denser leftover when oxygen and nitrogen were removed from air."),
    19: (1807, "Humphry Davy", "Isolated by electrolysis of molten potash."),
    20: (1808, "Humphry Davy", "Isolated from lime by electrolysis."),
    21: (1879, "Lars Fredrik Nilson", "Separated from euxenite and gadolinite earths."),
    22: (1791, "William Gregor", "Found in Cornish ilmenite; Klaproth named it after the Titans."),
    23: (1801, "Andrés Manuel del Río", "Found in Mexican ore; later confirmed by Sefström, who named vanadium."),
    24: (1797, "Louis-Nicolas Vauquelin", "Isolated from Siberian red lead ore (crocoite)."),
    25: (1774, "Johan Gottlieb Gahn", "Reduced from pyrolusite; Scheele had studied the ore."),
    26: (None, "Ancient", "Worked as metal from meteorites and bog ores for millennia."),
    27: (1735, "Georg Brandt", "Shown to be a distinct metal in Swedish cobalt ores, not bismuth."),
    28: (1751, "Axel Fredrik Cronstedt", "Isolated from niccolite; named after the German Kupfernicht, or false copper."),
    29: (None, "Ancient", "Native metal of tools, coinage, and wiring long before atomic theory."),
    30: (1746, "Andreas Sigismund Marggraf", "Isolated from calamine; known in alloys much earlier."),
    31: (1875, "Paul-Émile Lecoq de Boisbaudran", "Found spectroscopically in zinc blende, then isolated."),
    32: (1886, "Clemens Winkler", "Isolated from argyrodite; Mendeleev had predicted ekasilicon."),
    33: (1250, "Albertus Magnus", "Described as a distinct substance; isolation methods came later."),
    34: (1817, "Jöns Jacob Berzelius", "Found in the residue of sulfuric acid from Fahlun pyrite."),
    35: (1826, "Antoine Jérôme Balard", "Isolated from Montpellier brines as a brown liquid."),
    36: (1898, "Ramsay and Travers", "Isolated from liquefied air by fractional distillation."),
    37: (1861, "Robert Bunsen and Gustav Kirchhoff", "Detected by its deep-red spectral lines in lepidolite."),
    38: (1790, "Adair Crawford", "Recognized in strontianite from Strontian, Scotland."),
    39: (1794, "Johan Gadolin", "Separated from ytterbite; the metal came later."),
    40: (1789, "Martin Heinrich Klaproth", "Found in zircon; Berzelius isolated a purer sample later."),
    41: (1801, "Charles Hatchett", "Found in columbite; later unified with tantalum chemistry."),
    42: (1778, "Carl Wilhelm Scheele", "Identified in molybdenite, distinct from graphite and lead ore."),
    43: (1937, "Perrier and Segrè", "First element produced artificially, from molybdenum bombarded with deuterons."),
    44: (1844, "Karl Ernst Claus", "Isolated from Ural platinum residues."),
    45: (1803, "William Hyde Wollaston", "Separated from crude platinum."),
    46: (1803, "William Hyde Wollaston", "Isolated from platinum ores; named after the asteroid Pallas."),
    47: (None, "Ancient", "Native metal of jewelry and coinage."),
    48: (1817, "Friedrich Stromeyer", "Found as an impurity in zinc carbonate."),
    49: (1863, "Reich and Richter", "Detected by an indigo spectral line in zinc ores."),
    50: (None, "Ancient", "Worked as bronze and pewter for thousands of years."),
    51: (None, "Ancient", "Known in stibnite cosmetics and alloys."),
    52: (1782, "Franz-Joseph Müller von Reichenstein", "Found in Transylvanian gold ore; Klaproth confirmed it."),
    53: (1811, "Bernard Courtois", "Released from seaweed ash as a violet vapor."),
    54: (1898, "Ramsay and Travers", "Isolated from liquefied air; named for the strange new gas."),
    55: (1860, "Bunsen and Kirchhoff", "Detected by sky-blue spectral lines in mineral water."),
    56: (1808, "Humphry Davy", "Isolated from baryta by electrolysis."),
    57: (1839, "Carl Gustaf Mosander", "Separated from cerium earths."),
    58: (1803, "Berzelius, Hisinger, and Klaproth", "Found in cerite; the first of the lanthanide series to be isolated as an earth."),
    59: (1885, "Carl Auer von Welsbach", "Separated from didymium as a distinct earth."),
    60: (1885, "Carl Auer von Welsbach", "Separated from didymium with praseodymium."),
    61: (1945, "Marinsky, Glendenin, and Coryell", "Isolated from fission products; named for Prometheus."),
    62: (1879, "Lecoq de Boisbaudran", "Separated spectroscopically from didymium earths."),
    63: (1901, "Eugène-Anatole Demarçay", "Separated from samarium fractions."),
    64: (1880, "Jean Charles Galissard de Marignac", "Separated from yttria; named for Gadolin."),
    65: (1843, "Carl Gustaf Mosander", "Separated from yttria as erbia, later renamed."),
    66: (1886, "Lecoq de Boisbaudran", "Separated from holmium earths."),
    67: (1878, "Cleve and Delafontaine", "Separated from erbia; named for Stockholm."),
    68: (1843, "Carl Gustaf Mosander", "Separated from yttria; the name later settled on erbium."),
    69: (1879, "Per Teodor Cleve", "Separated from erbia."),
    70: (1878, "Jean Charles Galissard de Marignac", "Separated from erbia as ytterbia."),
    71: (1907, "Georges Urbain", "Separated from ytterbia; named for Lutetia (Paris)."),
    72: (1923, "Coster and Hevesy", "Found in Norwegian zircon by X-ray spectroscopy; predicted as ekazirconium."),
    73: (1802, "Anders Gustaf Ekeberg", "Isolated from tantalite; named for Tantalus."),
    74: (1783, "Juan José and Fausto Elhuyar", "Reduced from wolframite; Scheele had prepared the oxide."),
    75: (1925, "Noddack, Tacke, and Berg", "Found in molybdenite by X-ray spectroscopy."),
    76: (1803, "Tennant", "Isolated from platinum residues as a very dense metal."),
    77: (1803, "Tennant", "Isolated with osmium from platinum ores."),
    78: (1735, "Antonio de Ulloa", "Described in South American ores; later isolated in Europe."),
    79: (None, "Ancient", "Native metal of currency, electronics, and ornament."),
    80: (None, "Ancient", "Known as quicksilver in cinnabar; distilled for millennia."),
    81: (1861, "William Crookes", "Detected spectroscopically in sulfuric-acid residues."),
    82: (None, "Ancient", "Worked as plumbing, solder, and weights; toxic in modern use."),
    83: (1753, "Claude François Geoffroy", "Shown to be distinct from tin and lead."),
    84: (1898, "Marie and Pierre Curie", "Separated from pitchblende as a radioactive product of uranium."),
    85: (1940, "Corson, MacKenzie, and Segrè", "Produced by bombarding bismuth with alpha particles."),
    86: (1900, "Friedrich Ernst Dorn", "Observed as the radioactive gas from radium decay."),
    87: (1939, "Marguerite Perey", "Isolated from actinium decay as a short-lived alkali metal."),
    88: (1898, "Marie and Pierre Curie", "Separated from pitchblende; intensely radioactive."),
    89: (1899, "André-Louis Debierne", "Separated from pitchblende residues."),
    90: (1828, "Jöns Jacob Berzelius", "Isolated from thorite."),
    91: (1913, "Kasimir Fajans and Oswald Göhring", "Found as a uranium decay product; later named protactinium."),
    92: (1789, "Martin Heinrich Klaproth", "Identified in pitchblende; the metal was isolated in 1841."),
    93: (1940, "McMillan and Abelson", "Produced by neutron irradiation of uranium."),
    94: (1940, "Seaborg, McMillan, Kennedy, and Wahl", "Produced by deuteron bombardment of uranium."),
    95: (1944, "Seaborg, James, Morgan, and Ghiorso", "Isolated from plutonium irradiated in a reactor."),
    96: (1944, "Seaborg, James, and Ghiorso", "Produced by alpha bombardment of plutonium."),
    97: (1949, "Thompson, Ghiorso, and Seaborg", "Produced by alpha bombardment of americium."),
    98: (1950, "Thompson, Street, Ghiorso, and Seaborg", "Produced by alpha bombardment of curium."),
    99: (1952, "Ghiorso and coworkers", "Found in debris from the first hydrogen-bomb test."),
    100: (1952, "Ghiorso and coworkers", "Found with einsteinium in thermonuclear-test debris."),
    101: (1955, "Ghiorso, Harvey, Choppin, Thompson, and Seaborg", "Produced by alpha bombardment of einsteinium; identified atom by atom."),
    102: (1966, "Dubna and Berkeley groups", "Produced by heavy-ion fusion; naming was settled later."),
    103: (1961, "Ghiorso and coworkers", "Produced by boron ions on californium."),
    104: (1969, "Berkeley and Dubna groups", "First transactinide; naming dispute resolved as rutherfordium."),
    105: (1970, "Berkeley and Dubna groups", "Produced by heavy-ion fusion; named dubnium."),
    106: (1974, "Ghiorso and Oganessian groups", "Produced from californium and oxygen, or lead and chromium."),
    107: (1981, "Armbruster and Münzenberg", "Produced at GSI Darmstadt from bismuth and chromium."),
    108: (1984, "GSI Darmstadt", "Produced from lead and iron; named for the German state of Hesse."),
    109: (1982, "GSI Darmstadt", "Produced from bismuth and iron; named for Lise Meitner."),
    110: (1994, "GSI Darmstadt", "Produced from lead and nickel; named for Darmstadt."),
    111: (1994, "GSI Darmstadt", "Produced from bismuth and nickel; named for Röntgen."),
    112: (1996, "GSI Darmstadt", "Produced from lead and zinc; named for Copernicus."),
    113: (2004, "Riken and Dubna–Livermore", "Produced by zinc on bismuth, or americium on calcium."),
    114: (1998, "Dubna–Livermore", "Produced from plutonium and calcium; named for Flerov’s laboratory."),
    115: (2003, "Dubna–Livermore", "Produced from americium and calcium; named for Moscow."),
    116: (2000, "Dubna–Livermore", "Produced from curium and calcium; named for Livermore."),
    117: (2010, "Dubna–Livermore–ORNL", "Produced from berkelium and calcium; named for Tennessee."),
    118: (2006, "Dubna–Livermore", "Produced from californium and calcium; named for Yuri Oganessian."),
}

# Everyday + classroom hooks used to write the three depths.
HOOKS: dict[int, tuple[str, str, str]] = {
    1: ("makes water and fuels stars", "H–H single bond; proton is the nucleus", "Balmer lines; isotopes protium, deuterium, tritium"),
    2: ("party balloons and cryogenics", "closed 1s² shell; almost no compounds", "lowest boiling point; quantum fluid below 2.17 K"),
    3: ("rechargeable-battery metal", "ns¹ alkali; very low ionization energy", "forms Li⁺ with a small, polarizing cation"),
    4: ("light structural alloys", "ns² alkaline earth; +2 chemistry", "high melting point for a group-2 metal"),
    5: ("borosilicate glass and detergents", "electron-deficient bonds; allotropes", "planar BX₃ vs tetrahedral borates"),
    6: ("backbone of living molecules", "catenation; diamond vs graphite", "sp² vs sp³; C–C bond energy dwarfs Si–Si"),
    7: ("78% of dry air; amino acids", "triple bond in N₂; inert at room T", "Haber–Bosch; oxidation states −3 to +5"),
    8: ("you breathe it; water’s oxygen", "diradical O₂; supports combustion", "oxides, peroxides, ozone photochemistry"),
    9: ("toothpaste fluoride; strongest oxidizer", "highest electronegativity", "almost always −1; HF hydrogen bonding"),
    10: ("orange-red discharge tubes", "closed p⁶ shell; no stable molecules", "many visible emission lines; sonified as THz/10¹²"),
    11: ("table salt’s metal", "soft alkali; vigorous with water", "Na⁺ is the main extracellular cation"),
    12: ("chlorophyll’s metal; light alloys", "+2 chemistry; burns with a bright flame", "Grignard reagents; less reactive than calcium"),
    13: ("aircraft metal; foil and cans", "amphoteric oxide; FCC metal", "protected by Al₂O₃; 3+ chemistry"),
    14: ("chips and glass", "diamond-cubic semiconductor", "band gap ~1.1 eV; weaker catenation than carbon"),
    15: ("DNA backbone and fertilizers", "white vs red allotropes", "phosphate P(V) dominates biology"),
    16: ("proteins (cysteine) and sulfuric acid", "S₈ rings; many allotropes", "oxidation −2 to +6; acid rain chemistry"),
    17: ("disinfectant and PVC", "diatomic gas; strong oxidizer", "chloride vs chlorate vs perchlorate"),
    18: ("inert welding atmosphere", "closed shell; first noble gas isolated from air", "used in K-Ar dating of rocks"),
    19: ("bananas and nerve signals", "largest common alkali ion in cells", "K⁺ Na⁺ pump; very low ionization energy"),
    20: ("bones, lime, cement", "hard water; +2 ion", "Ca²⁺ signaling; carbonate rocks"),
    21: ("first transition metal", "3d¹ 4s²; almost always +3", "similar to yttrium in size after the lanthanide contraction"),
    22: ("aircraft and white pigment (TiO₂)", "light, strong, corrosion-resistant", "passivating oxide; +4 dominates"),
    23: ("steel strengthener; catalysts", "many oxidation states +2 to +5", "V₂O₅ in contact-process sulfuric acid"),
    24: ("stainless steel and chrome plate", "half-filled 3d⁵ 4s¹ exception", "Cr(VI) is toxic; Cr(III) is the common ion"),
    25: ("steel and dry-cell batteries", "many oxidation states, +2 and +7 common in teaching", "MnO₄⁻ is a strong, purple oxidizer"),
    26: ("steel, blood’s heme, Earth’s core", "ferromagnetism; rusts in moist air", "Fe²⁺/Fe³⁺ redox in biology and industry"),
    27: ("magnets, blue glass, vitamin B₁₂", "ferromagnetic; +2/+3", "central atom in cobalamin"),
    28: ("stainless steel and coins", "corrosion resistance; +2", "Raney nickel hydrogenation catalyst"),
    29: ("wires, coins, enzymes", "excellent conductor; colored ions", "Cu²⁺ aqueous blue; bronze and brass"),
    30: ("galvanizing and enzymes", "full 3d¹⁰; always +2 in compounds", "amphoteric oxide; sacrificial anode"),
    31: ("semiconductors and low-melting alloys", "melts in your hand on a warm day", "liquid near room temperature; +3"),
    32: ("fiber optics and semiconductors", "ekasilicon; diamond-like structure", "semiconductor between Si and Sn"),
    33: ("semiconductors; toxic in some forms", "metalloid; +3 and +5", "GaAs analog; historical pigments"),
    34: ("photocopiers and dietary trace", "photoconductor; −2 analog of sulfur", "allotropes; glutathione peroxidase"),
    35: ("the liquid halogen; sanitizer", "diatomic liquid; red-brown vapor", "organobromine fire retardants"),
    36: ("bright white lamps and excimer lasers", "heavier noble gas; a few fluorides", "KrF₂; used in lighting mixtures"),
    37: ("research alkali; photocells", "softer and more reactive than potassium", "lowest density after lithium among solids here"),
    38: ("fireworks crimson; bones analog", "like calcium but larger", "⁹⁰Sr is a fission-product bone seeker"),
    39: ("phosphors and alloys", "chemically close to heavy lanthanides", "often +3; YAG lasers"),
    40: ("nuclear cladding and ceramics", "corrosion-resistant; low neutron capture", "Zr vs Hf are famously hard to separate"),
    41: ("superconducting alloys; steel", "high melting; +5 chemistry", "NbTi and Nb₃Sn magnets"),
    42: ("steel hardener; enzymes in biology", "very high melting; many oxidation states", "MoS₂ lubricant; nitrogenase cofactor"),
    43: ("no stable isotopes; medical imaging", "first artificial element", "⁹⁹ᵐTc is a common diagnostic tracer"),
    44: ("hardest platinum-group catalyst", "resists corrosion; many oxidation states", "used in electronics and wear parts"),
    45: ("catalytic converters", "inert, reflective platinum-group metal", "homogeneous catalysis (Wilkinson-type chemistry)"),
    46: ("catalytic converters and jewelry", "unique 4d¹⁰ ground state; often +2/+4", "absorbs huge volumes of hydrogen"),
    47: ("jewelry, coins, photography history", "best electrical conductor", "Ag⁺ photography and antimicrobial ions"),
    48: ("batteries and coatings; toxic", "like zinc but softer; +2", "Ni–Cd history; environmental caution"),
    49: ("solders and ITO coatings", "low melting; +3", "transparent conductors as indium tin oxide"),
    50: ("solder, tin plate, pewter", "allotropes gray/white tin", "organotin chemistry; +2 and +4"),
    51: ("alloys and flame retardants", "metalloid; +3/+5", "semiconductor with a layered structure"),
    52: ("steel alloys and solar", "metalloid analog of selenium", "CdTe cousin chemistry in the group"),
    53: ("thyroid hormone and antiseptic", "solid halogen; violet vapor", "iodide/iodate; organoiodine imaging agents"),
    54: ("bright lamps and ion propulsion", "noble gas that forms fluorides and oxides", "XeF₂, XeO₄; high-intensity lamps"),
    55: ("photocells; most electropositive stable metal", "lowest ionization energy of stable elements", "liquid near room temperature"),
    56: ("X-ray contrast historically; green fireworks", "heavy alkaline earth; +2", "soluble toxic salts; sulfate is insoluble"),
    57: ("camera lenses and catalysts", "start of the f-block story in teaching tables", "often 5d¹ 6s²; +3 ion"),
    58: ("catalytic converters and lighter flints", "4f¹; +3 and +4", "CeO₂ oxygen-storage material"),
    59: ("magnets and lighter flints", "typical +3 lanthanide", "used in didymium glass"),
    60: ("powerful magnets (NdFeB)", "+3; 4f⁴", "high magnetic anisotropy in Nd₂Fe₁₄B"),
    61: ("no stable isotopes; reactor product", "all isotopes radioactive", "named for stealing fire — it has to be made"),
    62: ("magnets and nuclear-control rods", "+3; high neutron capture", "SmCo magnets"),
    63: ("red phosphors; Eu²⁺/Eu³⁺ color", "can be +2 as well as +3", "the half-filled 4f⁷ ion is relatively stable"),
    64: ("MRI contrast (Gd³⁺) and magnets", "8 unpaired electrons in Gd³⁺", "high neutron capture; used in shielding"),
    65: ("green phosphors and magnetostriction", "4f⁸; +3 and some +4", "Terfenol-D alloys"),
    66: ("magnets and phosphors", "high magnetic moment", "used in neodymium-magnet blends"),
    67: ("lasers and magnets", "sharp 4f optical lines", "Ho:YAG medical lasers"),
    68: ("optical fibers and pink glass", "+3; optical amplifier at 1.5 μm", "Er-doped fiber amplifiers"),
    69: ("portable X-ray; research metal", "dense +3 lanthanide", "high melting among the late lanthanides"),
    70: ("stainless alloys and clocks", "full 4f¹⁴; can be +2", "atomic-clock isotope ¹⁷¹Yb"),
    71: ("catalysts and phosphors", "d-block-like after 4f¹⁴", "sometimes classed as a d-block metal"),
    72: ("nuclear control rods and plasma blades", "twin of zirconium after lanthanide contraction", "very high melting; HfC ceramics"),
    73: ("capacitors and surgical tools", "extremely corrosion resistant", "Ta₂O₅ dielectric films"),
    74: ("light-bulb wire and hard alloys", "highest melting point of the metals", "WC carbides; dense d-block packing"),
    75: ("jet-engine alloys", "refractory; +7 in Re₂O₇", "one of the last stable elements found"),
    76: ("densest stable metal; fountain-pen tips", "hexagonal metal; toxic volatile tetroxide", "OsO₄ used (carefully) in staining"),
    77: ("spark plugs and crucibles", "most corrosion-resistant metal", "high melting; +3/+4 chemistry"),
    78: ("catalysts and jewelry", "unreactive; excellent electrode", "cisplatin is a Pt(II) anticancer complex"),
    79: ("money, electronics, inert electrodes", "very unreactive; excellent conductor", "relativistic 6s contraction; yellow color"),
    80: ("thermometers historically; toxic liquid metal", "liquid at room temperature", "filled 5d¹⁰ 6s²; amalgam chemistry"),
    81: ("electronics; toxic heavy metal", "+1 and +3; inert-pair effect", "Tl⁺ resembles K⁺ — that is why it is poisonous"),
    82: ("batteries and radiation shielding; toxic", "inert-pair +2 vs +4", "tetraethyllead history; Pb²⁺ in minerals"),
    83: ("low-melting alloys; some medicines history", "last stable element; ²⁰⁹Bi is nearly stable", "alpha activity is extremely slow"),
    84: ("radioactive; historically in antistatic devices", "all isotopes radioactive", "daughter of uranium/thorium chains"),
    85: ("no bulk sample; halogen beneath iodine", "shortest-lived primordial halogen analog", "chemistry inferred from tracer work"),
    86: ("radioactive indoor gas from uranium in rock", "noble gas; alpha emitter", "lung-cancer risk; ²²²Rn half-life 3.8 days"),
    87: ("no bulk uses; rarest alkali", "heaviest alkali; extremely radioactive", "most electropositive, but you will never hold it"),
    88: ("historical luminous paint; intensely radioactive", "group-2 radioelement; ²²⁶Ra", "Curies’ second new element from pitchblende"),
    89: ("start of the actinide series", "5f/6d boundary; +3", "parent of the actinium decay series"),
    90: ("gas-lantern mantles historically; nuclear fuel cycle", "all isotopes radioactive; ²³²Th is long-lived", "breeder to ²³³U; oxide ceramics"),
    91: ("scarce radioelement between Th and U", "+5 chemistry; ²³¹Pa", "exists as a uranium decay product"),
    92: ("nuclear fuel and glass color historically", "last primordial actinide in quantity", "²³⁵U fission; ²³⁸U is 99.3% of natural U"),
    93: ("first transuranic; research only", "5f⁴; several oxidation states", "produced from uranium, not mined as a commodity"),
    94: ("nuclear weapons and some reactors", "fissile ²³⁹Pu; many oxidation states", "handling is a radiotoxicity problem, not a classroom demo"),
    95: ("smoke-detector sources (²⁴¹Am)", "6d/5f actinide; +3 common", "alpha source in ionization detectors"),
    96: ("research; named for Curie", "produced from plutonium", "used as a target to make heavier actinides"),
    97: ("research; named for Berkeley", "5f⁹; +3/+4", "target for making heavier elements"),
    98: ("neutron-source research", "intense neutron emitter in some isotopes", "²⁵²Cf spontaneous fission neutrons"),
    99: ("research; found in bomb debris", "einsteinium has no macroscopic civilian use", "first seen in Ivy Mike fallout"),
    100: ("research only", "named for Fermi; atom-at-a-time chemistry", "no stable isotopes"),
    101: ("research; first identified one atom at a time", "named for Mendeleev", "chemistry tracked by ion-exchange elution"),
    102: ("research; named for Nobel", "late actinide; +2 is unusually important", "divalent chemistry like ytterbium in places"),
    103: ("end of the actinides", "sometimes +3 like lutetium", "bridge into the transactinide d-block"),
    104: ("first transactinide; research", "ekahafnium; 6d² chemistry expected", "only atom-at-a-time experiments"),
    105: ("research; named for Dubna", "ekatantalum", "short-lived; properties inferred from a few atoms"),
    106: ("research; named for Seaborg", "ekatungsten", "predicted high oxidation states like tungsten"),
    107: ("research; named for Bohr", "ekarhenium", "produced a few atoms at a time"),
    108: ("research; named for Hesse", "ekaosmium", "relativistic effects expected to matter"),
    109: ("research; named for Meitner", "ekairidium", "no chemistry beyond nuclear identification"),
    110: ("research; named for Darmstadt", "ekaplatinum", "lifetimes of milliseconds"),
    111: ("research; named for Röntgen", "ekagold", "relativistic 7s contraction predicted"),
    112: ("research; may be volatile like mercury", "ekamercury", "some experiments hint at a noble-metal vapor"),
    113: ("research; named in Japan (Riken)", "ekathallium; inert-pair +1 expected", "superheavy p-block begins here"),
    114: ("research; named for Flerov lab", "ekalead", "predicted to be relatively long-lived among superheavies"),
    115: ("research; named for Moscow", "ekabismuth", "alpha-decay chains used to identify it"),
    116: ("research; named for Livermore", "ekapolonium", "even-Z superheavy; still atom-at-a-time"),
    117: ("research; halogen analog", "ekastatine", "made from berkelium; extremely short-lived"),
    118: ("research; noble-gas analog", "eka-radon; may be more reactive than radon", "predicted condensed phase is uncertain; teaching, not a sample"),
}


def extra_props(z: int) -> dict:
    p = PROPS.get(z)
    if not p:
        return {}
    r, en, ie, mp, bp, dens = p
    out = {
        "covalentRadiusPm": r or None,
        "paulingEn": en or None,
        "ionizationEv": ie or None,
        "meltingK": mp or None,
        "boilingK": bp or None,
        "density": dens or None,
    }
    return {k: v for k, v in out.items() if v not in (None, 0)}


def _ox_text(el: dict) -> str:
    ox = el.get("oxidationStates") or []
    if not ox:
        return "Oxidation states are not listed for this entry."
    bits = [("+" if x > 0 else "") + str(x) for x in ox]
    return "Typical oxidation states: " + ", ".join(bits) + "."


def _group_text(el: dict) -> str:
    g = el.get("group")
    if g is None:
        return "It is placed in the f-block rows rather than a main group column."
    return f"It sits in group {g}."


def summaries(el: dict) -> dict:
    z = el["z"]
    name, sym = el["name"], el["symbol"]
    hook, mid, adv = HOOKS[z]
    state = el["standardState"]
    fam = el["categoryLabel"].lower()
    period = el["period"]
    return {
        "beginner": (
            f"{name} ({sym}) is element {z}. At everyday conditions it is a {state} {fam} "
            f"in period {period}. Beginners should remember the symbol, where it sits on the table, "
            f"and that people meet it as: {hook}."
        ),
        "intermediate": (
            f"{name} is a {fam} in period {period}, {_group_text(el).lower()} "
            f"Its ground-state configuration is {el['electronConfig']}, with shell counts "
            f"{', '.join(str(s) for s in el['shellCounts'])}. {_ox_text(el)} "
            f"Classroom focus: {mid}."
        ),
        "advanced": (
            f"Advanced reading for {name} (Z={z}, {el['atomicWeight']} u, {el['weightKind']}): "
            f"{el['electronConfigFull']}. {adv} "
            f"Numbers in this dossier are compiled teaching values with unit and dataset pin, "
            f"not a measurement this device just made. Neighbors differ because of shell filling"
            f"{', relativity, and nuclear stability' if z >= 72 else ''}."
        ),
    }


def curriculum(el: dict) -> dict:
    z = el["z"]
    name, sym = el["name"], el["symbol"]
    hook, mid, adv = HOOKS[z]
    return {
        "beginner": (
            f"Learn {name}: say the name, write {sym}, find Z={z} on the table, note the family "
            f"({el['categoryLabel']}), and connect it to one real use — {hook}."
        ),
        "intermediate": (
            f"Course pass on {name}: electron configuration {el['electronConfig']}, "
            f"{_ox_text(el)} {_group_text(el)} Compare one physical number (melting point, "
            f"ionization energy, or radius) with a neighbor. {mid}."
        ),
        "advanced": (
            f"Go further on {name}: justify periodic trends with Z_eff and shells; read isotopes "
            f"and any spectral lines as catalogued data; {adv} "
            f"If a reaction illustration exists, treat it as a known equation, not a simulation of your lab."
        ),
    }


def applications(z: int, name: str, hook: str) -> list[dict]:
    use, _, _ = HOOKS[z]
    return [
        {"title": "Where you meet it", "body": use[0].upper() + use[1:] + "."},
        {"title": "Classroom caution", "body": f"Element Deck describes published chemistry of {name}. It is not a protocol for handling the element."},
    ]


DEFAULT_APPS_EXTRA: dict[int, list[tuple[str, str]]] = {
    1: [("Stars", "The proton–proton chain that lights the Sun."), ("Feedstock", "Ammonia and hydrogenation.")],
    6: [("Life", "Backbone of organic molecules."), ("Materials", "Graphite, diamond, and carbon fiber.")],
    7: [("Atmosphere", "Most of dry air is N₂."), ("Fertilizer", "Ammonia from Haber–Bosch.")],
    8: [("Respiration", "Electron acceptor in aerobic life."), ("Steelmaking", "Oxidizer in the blast furnace.")],
    10: [("Lighting", "Neon discharge tubes."), ("Cryogenics", "Inert refrigerant.")],
    11: [("Salt", "NaCl in food and industry."), ("Soap", "Sodium salts of fatty acids.")],
    13: [("Transport", "Airframes and foil."), ("Power", "High-voltage lines.")],
    14: [("Electronics", "The elemental semiconductor of chips."), ("Glass", "Silica networks.")],
    17: [("Water", "Disinfection."), ("Polymers", "Vinyl chloride for PVC.")],
    22: [("Aerospace", "High strength-to-weight frames."), ("Pigment", "TiO₂ white."), ("Implants", "Bio-inert metal.")],
    26: [("Infrastructure", "Steel."), ("Biology", "Heme iron.")],
    29: [("Electrical", "Wiring."), ("Architecture", "Roofing and alloys.")],
    47: [("Electronics", "Highest electrical conductivity."), ("Currency", "Coinage metal.")],
    79: [("Electronics", "Corrosion-free contacts."), ("Monetary", "Bullion.")],
    82: [("Storage", "Lead–acid batteries."), ("Shielding", "X-ray rooms.")],
    92: [("Energy", "Fission fuel."), ("Dating", "U–Pb geochronology.")],
}


def apps_for(z: int, name: str) -> list[dict]:
    base = applications(z, name, HOOKS[z][0])
    extra = [{"title": t, "body": b} for t, b in DEFAULT_APPS_EXTRA.get(z, [])]
    return extra + base if extra else base
