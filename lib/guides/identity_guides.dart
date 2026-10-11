import 'property_guide.dart';

const identityGuides = <PropertyGuide>[
  PropertyGuide(
    id: GuideId.atomicNumber,
    title: 'Atomic number',
    group: 'Identity',
    lede: 'The atomic number is the identity of an element. It counts the protons in the nucleus. In a neutral atom it also counts the electrons. Every other row on this card is a description of that one integer.',
    sections: [
      GuideSection(
        'What it counts',
        'Chemists write the proton count as Z. One proton is hydrogen, two is helium, twenty-two is titanium. Change Z and you have a different element. Change only the neutron count and you have another isotope of the same element. The Data tab prints Z as the atomic number, then prints the same integer again as Protons and, for the neutral atom, as Electrons.\n\n'
            'Z is an exact integer. There is no uncertainty and no "about 6" for carbon. A claim that a new element has been made is a claim that a nucleus with that proton count was detected, however briefly the nucleus lived. Superheavy elements are identified the same way as hydrogen.',
      ),
      GuideSection(
        'How the order was established',
        'Nineteenth-century tables sorted elements by atomic weight and by chemical family. That order is almost the proton order, and it was good enough for Dmitri Mendeleev to leave gaps and predict missing elements. It fails in a few famous places. Argon is heavier than potassium, cobalt is heavier than nickel, and tellurium is heavier than iodine, yet the chemistry puts the lighter element second. Mendeleev trusted the chemistry and broke the weight order. He could not say why the weights misbehaved.\n\n'
            'In 1913 Henry Moseley measured the characteristic X-rays of a sequence of elements. The square root of the frequency stepped evenly from one element to the next, and the step matched a nuclear charge rather than a weight. He numbered the elements by that charge, located the gaps that were still empty, and showed that the weight inversions were real. After Moseley, proton number replaced atomic weight as the definition of an element. The International Union of Pure and Applied Chemistry still defines an element by its number of protons.',
      ),
      GuideSection(
        'Why there is no unit',
        'A count does not take a unit. Z is dimensionless. The row will not show "6 u" or "6 e". The proton\'s charge, one elementary charge, and the proton\'s mass, a little over 1 u, are different quantities. They are not the atomic number.\n\n'
            'Older books sometimes call Z "the place in the table." That was a fair description before anyone knew what the place meant. The place is now a consequence of the proton count. The proton count is not a consequence of the place.',
      ),
      GuideSection(
        'How to read the row',
        'This integer is the element\'s identity in Element Deck. Bookmarks, the catalog, and links such as element 22 all use it. App Config cannot convert it, and switching between a standard atomic weight and a representative isotope does not change it. If two labels seem to disagree about which element you are holding, the atomic number decides.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.symbol,
    title: 'Symbol',
    group: 'Identity',
    lede: 'The symbol is a short, unique alias for the atomic number. H means Z = 1. Ti means Z = 22. The letters are a label agreed by chemists, not a measurement.',
    sections: [
      GuideSection(
        'What the letters are',
        'A modern symbol is one or two letters, sometimes three for a systematic temporary name. The first letter is uppercase and any following letter is lowercase. That case is part of the symbol. Co is cobalt. CO is a molecule of carbon monoxide, not an element. Cl is chlorine. CL is not a symbol.\n\n'
            'The symbol names the element, the same way Z does. It does not name one isotope. Writing ¹H, or 1H as this app does on an isotope row, adds a mass number in front of the symbol. The bare symbol H still means the element.',
      ),
      GuideSection(
        'How the system was invented',
        'Before letters, chemists drew. John Dalton\'s 1808 system used circles and internal marks, one pictogram per element. The pictures did not scale. Jöns Jacob Berzelius proposed, in 1813 and 1814, that each element take an initial from its Latin or modern name, with a second letter when initials collided. Fe comes from ferrum, Au from aurum, Na from natrium, K from kalium, W from wolfram, Hg from hydrargyrum. The scheme is the one still in use.\n\n'
            'New elements wait for a name. Until IUPAC approves one, a systematic temporary symbol is built from the digits of Z: ununennium would have been Uue for element 119. Temporary symbols are labels of convenience. They are retired when the name is fixed. The approved symbol is then unique across the table.',
      ),
      GuideSection(
        'Why there is no unit',
        'A symbol is a name written small. It has no dimension, no uncertainty, and no conversion in App Config. Two-letter symbols are not abbreviations you are free to extend. Chemists do not write "Ti." with a period, and they do not invent a third letter for style.\n\n'
            'Fonts matter more than they should. A symbol is set so that the lowercase cannot be mistaken for a capital. Element Deck uses the same lettering on the tile, the header, and this row.',
      ),
      GuideSection(
        'How to read the row',
        'The row repeats the symbol already shown large in the header. It is here so the identity card is complete if you are reading the table of values on its own. Searching the periodic table by symbol prefers an exact match: Na finds sodium, and it should not silently become neon.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.name,
    title: 'Name',
    group: 'Identity',
    lede: 'The name is the ordinary-language label of the element. Element Deck shows the English IUPAC name. The atomic number is still the identity. Renaming, or respelling, does not create a new element.',
    sections: [
      GuideSection(
        'What is being named',
        'Some names are older than chemistry. Gold, iron, tin, sulfur, and carbon were words for substances long before anyone had a proton count. Some names describe a property: hydrogen is the water-former, oxygen the acid-former, in Lavoisier\'s Greek. Some name a mineral (beryllium, from beryl), a place (strontium, from Strontian; ytterbium and its siblings from Ytterby), a person (curium, mendelevium), or a myth (thorium, promethium).\n\n'
            'The English word on this row is a label. Other languages keep their own words. Sodium is natrium in several of them, which is why the symbol is Na. Sulfur and sulphur, aluminum and aluminium, are spelling variants of one element, not two entries. Cesium and caesium likewise.',
      ),
      GuideSection(
        'Who decides',
        'For elements known in antiquity or found in the nineteenth century, the surviving name is the one usage settled. Disputes were common. Columbium and niobium were the same element. Glucinium lost to beryllium. In the twentieth century, discovery claims started to overlap, and the name became a negotiation.\n\n'
            'IUPAC now approves the official English name after priority of discovery is settled. The discoverers propose. A name should refer to a scientist, a place, a property, a mineral, or a mythological concept, and the symbol has to stay unique. Element 118 is oganesson. Until that approval, a systematic numerical name is the placeholder. The Data tab shows the approved English name once the catalog has it.',
      ),
      GuideSection(
        'Why there is no unit',
        'A name is not a quantity. It does not convert with temperature, energy, or length. It can be translated, and the translation is still the same Z. Element Deck keeps the catalog in English so that a symbol, a search, and this row stay aligned.\n\n'
            'The name is also not the category. "Hydrogen" does not mean "gas" or "nonmetal." Those are other rows. The name only picks out the element.',
      ),
      GuideSection(
        'How to read the row',
        'Read it with the atomic number and the symbol. All three should agree. The header already shows the name in large type. This row is the same string, placed where a table of identity values can be scanned without looking up.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.protons,
    title: 'Protons',
    group: 'Identity',
    lede: 'Protons are the positively charged particles in the nucleus. Their count is the atomic number. The row repeats Z so the particle, and not only the index, is named.',
    sections: [
      GuideSection(
        'What a proton is',
        'A proton carries one elementary charge, positive, and a mass a little above 1 u. It is not elementary in the modern sense: it is a bound state of quarks, held by the strong interaction. For chemistry that structure is usually invisible. What chemistry needs is the charge and the count. The charge sets the pull on the electrons. The count sets which element the atom is.\n\n'
            'In a neutral atom the proton count and the electron count match. They stop matching as soon as the atom becomes an ion. Take one electron from sodium and the ion is still sodium, because the nucleus still has eleven protons. The Protons row does not change for an ion. The Electrons row, on this card, describes the neutral atom the rest of the dossier is about.',
      ),
      GuideSection(
        'How it was identified',
        'Ernest Rutherford\'s scattering experiments, interpreted in 1911, put a small, massive, positive nucleus at the center of the atom. Most of the mass sat there. Most of the volume was electrons. In 1919 Rutherford found that nitrogen, struck by alpha particles, emitted hydrogen nuclei. He argued that the hydrogen nucleus was a piece of other nuclei, not a special case of hydrogen alone.\n\n'
            'He named that particle the proton in 1920, from the Greek for "first," with a nod to William Prout. Prout had suggested in 1815 that every atom was a clump of hydrogen. Prout was wrong about atomic weights, which are not whole numbers, and right in spirit about a common building block. The neutron, found by James Chadwick in 1932, explained the rest of the nuclear mass. Protons and neutrons together are the nucleons. Only the protons determine the element.',
      ),
      GuideSection(
        'Why the row has no unit',
        'The row is a count of particles, the same integer as the atomic number, so it is dimensionless. The proton mass is not printed here. The proton charge is not printed here. Both would need units, and both are the same for every element. Only the count changes as you move through the table.\n\n'
            'If a textbook writes Z with a plus, as in Z+, it is talking about the nuclear charge in units of the elementary charge. Element Deck leaves the charge off this row and prints the bare count.',
      ),
      GuideSection(
        'How to read the row',
        'It should match Atomic number exactly, for every element, including the ones that only exist for milliseconds. A mismatch would be a broken record, not a chemical fact. Neutrons are different: they are listed per isotope, because they are not fixed by Z. Mass number minus protons is the neutron count.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.electrons,
    title: 'Electrons',
    group: 'Identity',
    lede: 'Electrons are the light, negatively charged particles that occupy the shells and make the chemistry. On this card the count is for the neutral atom, so it equals the proton count.',
    sections: [
      GuideSection(
        'What the row is counting',
        'A neutral atom has as many electrons as protons. Sodium has eleven of each. Remove one electron and you have the sodium ion, Na+, which still has eleven protons and now ten electrons. The Electrons row does not follow you into that ion. It reports the neutral atom, which is also the atom whose configuration, shell counts, and orbital diagram are drawn in the dossier.\n\n'
            'The electron is the carrier of charge in chemistry. Bonds, spectra, ionization energies, and oxidation states are all stories about what those electrons do. The nucleus barely notices ordinary chemical energies. The electron mass is about 1/1836 of the proton mass, which is why almost all of the atomic mass sits in the nucleus even though the electrons take up the space.',
      ),
      GuideSection(
        'How the particle was identified',
        'In 1874 George Johnstone Stoney estimated a fundamental grain of electric charge from electrolysis, and in 1891 he named that grain the electron. The particle itself was isolated in the laboratory by J. J. Thomson in 1897. Cathode rays in a discharge tube bent in electric and magnetic fields as if they were a stream of negatively charged matter, much lighter than a hydrogen ion. Thomson called them corpuscles. Stoney\'s name won.\n\n'
            'The size of the charge was measured by Robert Millikan\'s oil-drop experiment, reported from 1909 onward: tiny drops of oil picked up one, two, or a few grains of charge, and the grain was always the same size. The nuclear atom then placed those electrons outside a positive nucleus. Niels Bohr\'s 1913 model gave the hydrogen electron fixed orbits and explained the Balmer lines. The orbits did not survive quantum mechanics, but the electron count of the neutral atom did: it is Z.',
      ),
      GuideSection(
        'Why there is no unit',
        'This row is a count. It is dimensionless, like the proton count. The elementary charge, written e, is the unit of the electron\'s charge, and since the 2019 revision of the SI that charge is an exact defined constant. The Data tab does not print the charge. It prints how many electrons the neutral atom has.\n\n'
            'Do not read the row as a mass. Electron mass in u is a tiny number, the same for every element, and it is not stored here. Do not read it as an oxidation state. Oxidation state is a bookkeeping device for compounds. The electron count is a fact about the neutral atom.',
      ),
      GuideSection(
        'How to read the row',
        'Match it against Atomic number and Protons. For every element in the catalog the three integers agree, because the dossier describes neutral atoms. The interesting structure is not the total. It is how those electrons are arranged, which is the Configuration row and the shell list beside the diagram. A beginner\'s shell count and an advanced configuration are two ways of writing this same total.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.atomicWeight,
    title: 'Atomic weight',
    group: 'Identity',
    lede: 'Atomic weight is the mass of an atom of the element expressed on a scale where one atom of carbon-12 weighs exactly 12. For most elements the figure on this row is a terrestrial average over the natural isotopes, not the mass of a single nuclide.',
    sections: [
      GuideSection(
        'What the number means',
        'Pick up a sample of ordinary carbon and you are holding a mixture, mostly carbon-12 with a little carbon-13. The atomic weight is the average mass of the atoms in that kind of sample, weighted by how common each isotope is. It is not required to be a whole number. Chlorine\'s familiar 35.45 is the average of chlorine-35 and chlorine-37, not the mass of a nucleus that contains 35.45 nucleons. Nuclei do not come in fractions.\n\n'
            'The phrase "atomic weight" is historical. The quantity is a mass. Weight, strictly, is a force. Chemists kept the old name, and so does this row. "Relative atomic mass" is the same idea stated as a pure ratio. Element Deck prints it with the unit u, the unified atomic mass unit, also called the dalton.',
      ),
      GuideSection(
        'How the scale was built',
        'John Dalton, around 1803, started assigning relative weights by assuming simple formulas for compounds. The numbers were rough, and a wrong formula threw the weight off by a factor of two, which happened often. Jöns Jacob Berzelius spent decades measuring combining proportions more carefully. William Prout noticed that many weights were nearly whole multiples of hydrogen and guessed that hydrogen was the only building block. The near misses bothered chemistry for a century.\n\n'
            'Isotopes explained the misses. Francis Aston\'s mass spectrograph, around 1919, showed that a "single" element was often several nuclear species, each of nearly whole-number mass, mixed in a fixed proportion. The chemical atomic weight was the mixture. A second confusion remained: physicists set the pure nuclide oxygen-16 equal to 16, while chemists set the natural oxygen mixture equal to 16. The two scales disagreed in the fourth digit. In 1960 and 1961 the two unions agreed to retire both and define the scale by carbon-12 exactly equal to 12. That is the scale this row uses.',
      ),
      GuideSection(
        'Where the unit comes from',
        'One u is one twelfth of the mass of a single carbon-12 atom. In kilograms that is about 1.660539 × 10⁻²⁷ kg. The dalton is another name for the same unit. It is accepted for use with the SI. It is not defined by fixing a number of kilograms. The kilogram is defined from the Planck constant, and the mass of carbon-12 in kilograms is something laboratories still measure. So u is exact by definition relative to carbon-12, and experimental relative to the kilogram.\n\n'
            'App Config does not convert this row. Atomic weights stay in u. A standard atomic weight can also be an interval when natural samples genuinely vary: hydrogen\'s conventional value is 1.008, while the span of ordinary terrestrial hydrogen is a small range around it. Element Deck shows one figure. The Weight basis row tells you whether that figure is a standard atomic weight or the mass of one chosen isotope.',
      ),
      GuideSection(
        'How to read the row',
        'Read it next to Weight basis. "Standard atomic weight" means a conventional terrestrial value, an average, not a promise that every rock on Earth has that exact composition. "Representative isotope" means the number is the mass of a particular nuclide standing in for the element, which is what the catalog does from neptunium onward. Either way, the header mass and this row are the same figure.\n\n'
            'Do not confuse it with the Mass row inside an isotope card. That row, when the pack has a real nuclide, is one isotope. Atomic weight is the element-level number. They agree only for a pure single-isotope element, and even then binding energy keeps the nuclide mass from being a perfect integer.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.weightBasis,
    title: 'Weight basis',
    group: 'Identity',
    lede: 'Weight basis says what kind of number the atomic weight is. A standard atomic weight averages the isotopes found on Earth. A representative isotope is one chosen nuclide, used when there is no natural mixture to average.',
    sections: [
      GuideSection(
        'The two kinds',
        'Most elements up through uranium occur on Earth as a characteristic mix of isotopes. The Commission on Isotopic Abundances and Atomic Weights publishes a standard atomic weight for those elements. Some of those standards are single conventional numbers. Some are intervals, because the mix in nature varies more than the measurement uncertainty. Element Deck collapses that published story to one number and marks the basis Standard atomic weight.\n\n'
            'Elements with no stable terrestrial composition do not get a standard atomic weight. Technetium, promethium, and everything from polonium\'s heavier neighbors through the superheavy elements are quoted as a particular nuclide: the longest lived, or another one the tables agree to cite. That mass is a representative isotope. It is not an average. There is nothing in a rock to average.',
      ),
      GuideSection(
        'How the distinction arose',
        'Once Aston had shown that chemical atomic weights were mixtures, metrology had to say which mixture. The commission\'s standard atomic weights are conventional values for normal laboratory materials, not for a star, a reactor target, or a separated isotope. Materials with a deliberately altered mix, including anything sold as "enriched," fall outside the standard. The interval form, used for hydrogen, lithium, boron, carbon, and a handful of others, was the commission\'s way of refusing a false precision when nature itself wanders.\n\n'
            'Representative isotopes are older than the name. Nineteenth-century tables still printed a weight for radium or uranium because a long-lived nuclide dominates. The modern tables are stricter. If every atom is radioactive and the isotopic mix depends on history, they refuse to call the number standard, and they name the nuclide instead.',
      ),
      GuideSection(
        'Why there is no unit',
        'The row is a classification, not a second mass. The unit sits on the Atomic weight row, in u. Weight basis only tells you how to interpret that mass. Converting temperature or energy in App Config does not change the words here.\n\n'
            'The words you will see are the catalog\'s. "Standard atomic weight" and "Representative isotope" are the two values Element Deck stores. Anything else would be printed as the raw key, which would mean the pack used a basis the app does not yet describe.',
      ),
      GuideSection(
        'How to read the row',
        'In this catalog, Representative isotope is used from neptunium, Z = 93, onward. Earlier elements are marked Standard atomic weight, including technetium and promethium. Published chemical tables are stricter than that for those two: they have no standard atomic weight either, because neither has a stable isotope. When you see Standard atomic weight, treat the mass as a terrestrial conventional value. When you see Representative isotope, treat the mass as one nuclide\'s stand-in, and look at the isotope card before you imagine a bottle of the natural element.\n\n'
            'The header under the element name repeats the basis in a short form, "standard" or "representative-isotope," next to the same mass.',
      ),
    ],
  ),
];
