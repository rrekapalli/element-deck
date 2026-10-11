import 'property_guide.dart';

const nuclearGuides = <PropertyGuide>[
  PropertyGuide(
    id: GuideId.massNumber,
    title: 'Mass number',
    group: 'Isotopes',
    lede: 'The mass number, written A, is the count of protons plus neutrons in one nucleus. It is a whole number. It is not the mass in u, and it is not the atomic weight of the element.',
    sections: [
      GuideSection(
        'What A counts',
        'A nucleus of carbon with 6 protons and 6 neutrons has mass number 12. Add a neutron and you have carbon-13, mass number 13, still element 6. The usual symbol puts A at the upper left and Z at the lower left. This app writes the isotope as 12C or 1H on the card heading, mass number then symbol. The Mass number row repeats A on its own so the count is explicit.\n\n'
            'A is an integer because protons and neutrons are counted, not weighed. The actual mass of the nucleus is a little less than the sum of the free protons and neutrons, because binding energy has a mass equivalent. That deficit is why the Mass row is not exactly equal to A. The mass number ignores the deficit on purpose. It is an identity label for the nuclide, the way Z is an identity label for the element.',
      ),
      GuideSection(
        'How mass numbers were recognized',
        'Nineteenth-century atomic weights were close to integers and annoyingly not on them. William Prout\'s 1815 hypothesis, that every atom was a stack of hydrogen, was attractive and false as stated. Frederick Soddy, in 1913, named isotopes: atoms of the same element, the same place in the table, with different nuclear mass. The word was suggested to him by the physician Margaret Todd, from the Greek for "same place."\n\n'
            'Francis Aston\'s mass spectrograph, from 1919, separated the isotopes of many elements and showed that each one sat on a nearly whole-number mass. The chemical atomic weight was the blend. Aston called the pattern the whole-number rule. Mass number is that rule turned into a definition. Once the neutron was known, in 1932, the integer acquired a particle count: A = Z + N. Before that it was a label on a mass line. After that it was a census of nucleons.',
      ),
      GuideSection(
        'Why there is no unit',
        'A count has no unit. Do not write "12 u" on this row. The u belongs to the Mass row. Do not write "12 g." A gram of carbon-12 is an enormous number of atoms, fixed by the mole. The mass number of each of those atoms is still 12.\n\n'
            'App Config does not convert A. Isotope cards use it as the heading and as this row. Radioactive and stable nuclides are labeled the same way. Stability is a different row.',
      ),
      GuideSection(
        'How to read the row',
        'Subtract the atomic number from A and you have the neutron count, which is the next row. Two isotopes of one element share Z and differ in A. Two different elements can share A. Calcium-40 and argon-40 are an isobar pair. They are not the same substance, because their proton counts differ.\n\n'
            'Some cards in this pack are marked as a representative teaching isotope rather than a full natural set. The mass number on those cards is still a real integer, the one the pack chose to stand in. It is not a promise that every natural isotope has been listed. The note on the card heading says when the row is a stand-in.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.neutrons,
    title: 'Neutrons',
    group: 'Isotopes',
    lede: 'Neutrons are the uncharged particles in the nucleus. The row is their count in this isotope, N = A − Z. The element is fixed by the protons. The isotope is fixed by the neutrons.',
    sections: [
      GuideSection(
        'What the count changes',
        'Add a neutron to hydrogen and you have deuterium. The chemistry is almost the same, because the electron still sees one proton. The mass is about twice as large, and the nuclear spin changes, and a bond to deuterium is a little stronger and a little harder to break. That small difference is the isotope effect. Add one more neutron and you have tritium, which is radioactive. The Neutrons row is how those three nuclei differ. The Protons row is how they stay hydrogen.\n\n'
            'The neutron is slightly heavier than the proton. A free neutron decays, with a half-life of about ten minutes, into a proton, an electron, and an antineutrino. Inside a stable nucleus it does not. The nucleus is a lower-energy arrangement than the separated particles, and the decay that would be available to a free neutron is closed. Stability is the other row. This row only counts.',
      ),
      GuideSection(
        'How the neutron was identified',
        'By 1930, Walther Bothe and Herbert Becker had found a penetrating radiation from beryllium hit by alpha particles. Irène Curie and Frédéric Joliot showed that the radiation could knock protons out of paraffin. They thought of a very hard gamma ray. James Chadwick, in 1932, showed that the kinematics fitted a neutral particle with a mass close to the proton\'s, not a quantum of light. Rutherford had suspected such a particle for years. Chadwick found it.\n\n'
            'The neutron made the nucleus legible. Isotopes were no longer a mystery mass. They were a variable neutron count on a fixed proton count. Fission, when it was recognized at the end of that decade, is a rearrangement of these particles, and a chain reaction is possible because fission releases more neutrons than it consumes. None of that changes the arithmetic on this row. N is still A minus Z.',
      ),
      GuideSection(
        'Why there is no unit',
        'The row is a count, dimensionless, like protons and like the mass number. The neutron mass, about 1.009 u, is not printed. The neutron has no charge, so there is no charge unit to attach either. App Config does not convert a count.\n\n'
            'The count is computed from the mass number and the atomic number. Element Deck does not store a separate neutron census that could drift away from A − Z. If you ever saw a disagreement, one of the two inputs would be wrong.',
      ),
      GuideSection(
        'How to read the row',
        'For a light stable nucleus, N is close to Z. Carbon-12 has 6 and 6. Heavier stable nuclei need more neutrons than protons, because the electrical repulsion among protons has to be diluted. Lead-208 has 82 protons and 126 neutrons. The extra neutrons are not a defect. They are how that nucleus holds.\n\n'
            'A representative teaching isotope still has a well-defined N, because it has a well-defined A. The count is about that chosen nuclide, not an average over a natural mixture. Neutrons do not come in fractional averages inside one nucleus. The atomic weight is where averaging belongs.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.isotopicMass,
    title: 'Mass',
    group: 'Isotopes',
    lede: 'The Mass row on an isotope is the mass of that nuclide, in u. It is close to the mass number and almost never equal to it. The difference is the binding energy of the nucleus, written as a mass.',
    sections: [
      GuideSection(
        'Why it is not a whole number',
        'Carbon-12 is the exception that defines the scale: its mass is exactly 12 u, by the 1960–1961 agreement that retired the old oxygen scales. Every other nuclide is measured against that choice. Hydrogen-1 is about 1.0078 u, a little over its mass number, because a single proton is being compared with one twelfth of a tightly bound carbon nucleus. Iron-56 is a little under 56. The shortfall is the mass equivalent of the energy you would have to supply to pull the nucleus apart into free protons and neutrons.\n\n'
            'Einstein\'s relation, energy equals mass times the speed of light squared, is the conversion. A mass defect of 0.1 u is an energy of about 93 MeV, which is a nuclear energy, not a chemical one. Chemical bonds move electrons by a few electronvolts and do not show up in the mass at the precision of this row. The Mass row is a nuclear fact printed on a chemistry card.',
      ),
      GuideSection(
        'How nuclide masses were measured',
        'Francis Aston\'s mass spectrograph bent ion beams in electric and magnetic fields and landed each isotope at a different place on a photographic plate. The place gave the mass. Modern Penning traps hold a single ion in electric and magnetic fields and read its cyclotron frequency. The frequency ratio of two ions is a mass ratio, and it can be measured to so many figures that the limiting uncertainty is sometimes the definition of the scale rather than the instrument.\n\n'
            'The pack does not carry that many figures. A teaching mass such as 1.0078 u or 2.0141 u is enough to see the defect and to tell protium from deuterium. When a card is labeled as a representative teaching isotope, treat the mass more cautiously still. Some stand-in rows in this compilation reuse an elemental atomic weight rather than a high-resolution nuclide mass. The note on the card heading is the warning. A mass on protium, deuterium, or another fully entered isotope can be read as a nuclide mass.',
      ),
      GuideSection(
        'Where the unit comes from',
        'The unit is u, the unified atomic mass unit, also called the dalton. It is one twelfth of a carbon-12 atom, about 1.660539 × 10⁻²⁷ kg. The same unit is used for the atomic weight of the element. The difference is what is being weighed. Atomic weight averages a terrestrial mixture, or cites a representative isotope for the element as a whole. This row weighs one nuclide.\n\n'
            'App Config does not convert u. Kilograms are the SI base unit and a hopeless size for one nucleus. Grams per mole is the chemist\'s bulk translation: a mole of a nuclide of mass M u has a mass of M grams. That translation uses Avogadro\'s number. The row stays in u so the comparison with the mass number is immediate.',
      ),
      GuideSection(
        'How to read the row',
        'Put it next to the mass number. If they are close, you are looking at a plausible nuclide mass. If the card says the isotope is only a teaching stand-in, do not quote the mass as a standards-laboratory value. Put it next to the element\'s atomic weight as well. The atomic weight lies between the masses of the natural isotopes, pulled toward the common ones. Chlorine\'s 35.45 sits between 35 and 37. No single nucleus has mass number 35.45.\n\n'
            'A blank is "Not reported." Do not replace it with the mass number written as a decimal. That would hide the binding energy, which is the interesting part.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.nuclearSpin,
    title: 'Spin',
    group: 'Isotopes',
    lede: 'The Spin row is the nuclear spin of this isotope: the intrinsic angular momentum of the nucleus, in units of h-bar. It is a property of the nuclide, not of the chemical element, which is why it lives on the isotope card.',
    sections: [
      GuideSection(
        'What the number means',
        'Angular momentum in nuclei is quantized in units of ℏ, Planck\'s constant divided by 2π. The nuclear spin I is a half-integer or an integer: 0, 1/2, 1, 3/2, 2, and so on. Protons and neutrons are spin-1/2 particles. They pair. A nucleus with an even number of protons and an even number of neutrons almost always has a ground-state spin of 0, because every nucleon has a partner. Carbon-12, oxygen-16, and helium-4 are spin 0. A nucleus with an odd nucleon carries at least the spin of that leftover particle, so hydrogen-1 is 1/2 and carbon-13 is 1/2.\n\n'
            'Spin decides whether a nucleus talks to a magnetic field. Spin-0 nuclei are invisible to nuclear magnetic resonance. Hydrogen-1 and carbon-13 are the workhorses of NMR because they have spin 1/2 and give sharp spectra. Nuclei with spin greater than 1/2 also have an electric quadrupole moment in general, and their lines are broader. The row is the angular momentum. It does not print the magnetic moment, which is a second number, in nuclear magnetons.',
      ),
      GuideSection(
        'How spin was measured',
        'The first evidence was extra structure in atomic spectra. A nucleus with spin splits the electronic energy levels into hyperfine components, a finer split than the electron\'s own spin produces. Isidor Rabi and his colleagues, in the 1930s, measured nuclear magnetic moments by sending molecular beams through magnetic fields and watching resonances. Felix Bloch and Edward Purcell, in 1946, detected the same resonances in bulk matter, which is NMR. The medical and chemical machines are descendants of that detection.\n\n'
            'The value on a teaching card is the ground-state spin. Excited nuclear states have their own spins. A gamma ray between two states has to respect the change in angular momentum. The Properties tab quotes the ground state, as a string such as 1/2 or 0 or 1. A fuller spectroscopic label sometimes adds a parity, plus or minus. This row may omit the parity and print only the angular-momentum number.',
      ),
      GuideSection(
        'Where the unit comes from',
        'The unit is already absorbed into the number. A printed 1/2 means I = 1/2, in units of ℏ, not 1/2 of a joule-second written out. Planck introduced h in 1900 as the constant in blackbody radiation. The reduced constant ℏ became the natural unit of quantum angular momentum. Printing ℏ on every row would be correct and noisy. The convention in nuclear tables is to print the number and let the unit be understood.\n\n'
            'App Config does not convert spin. There is no kJ/mol equivalent that makes sense, because spin is not an energy. "Not reported" means the pack has an empty string for this nuclide. Many of the representative teaching isotopes are stored that way. An empty spin is not spin zero. Zero is printed as 0 when the pack knows it.',
      ),
      GuideSection(
        'How to read the row',
        '1/2 and 0 are the values a first course uses most. 1/2 means the nucleus is an NMR candidate in principle. 0 means it is not, and it means the ground state is typical of an even-even nucleus. Larger half-integers mean a more complicated magnet, and usually a quadrupole. Compare spins only within one element\'s isotopes if you are explaining spectra. Comparing the spin of deuterium (1) with the spin of protium (1/2) is the start of the explanation of why deuterium NMR is a different experiment.\n\n'
            'The electron also has spin 1/2. That is not this row. Electron spin is why configurations pair electrons two to an orbital. Nuclear spin is a property of the nucleus the electrons are orbiting. The two couple, weakly, and that coupling is the hyperfine structure. The row reports the nuclear side only.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.stability,
    title: 'Stability',
    group: 'Isotopes',
    lede: 'Stability says whether this nucleus is treated as stable or as radioactive, in the words the catalog stores. Stable means no decay is observed on any timescale the tables care about. The other words mark a nucleus that does decay, and say something about how it shows up in nature.',
    sections: [
      GuideSection(
        'What the words mean',
        'A stable nucleus has no energetically open decay, or has a half-life so long that none has been seen. Tin has ten stable isotopes. Technetium has none. "Stable" on this row is that classification for the nuclide, not a mood. A trace isotope is radioactive and occurs in nature only because it is still being made, by cosmic rays or as a daughter of a longer-lived parent. Tritium in the hydrogen card is the example: it is not a permanent ingredient of the oceans, and a little of it is always being produced. A radioactive label, without the softer word trace, is the catalog\'s general mark for a nucleus that decays.\n\n'
            'Observationally stable is not the same as stable for eternity. Some nuclei can in principle decay by routes so rare that the half-life exceeds the age of the universe by a ridiculous factor. Tables still call them stable. Proton decay, if it exists at all, is a separate and unsettled question about all ordinary matter. The row is the chemical-table classification, not a particle-physics forecast.',
      ),
      GuideSection(
        'How stability was established',
        'Henri Becquerel, in 1896, found that uranium salts darken a photographic plate through the wrapping. Marie and Pierre Curie isolated polonium and radium and showed that the activity was a property of the element, not of the light or the chemistry. Ernest Rutherford and Frederick Soddy, around 1902, showed that radioactivity is a transmutation, one element becoming another, and that the amount of activity falls exponentially. A nucleus is stable, in the laboratory sense, when that fall is absent.\n\n'
            'The chart of nuclides colors the stable ones as a valley. Light nuclei sit near N = Z. Heavier ones sit at a growing neutron excess. Off the valley, nuclei decay back toward it, by beta decay if the neutron-to-proton ratio is wrong, by alpha decay if the nucleus is simply too heavy. The Stability row is which side of that classification the pack assigned.',
      ),
      GuideSection(
        'Why there is no unit',
        'The row is a word. The timescale, if there is one, belongs on Half-life, with its own unit. A stable row has no half-life printed, because there is no measured decay to time. App Config does not convert a classification.\n\n'
            'Do not invent a percentage from the word. Stability is not an abundance. A stable isotope can be 0.01 percent of the element or 100 percent of it. Abundance is the next row when the pack has one.',
      ),
      GuideSection(
        'How to read the row',
        'Read the catalog\'s word, then the half-life if it is present. "Stable" with no half-life is the ordinary case for protium or carbon-12. "Trace" with a half-life, as on tritium, means a radioactive nuclide that still appears in nature in small amount. "Radioactive" on a representative teaching card means the element has no stable isotope, or this chosen nuclide does not. The note on the card heading will say if the whole card is a stand-in rather than a full inventory of nature.\n\n'
            'The word is about the nucleus in isolation. A "stable" element can still be chemically ferocious. Fluorine-19 is a stable nucleus. Fluorine gas is not a stable thing to leave in a jar of anything else.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.abundance,
    title: 'Abundance',
    group: 'Isotopes',
    lede: 'Abundance on an isotope card is the fraction of the element\'s atoms that are this isotope, in a stated reservoir. The pack stores a fraction. The row shows a percent. Unless a note says otherwise, the reservoir meant by a real entry is ordinary terrestrial material.',
    sections: [
      GuideSection(
        'What the percent is a percent of',
        'Chlorine-35 is about three quarters of the chlorine atoms in seawater, rocks, and laboratory reagents. Chlorine-37 is the rest. Those two percents, weighted by the two masses, produce the atomic weight 35.45. The abundance row is one of those percents, for one isotope. It is an atom percent, which for isotopes is the same as a mole percent. It is not a percent by weight, and it is not a fraction of the Earth\'s crust. Crustal abundance of the element is a different table and is not this row.\n\n'
            'The reservoir matters. Terrestrial hydrogen is about 99.98 percent protium. Solar-wind hydrogen and the hydrogen in a deuterium-enriched reagent are different mixtures. Standard atomic weights refer to normal terrestrial materials. An abundance on a carefully entered isotope card should be read in that spirit. Cosmic abundances, the mix in the solar system as a whole, are another list, used in astrophysics, and they are not what a chemistry atomic weight is built from.',
      ),
      GuideSection(
        'How abundances were measured',
        'Once Aston could separate isotope beams, the darkness of the lines was a first abundance. Later mass spectrometers counted ions. The modern values used for atomic weights come from calibrated isotopic measurements of reference materials, compiled by the Commission on Isotopic Abundances and Atomic Weights. A few elements vary in nature by enough to matter: boron, lithium, and carbon among them. The commission then publishes an interval for the atomic weight instead of pretending every sample is identical.\n\n'
            'Radiogenic isotopes shift the mix in old rocks. Lead from different ores does not have one abundance pattern, because some of it is the daughter of uranium and thorium. A single percent on a teaching card cannot carry that geology. It is a conventional figure, or it is absent.',
      ),
      GuideSection(
        'Where the percent sign comes from',
        'Percent means per hundred. It is a dimensionless ratio, a fraction multiplied by 100. The pack stores the fraction: 0.99985 for protium, not 99.985. The row multiplies by 100 and picks a few decimals so that a common isotope and a rare one are both readable. There is no SI unit to convert, and App Config does not rewrite the percent.\n\n'
            'Parts per thousand and parts per million are the same idea with a different factor. Isotope geochemistry loves per-mil deviations from a standard. This row is not a delta value. It is the abundance itself. A blank, shown as "Not reported," means the fraction was not stored. It does not mean the abundance is zero. An isotope of zero abundance would not be on the card.',
      ),
      GuideSection(
        'How to read the row',
        'A real set of isotopes for one element should have abundances that add to about 100 percent. Hydrogen in the preview catalog is that kind of set: protium, deuterium, and a trace of tritium. Many other elements in the pack carry a single representative teaching isotope instead of a full natural inventory. If that stand-in is marked stable, the stored abundance may be a placeholder of 100 percent. Read the note on the card heading before you quote it. A placeholder means "we did not store a measured mix," not "nature makes only this isotope."\n\n'
            'Trace radioactive isotopes often have no meaningful permanent percent. Tritium\'s abundance depends on production and decay. The row may still show a small number, or it may say the abundance is not reported. Either display is a reminder that a half-life, not a fixed fraction, is the better description.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.halfLife,
    title: 'Half-life',
    group: 'Isotopes',
    lede: 'The half-life is the time it takes for half of the nuclei in a sample to decay. It is a property of the nuclide. It is not a countdown running inside one nucleus, and it is not printed for a nuclide the catalog calls stable.',
    sections: [
      GuideSection(
        'What the time describes',
        'Start with a large number of identical nuclei. After one half-life, half of them have decayed, on average. After another, half of what remained are gone, so a quarter of the original sample is left. The curve is exponential. It never hits zero in the formula. In a finite sample it eventually hits one nucleus, and then zero, with the last nucleus no more likely to decay "because it is late" than it was at the start.\n\n'
            'That last point is the one people misremember. A nucleus does not age. The probability of decay in the next second is constant, which is why the half-life is the same whether the sample is a minute old or a million years old. The mean life, the average time a nucleus waits, is the half-life divided by the natural logarithm of 2, about 1.443 half-lives. Tables quote the half-life because halving is easier to picture than the mean.',
      ),
      GuideSection(
        'How it was identified',
        'Ernest Rutherford and Frederick Soddy recognized the exponential law around 1902, while sorting the radioactive chains of thorium and uranium into parent and daughter. A pure substance fell off with a characteristic time, and that time did not depend on temperature, pressure, or chemistry. That independence was the clue that the clock was in the nucleus, not in the molecule. Heating radium does not make it decay faster. Oxidizing it does not either.\n\n'
            'The range of half-lives is absurd. Hydrogen-5 lives a fraction of a yoctosecond. Tellurium-128 has a measured half-life around 10²⁴ years, far longer than the age of the universe, and is still called radioactive because the decay, a very rare double beta decay, has been seen in the statistics of a large sample. The row can only print the catalog\'s string. It does not try to draw that whole range on one axis.',
      ),
      GuideSection(
        'Where the unit comes from',
        'The unit is part of the text: seconds, minutes, hours, days, or years, written as the pack wrote them, for example 12.32 y for tritium. There is no single stored SI number that App Config reformats. A year in nuclear data is a conventional length, close to 365.25 days, and for a half-life of 12 years the distinction between year-definitions does not move the teaching value. For geological half-lives the unit is still years, and the number of them is the point.\n\n'
            'Do not convert a half-life into a rate in your head without the logarithm. The decay constant is ln(2) divided by the half-life. Activity, in becquerels, is that constant times the number of atoms. One becquerel is one decay per second, the SI unit, named for Henri Becquerel. The older curie is 3.7 × 10¹⁰ becquerels, roughly the activity of a gram of radium-226. Neither unit is printed on this row. The row is a time.',
      ),
      GuideSection(
        'How to read the row',
        'The row appears when the pack has a half-life string. A stable isotope omits it. Read a short half-life as "this nuclide is gone before any chemistry on a visible sample," which is the situation of most superheavy isotopes. Read a long half-life, uranium-238 at 4.5 billion years, as "a rock can still hold this." The Stability word and the half-life should agree: a stable label with a short half-life would be a broken record.\n\n'
            'A half-life is not a biological half-life. The body clears tritium as water on a timescale of days, while the nuclei wait a dozen years to decay. Medical and environmental writing uses both clocks. This row is only the nuclear one.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.decay,
    title: 'Decay',
    group: 'Isotopes',
    lede: 'The Decay row names the mode by which this nucleus transforms: the particle it emits or the capture it undergoes. It is printed only when the catalog has a mode for that isotope. Stable nuclides omit it.',
    sections: [
      GuideSection(
        'The modes you will meet',
        'Alpha decay emits a helium-4 nucleus, two protons and two neutrons. The parent loses 4 in mass number and 2 in atomic number. It is the typical decay of the heavy, proton-rich-enough nuclei, uranium and the elements beyond it. Beta-minus decay turns a neutron into a proton and emits an electron and an antineutrino. The mass number stays put. Z rises by one. Tritium becomes helium-3 this way, which is why the hydrogen card marks tritium with a beta-minus sign.\n\n'
            'Beta-plus decay turns a proton into a neutron and emits a positron and a neutrino. Electron capture does the proton-to-neutron conversion by taking an orbital electron instead of emitting a positron. Both lower Z by one and leave A unchanged. Gamma decay emits a photon as an excited nucleus drops to a lower state, and it changes neither Z nor A. Spontaneous fission splits a very heavy nucleus into two sizable pieces and some neutrons. A card may print one principal mode. Real nuclides sometimes have branches, a few percent of a second path. A single label is the teaching mode, not necessarily the whole branching ratio.',
      ),
      GuideSection(
        'How the modes were separated',
        'Rutherford named alpha, beta, and gamma by how far they penetrated and how a magnetic field bent them. Alpha was stopped by paper and bent as a positive heavy particle. Beta penetrated farther and bent as a light negative particle. Gamma was unbent and the most penetrating. The identification of alpha particles as helium nuclei, of beta particles as electrons, and of gamma rays as electromagnetic radiation took the following decade. The neutrino was Wolfgang Pauli\'s 1930 proposal to save energy conservation in beta decay, where the electron comes out with a spread of energies rather than one sharp value. Enrico Fermi\'s theory of 1934 made the decay a new interaction. Clyde Cowan and Frederick Reines detected the neutrino in 1956.\n\n'
            'The mode is a nuclear rearrangement. Chemistry cannot choose it. The daughter element is fixed by the mode and the parent Z. Alpha decay of uranium-238 leads to thorium-234. No reagent changes the destination. The daughter may then decay on its own, which is why the natural chains are sequences rather than single steps.',
      ),
      GuideSection(
        'How the row is written',
        'The pack stores a short symbol: a Greek letter, sometimes with a sign, such as β−. There is no SI unit, because a mode is a kind of event, not a magnitude. The rate of those events is the half-life, and the energy released is the Q value, which is not on the card. App Config does not rewrite the symbol.\n\n'
            'A mode without a half-life would be unfinished, and a half-life without a mode is unfinished in the other direction. When both rows are present they should be read together. When decay is absent, look at Stability. Stable nuclei have nothing to write here.',
      ),
      GuideSection(
        'How to read the row',
        'Translate the symbol into a change of Z and A before you try to name the daughter. Alpha: A down by 4, Z down by 2. Beta minus: A unchanged, Z up by 1. Beta plus or electron capture: A unchanged, Z down by 1. Gamma and the other electromagnetic transitions: no change of nuclide, only of energy. Fission: two new mass numbers, not one daughter.\n\n'
            'The symbol is the catalog\'s teaching label. It is not a spectrum. The electrons and photons from decays have energies, and those energies are nuclear, in the keV to MeV range, far above the electronvolt lines on the Spectrum card. Do not mix a decay energy with a spectral line of the neutral atom. They are different excitations of different parts of the atom.',
      ),
    ],
  ),
];
