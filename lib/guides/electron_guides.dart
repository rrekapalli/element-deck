import 'property_guide.dart';

const electronGuides = <PropertyGuide>[
  PropertyGuide(
    id: GuideId.configuration,
    title: 'Configuration',
    group: 'Electrons',
    lede: 'The configuration is the ground-state assignment of the atom\'s electrons to subshells. It is the long form: every subshell is written out, from 1s up through the valence shell.',
    sections: [
      GuideSection(
        'How to read the notation',
        'A piece such as 2p6 means the principal shell n = 2, the p subshell (orbital angular momentum l = 1), holding 6 electrons. The letters run s, p, d, f for l = 0, 1, 2, 3. A full configuration is the sequence of those pieces. Carbon is 1s2 2s2 2p2. The total of the superscripts is Z, the electron count of the neutral atom.\n\n'
            'The order is the building-up order, not always the order of energies in the finished atom. Students learn 4s before 3d because that is the order the levels fill across the table. In a transition-metal ion the 4s electrons are often the ones that leave first. The configuration on this row is the neutral atom\'s ground state, as the catalog records it. It is not a promise about the ion.',
      ),
      GuideSection(
        'How the notation was built',
        'Niels Bohr\'s 1913 orbits explained hydrogen and suggested that other atoms filled successive shells. The details needed three more ideas. Wolfgang Pauli\'s exclusion principle, in 1925, limits a given orbital to two electrons of opposite spin. Hund\'s rule, the same year, says that within a subshell electrons stay unpaired as long as they can. The Schrödinger equation, in 1926, replaced orbits with orbitals labeled by quantum numbers. The little letters s, p, d, and f were already in use for spectral series. They were reused for the orbitals.\n\n'
            'The Madelung rule, also called the n + l rule, is the recipe that produces the familiar order. It is empirical. Chromium is 3d5 4s1, not 3d4 4s2. Copper is 3d10 4s1. Palladium is 4d10. Those exceptions are measured, from spectra, and a careful catalog writes the measured ground configuration rather than the rule. When Element Deck expands a noble-gas core, it is only unpacking an abbreviation. Helium\'s core is 1s2, neon\'s is 1s2 2s2 2p6, and so on. The electrons do not change.',
      ),
      GuideSection(
        'Why there is no unit',
        'A configuration is a list, not a magnitude. There is nothing for App Config to convert. The superscripts are counts of electrons. They are dimensionless. People sometimes attach an energy to a configuration, and the orbital diagram in the Details tab does estimate a binding energy for teaching. That estimate is not this row. This row is only the list.\n\n'
            'Term symbols such as ³P₀ are a finer description of the same electrons, including how their angular momenta couple. The Properties tab does not print term symbols on this row. A spectral Transition row may use a related language, because a line is a jump between two levels, not a printing of the ground configuration.',
      ),
      GuideSection(
        'How to read the row',
        'Read the superscripts and add them up. The sum should equal the atomic number. If the Shorthand row is also present, it is the same configuration with the inner noble-gas core written in brackets. Hydrogen and helium often have no shorthand, because there is no inner core to abbreviate. The diagram on the Details tab is drawn from this same string.\n\n'
            'A configuration is the isolated atom in its lowest state. A carbon atom in a molecule is hybridized and bonded. Its configuration is still the reference the bonding is built from. It is not a picture of the molecule.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.shorthand,
    title: 'Shorthand',
    group: 'Electrons',
    lede: 'Shorthand is the same ground-state configuration with the inner noble-gas core replaced by that gas\'s symbol in brackets. [Ne] 3s1 is sodium. The brackets stand for 1s2 2s2 2p6, and then the valence electrons are written out.',
    sections: [
      GuideSection(
        'What the brackets replace',
        'The core is the configuration of the previous noble gas: helium, neon, argon, krypton, xenon, or radon. Everything past the brackets is the part that changes across the period and does the ordinary chemistry. Sodium, magnesium, and chlorine all share [Ne]. They differ in the 3s and 3p electrons that follow.\n\n'
            'The bracket is an abbreviation, not a claim that those inner electrons are chemically untouchable in every circumstance. Core electrons can be removed by X-rays, and in the heaviest elements the usual cores are a poorer guide because relativistic effects rearrange the levels. For the chemistry this app teaches, the brackets are the standard way to keep the valence shell visible.',
      ),
      GuideSection(
        'Where the habit came from',
        'Once shells were understood, writing every electron of uranium on a line was faithful and unreadable. The noble gases close each period, so each of them is a natural checkpoint. The bracket notation grew up in textbooks and tables in the decades after Bohr and Pauli, as a way to write "start from this closed shell." Spectroscopists already thought in cores and valence electrons. The shorthand is that habit made compact.\n\n'
            'Element Deck expands the same cores when it draws the full Configuration row: He, Ne, Ar, Kr, Xe, and Rn are known cores. A shorthand is shown only when it differs from the expanded line. The first period has nothing to abbreviate, so hydrogen and helium usually have no Shorthand row at all.',
      ),
      GuideSection(
        'Why there is no unit',
        'Like the full configuration, the shorthand is a list. The brackets do not carry a unit. The superscripts are electron counts. App Config has a preference for shorthand versus full configuration in other parts of the interface. This Data row, when it is present, is specifically the abbreviated form, so there is nothing further to switch.',
      ),
      GuideSection(
        'How to read the row',
        'Read the bracket as a completed period, then read the rest as the valence configuration. [Ar] 4s2 3d6 is iron: argon\'s 18 electrons, then the period-4 valence electrons, totaling 26. If a configuration looks one electron short of the rule you memorized, check the exceptions before "correcting" the catalog. Chromium and copper are the textbook ones. The row is the stored ground configuration, abbreviated.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.shells,
    title: 'Shells',
    group: 'Electrons',
    lede: 'Shells collapse the configuration into a count of electrons in each principal shell. The row labels those shells K, L, M, N, and so on. It is the beginner\'s view of the same electrons the configuration writes in full.',
    sections: [
      GuideSection(
        'What K, L, and M mean',
        'K is n = 1, L is n = 2, M is n = 3, and the alphabet continues with the principal quantum number. Carbon as "K 2 · L 4" means two electrons in the first shell and four in the second, six altogether. The capacities of the shells are 2, 8, 18, 32, from 2n². A shell does not have to be full. The row reports the ground-state atom, which may stop in the middle of a shell.\n\n'
            'A shell count hides the subshells. L 4 on carbon does not say "2s2 2p2," though that is what it is. The configuration row is there when you need the split. The shell row is there when the question is only "how many electrons sit at each distance scale?"',
      ),
      GuideSection(
        'Where the letters came from',
        'Charles Glover Barkla, studying X-rays around 1909 to 1911, found that each element emitted series of characteristic lines. He named the series K and L, deliberately starting in the middle of the alphabet in case earlier, softer series turned up. M and N followed. Henry Moseley used the K series in 1913 to count nuclear charge. When Bohr\'s shells were matched to those series, the X-ray letters became the names of the shells. K is the innermost because those X-rays are the ones that involve the electrons closest to the nucleus.\n\n'
            'The capacities took longer. Bohr\'s original rings were not the modern shells. Pauli\'s exclusion principle, plus the orbital quantum numbers, produces 2, 8, 18, 32. Those numbers are why the periods of the table have the lengths they do. The shell row is that history reduced to a few integers.',
      ),
      GuideSection(
        'Why there is no unit',
        'Each figure is a count of electrons. The letters are names, not units. There is no conversion in App Config. Do not read "L 4" as a radius or an energy. The orbital diagram estimates energies for teaching. This row does not.\n\n'
            'The separators are just separators. "K 2 · L 4" is two facts, not a subtraction.',
      ),
      GuideSection(
        'How to read the row',
        'Add the integers. They should total the atomic number. Compare them with the configuration if both are on the card. A difference would mean the pack\'s shell list and its configuration string have drifted apart, which is a data error, not a chemical effect. Ions are not shown. A sodium ion would be K 2 · L 8, while the neutral atom is K 2 · L 8 · M 1. The row is the neutral atom.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.oxidationStates,
    title: 'Oxidation states',
    group: 'Electrons',
    lede: 'Oxidation states are the bookkeeping charges assigned to an element across its compounds. The row lists the states this catalog records, written with a sign. They describe compounds, not the bare nucleus.',
    sections: [
      GuideSection(
        'What an oxidation state is',
        'Take every bond in a compound and assign both electrons in the bond to the more electronegative partner. Then count. The resulting integer is the oxidation state. In water, oxygen is −2 and each hydrogen is +1. In sodium chloride, sodium is +1 and chlorine is −1. In the chlorine molecule, Cl₂, the two atoms are equal, so each chlorine is 0. The zero state of the pure element is real and is usually left off a list of "the oxidation states," which means the states in compounds.\n\n'
            'The number is a formalism. It is not always the charge of an ion in the crystal. Permanganate contains manganese in the +7 state, and it does not contain a free Mn⁷⁺ ion sitting in a cage of oxide ions. The +7 says how the electrons were assigned. It still predicts the chemistry: permanganate is an oxidizing agent, hungry to come down to a lower state. Several states on one row mean the element has a range. Nitrogen\'s list is long because nitrogen really does run from −3 in ammonia to +5 in nitrate.',
      ),
      GuideSection(
        'How the idea was identified',
        'Antoine Lavoisier defined oxidation as combination with oxygen. The word is his. The generalization, that chlorine or any electron-hungry partner could play oxygen\'s role, took the nineteenth century. Valence, the combining power, was sharpened by Edward Frankland and August Kekulé. Oxidation number as a signed integer that adds up across a compound became standard teaching in the twentieth century, alongside the Stock nomenclature that says iron(III) instead of ferric.\n\n'
            'IUPAC keeps a formal definition so that ambiguous molecules can still be assigned a state. The definition is a set of rules, not a spectrometer reading. Two chemists can disagree about a cluster compound and both be applying rules. For the common compounds on a first course, the rules agree, and the list on this row is that common set.',
      ),
      GuideSection(
        'Why the sign is not a unit',
        'An oxidation state is dimensionless. The plus and minus are signs of the integer, not electrical units. +2 means the bookkeeping charge is plus two. It does not mean two volts, two coulombs, or two electrons sitting in a beaker. App Config does not convert the list.\n\n'
            'The app prints a true minus sign and a leading plus, so +4, +2, and −4 stay distinct. Order in the list is the catalog\'s order. The first entry is repeated alone on Primary oxidation. Zero is printed as 0 when the catalog includes it.',
      ),
      GuideSection(
        'How to read the row',
        '"Not reported" means this pack has no list, not that the element forms no compounds. A single value means the teaching set is that one state, which is common for the alkali metals. A longer list is an invitation to ask which state a particular compound uses, not a claim that all of them are equally common. The primary state is called out on the next row.\n\n'
            'Oxidation state is not the electron count. Neutral iron has 26 electrons and a common oxidation state of +2 or +3 in its salts. Those sentences do not conflict. They count different things.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.primaryOxidation,
    title: 'Primary oxidation',
    group: 'Electrons',
    lede: 'Primary oxidation is the characteristic state this catalog puts first: the one a course is most likely to mean when it speaks of the element without naming a compound. It is a teaching choice, not a constant of nature.',
    sections: [
      GuideSection(
        'What "primary" means here',
        'Many elements have several oxidation states. Chlorine\'s chemistry includes −1, +1, +3, +5, and +7. A single featured number is still useful. For chlorine the featured state in a first course is often −1, the chloride ion, and the higher states are the oxoacids. For iron, +2 and +3 both matter, and a catalog has to pick a place to start. Element Deck takes the first state in its stored list and calls that the primary.\n\n'
            'The choice follows chemical habit, not a formula. Nitrogen is stored starting at −3. Carbon is stored starting at +4. Neither number is "the" oxidation state in the way that Z is the atomic number. Ask of a particular substance, and the answer may be another entry in the Oxidation states list.',
      ),
      GuideSection(
        'Why a single state gets featured',
        'Nineteenth-century valence often looked like one number per element: oxygen 2, hydrogen 1, carbon 4. That was enough for a huge range of organic and inorganic formulas, and it failed as soon as people met peroxides, carbon monoxide, or the transition metals. The failure is useful. It is why the full list exists. The primary state keeps the older, still-valuable habit of remembering one typical combining power, without pretending the list has length one.\n\n'
            'Alfred Stock\'s Roman-numeral names, copper(II) and copper(I), were invented because a single ancient name could not carry two states. "Primary" is in that spirit. It tells you which state the catalog would put in the Roman numeral if it had to show only one.',
      ),
      GuideSection(
        'Why there is no unit',
        'The value is a dimensionless integer with a sign, same as every other oxidation state. There is no uncertainty printed, because the state is an assigned integer, not a measured continuous quantity. App Config does not convert it.\n\n'
            '"Not reported" means the pack stored no oxidation list for this element. That is common for noble gases in a teaching set, and it is the right display when the catalog refuses to invent a state.',
      ),
      GuideSection(
        'How to read the row',
        'Read it as "start here," then read the full list if you are about to talk about a real compound. A primary state of +1 for the alkali metals will not surprise you. A primary state of +4 for carbon does not forbid carbon monoxide, where the state is +2, and it does not forbid methane, where it is −4. Those other states are on the list when the catalog has them.\n\n'
            'The number is not the charge of the nucleus, and it is not the number of valence electrons, though for the main-group elements those quantities are related. Valence electrons are a count in the neutral atom. Oxidation state is a charge assigned inside a compound.',
      ),
    ],
  ),
];
