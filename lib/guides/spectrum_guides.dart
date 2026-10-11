import 'property_guide.dart';

const spectrumGuides = <PropertyGuide>[
  PropertyGuide(
    id: GuideId.wavelength,
    title: 'Wavelength',
    group: 'Spectrum',
    lede: 'Wavelength is the distance between one crest of the light wave and the next. On a spectral line it is the label spectroscopists have used since the nineteenth century, because a grating or a prism spreads light out by wavelength.',
    sections: [
      GuideSection(
        'What the number identifies',
        'A line at 656.28 nm is the red Balmer line of hydrogen, the jump from n = 3 to n = 2. A line at 589 nm is the famous sodium D doublet, unresolved in a coarse spectroscope into one yellow streak. The wavelength identifies the transition once you know the element. It is not a color name, though the eye will call 656 nm red and 410 nm violet. Color is a coarse bin. Wavelength is the measurement.\n\n'
            'The same transition can be written as an energy or a frequency. The three rows on the line are one fact in three unit systems, tied together by the speed of light and the Planck constant. If you change one, the others must follow. Element Deck stores them together so the card does not ask you to finish the arithmetic.',
      ),
      GuideSection(
        'How wavelengths became the identity of a line',
        'Joseph von Fraunhofer, in 1814, labeled the dark lines in the solar spectrum with letters. The D line is his letter. He did not know which element made it. Gustav Kirchhoff and Robert Bunsen, around 1859, showed that each element has its own bright lines in a flame and that those lines match dark lines in the Sun. Spectroscopy became a way to identify elements, including ones that were new. Helium was named from a solar line, in 1868, decades before it was sealed in a flask on Earth.\n\n'
            'Anders Jonas Ångström published a map of the solar spectrum in 1868 with wavelengths in units of 10⁻¹⁰ metre. That unit later took his name. Diffraction gratings, interferometers, and then lasers made the measurements sharper. A modern line list quotes a wavelength to fractions of a picometre and says whether the number is for air or for vacuum. Those two differ, because air has a refractive index slightly above 1. In the visible, an air wavelength is a little shorter than the vacuum wavelength of the same line. The row prints the catalog\'s number. It does not repeat the air-or-vacuum flag.',
      ),
      GuideSection(
        'Where the unit comes from',
        'The row uses the nanometre. One nanometre is 10⁻⁹ metre, a billionth of a metre, which is 10 ångströms. Visible light runs from about 380 nm to about 750 nm. The app does not convert wavelength in App Config. Length conversion there is for radii, in picometres and ångströms, not for this row. If you want ångströms, multiply the nanometre value by 10.\n\n'
            'The metre itself, since 1983, is the distance light travels in vacuum in 1/299792458 of a second. The speed of light is an exact defined constant. A vacuum wavelength and a frequency are therefore exactly reciprocal, once you decide which one was measured and which one was computed. An air wavelength needs the refractive index before that reciprocity is exact.',
      ),
      GuideSection(
        'How to read the row',
        'Shorter wavelength means higher energy. Violet is a bigger jump than red. A line far into the ultraviolet or the infrared is still a line of the element. The eye is a narrow window, not a definition of the spectrum. The Spectra room draws the visible window and lets the dataset say which lines fall inside it.\n\n'
            'The figure is from the bundled line list, not from the camera and not from a grating in the phone. "No spectral lines are stored" means the pack has a gap. It does not mean the element has no spectrum. Every element has one.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.photonEnergy,
    title: 'Energy',
    group: 'Spectrum',
    lede: 'The Energy row on a spectral line is the photon energy of that line: the energy one quantum of that light carries. It is the difference between the two atomic levels the electron jumps between.',
    sections: [
      GuideSection(
        'What the quantum is',
        'A spectral line is not a little bit of every energy up to some limit. It is one energy, many times. Planck\'s constant relates that energy to the frequency: E = h f. Equivalently, E = h c / λ for a vacuum wavelength. The electron in the atom loses that much energy, or gains it, in one jump. The photon carries it away, or brings it in. Emission and absorption of the same transition are the same energy. The card\'s spectrum field says whether the pack is quoting the line as seen in emission, in absorption, or in both.\n\n'
            'The energy is a difference. It is not the binding energy of the electron, which would be the ionization energy if the jump went all the way to freedom. The red hydrogen line at about 1.89 eV is much smaller than hydrogen\'s ionization energy of 13.6 eV, because both levels of the Balmer jump are bound. The electron has not left the atom. It has moved from one bound state to another.',
      ),
      GuideSection(
        'How energy got attached to a line',
        'Fraunhofer\'s lines were positions. Max Planck, in 1900, introduced energy quanta to explain the color of hot objects. Albert Einstein, in 1905, argued that light itself arrives in quanta, and he used that to explain the photoelectric effect: a brighter light ejects more electrons, and a higher frequency ejects faster ones. A threshold frequency is a threshold energy. Bohr\'s 1913 hydrogen atom then set the energies of the levels so that the differences matched the known lines. The line became a measured energy, not only a measured position on a plate.\n\n'
            'Photoelectron spectroscopy and laser spectroscopy are the modern forms of the same idea. The teaching value on this row is the compiled photon energy in electronvolts. It should be consistent with the wavelength. Where the pack derived one from the other, the two rows are not independent experiments. They are one experiment and a conversion.',
      ),
      GuideSection(
        'Where the unit comes from',
        'The stored unit is the electronvolt, the energy an electron gains across one volt. Since the 2019 SI revision the elementary charge is exact, and one electronvolt is exactly 1.602176634 × 10⁻¹⁹ joule. The unit is a natural one for atoms, because the level spacings of valence electrons are a few electronvolts. X-ray lines of inner shells are thousands of electronvolts. Nuclear gamma rays are hundreds of thousands and up. The Spectrum card is the atomic, electronic range.\n\n'
            'App Config can show kilojoules per mole instead. That multiplies the per-photon energy by Avogadro\'s number and changes the prefix. One electronvolt per photon is 96.485 kJ/mol. The conversion does not turn a line into a heat of reaction. A molar energy is just the photon energy counted once per atom for a mole of atoms. The wavelength row stays in nanometres either way.',
      ),
      GuideSection(
        'How to read the row',
        'Larger energy is a bluer, shorter-wavelength line. Compare energies within one element to see which jump is the bigger step. Do not compare a photon energy with the first ionization energy and expect them to match. They match only for a jump that ends at the ionization limit. Most lines are smaller.\n\n'
            'The number is a property of the line, not of the whole element. An element has as many photon energies as it has transitions. The card lists the lines the pack stored. A blank card means the pack stored none, not that the photons do not exist.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.frequency,
    title: 'Frequency',
    group: 'Spectrum',
    lede: 'Frequency is how many wave crests pass a point in one second. For a spectral line it is the oscillation rate of the light, and it is directly proportional to the photon energy. The row prints it in hertz, scaled into terahertz or gigahertz when that is easier to read.',
    sections: [
      GuideSection(
        'How frequency sits between color and energy',
        'Divide the speed of light by the vacuum wavelength and you have the frequency. Multiply the frequency by Planck\'s constant and you have the energy. Frequency is the middle of that bridge, and it is the quantity a quantum theory most naturally uses, because the phase of a wave advances as frequency times time. Visible light oscillates a few hundred trillion times a second. That is a large number and a perfectly ordinary one for light.\n\n'
            'The Spectra room can play a tone "of" a selected line. The tone is not the optical frequency. A speaker cannot move at 10¹⁴ hertz, and an ear could not hear it. The app divides the frequency by 10¹² and plays the result, so 512 THz becomes 512 Hz, an audible note. The button is labeled as sonified. The Frequency row is the real optical frequency, before that division. Muting the phone does not change the row.',
      ),
      GuideSection(
        'How the unit was named',
        'A cycle per second needed a short name once radio existed. The SI adopted the hertz in 1960, named for Heinrich Hertz, who in the 1880s generated and detected electromagnetic waves and showed that they reflected, refracted, and traveled at the speed of light. One hertz is one per second. It is a derived SI unit, 1/s. Terahertz is 10¹² hertz, gigahertz is 10⁹.\n\n'
            'Light was not the first use. Radio engineers already quoted kilohertz and megahertz. Extending the same unit up through the terahertz range, and on to the petahertz of the ultraviolet, is a way of saying that radio and light are one phenomenon. James Clerk Maxwell\'s equations had said so in the 1860s. Hertz demonstrated the radio end. Spectroscopy had been measuring the light end, in wavelengths, since Fraunhofer.',
      ),
      GuideSection(
        'How the displayed number is built',
        'Because the metre and the second are defined so that the vacuum speed of light is exactly 299792458 m/s, a vacuum frequency and a vacuum wavelength are exact reciprocals. If a source measured the wavelength in air, the frequency computed from c / λ is slightly off until the refractive index is put back in. Many teaching line lists convert and move on. Treat the frequency and the wavelength as a pair from the catalog. Do not be surprised if a hand calculation with a rounded nanometre value misses the last digits of a frequency that was stored from a fuller wavelength.\n\n'
            'The row formats a huge hertz value as terahertz or gigahertz so it can be read. That is a prefix, not a different physical quantity. App Config\'s energy switch does not rewrite frequency. There is no "frequency in kJ/mol." Energy has its own row for that conversion.',
      ),
      GuideSection(
        'How to read the row',
        'Higher frequency is higher energy and shorter wavelength. The three rows rise and fall together. Use frequency when you are about to think about the sonified tone, about a radio analogy, or about E = h f. Use wavelength when you are comparing with a printed atlas of lines, because atlases are still organized in nanometres and ångströms.\n\n'
            'A frequency computed from a wavelength is not a second, independent measurement. The catalog may have derived it. The precision of the printed prefix form is for reading, not a claim about the last significant figure of the source list.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.transition,
    title: 'Transition',
    group: 'Spectrum',
    lede: 'The Transition row is the assignment of the line: which two levels the electron jumped between. The wavelength says where the line sits. The transition says why that wavelength is the one it is.',
    sections: [
      GuideSection(
        'How to read an assignment',
        'Hydrogen\'s red line is written n = 3 → n = 2. The arrow points from the upper level to the lower one in emission. The electron loses the energy that the photon carries. In absorption the atom climbs the same gap in the other direction, and the wavelength is the same. A thicker notation names the term, the angular momentum, and the spin coupling. A label such as 3s[3/2]° → 3p[1/2] is that richer form, common for neon and the other noble gases, where a single n is not enough to identify the level.\n\n'
            'The notation is a name for a pair of quantum states. It is not a chemical reaction, even though it uses an arrow. No nucleus changes. The element on the card is the element after the jump. Selection rules decide which pairs are allowed. A jump that changes the angular momentum by the wrong amount is forbidden, meaning slow, and it may be absent from an ordinary discharge. The lines the pack lists are the ones it has assignments for, not every conceivable pair of levels.',
      ),
      GuideSection(
        'Where the labels came from',
        'Balmer\'s 1885 formula fitted the visible hydrogen lines with a simple difference of squares, without knowing what the squares meant. Bohr, in 1913, derived that formula from his orbits and made n a quantum number. The arrow notation is the level diagram that followed: two horizontal lines, a vertical jump, the gap equal to the photon energy.\n\n'
            'Heavier atoms needed term symbols. Russell–Saunders coupling, the scheme behind ²P and ³D labels, couples the electron spins together and the orbital angular momenta together, then couples those totals. It works well for light atoms. Noble-gas spectra are often written in a different scheme, associated with Paschen\'s early numbering and with later Racah and jK coupling, because one excited electron sits outside a core that has its own angular momentum. The row prints whichever dialect the dataset used. Element Deck does not translate a Paschen label into a term symbol.',
      ),
      GuideSection(
        'Why there is no unit',
        'An assignment is a name. The energy of the jump is the Energy row, in electronvolts or in kJ/mol. The wavelength is the Wavelength row. Putting a unit on the transition would be like putting a unit on the name of a street. App Config does not reformat the string.\n\n'
            'Some lines in a raw list are unassigned: the wavelength is measured and the levels are not yet agreed. This catalog leaves the Transition row off when it has no string. Absence of the row means the assignment was not stored. It does not mean the line is counterfeit.',
      ),
      GuideSection(
        'How to read the row',
        'Read the upper level and the lower level, and check that the energy of the line is the difference you would expect if you happen to know both. For hydrogen, the Balmer formula lets you check. For neon, trust the compiled assignment rather than reverse-engineering it from the color. The Spectra room shows the same string when a line is selected, next to the wavelength, as the identification of the mark on the strip.\n\n'
            'The transition is a property of the line, not a property of the element as a bulk substance. Two lines of one element have two assignments. The ground configuration on the Electrons card is the lowest arrangement of all the electrons. A transition is a promotion of one of them, briefly.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.discharge,
    title: 'Discharge',
    group: 'Spectrum',
    lede: 'Discharge is the glow of the element as a thin gas carrying an electric current. The color is the blend of many emission lines, seen at once by the eye. It is teaching copy, not a claim that the phone is a discharge tube.',
    sections: [
      GuideSection(
        'What you are seeing',
        'A discharge tube is a glass vessel of gas at low pressure with two electrodes. A high voltage accelerates electrons, the electrons strike atoms, and the atoms re-emit the energy as their characteristic lines. Neon\'s lines in the red and orange dominate, so the tube looks orange-red. Sodium looks yellow. Mercury looks cold blue-white, much of it from the ultraviolet made visible by a phosphor in a real lamp. The color is a sum. A single line, selected on the Spectra strip, is one ingredient of that sum.\n\n'
            'The family color of the tile is a different choice. Neon\'s tile is the noble-gas violet used for the whole family. Neon\'s discharge is orange-red. Element Deck keeps those apart on purpose. The glow text and, when the pack has one, a voltage such as "1.2 kV glow" are descriptions of the tube, not of the tile.',
      ),
      GuideSection(
        'How discharge light was tamed',
        'Heinrich Geissler, a glassblower at Bonn, built the thin, low-pressure tubes in the late 1850s that let Julius Plücker and others study the glow. William Crookes pushed the pressure lower and isolated cathode rays, the work J. J. Thomson turned into the electron. The same family of tubes, at a milder vacuum, became the advertising neon lamp in the twentieth century, and the gas-discharge lamp of street lighting. Each gas has a color because each gas has a spectrum.\n\n'
            'The voltage on a card, when it is present, is a flavor of the operating conditions, not a fundamental constant. A neon sign runs at a high striking voltage and a lower running voltage. Changing the pressure or the tube width changes the numbers. The sentence in the pack is a teaching picture of that kind of tube. It is not a specification for building one, and it is not a measurement made by the app.',
      ),
      GuideSection(
        'What is not a unit here',
        'The prose has no single unit. A voltage quoted inside the sentence is in kilovolts, the ordinary unit for the potential across a long tube: a thousand volts. The color words are not wavelengths. If you need the wavelength, use the line list above the discharge note. App Config does not recolor the sentence when you switch energy units.\n\n'
            'A kilovolt is not the photon energy. A 1 kV electron can excite many lines, or ionize the atom outright. The photons that come out still have the energies on the line list, a few electronvolts each, not 1000 eV. The tube voltage is the accelerator. The line energy is the atom.',
      ),
      GuideSection(
        'How to read the note',
        'Read it as a caption on a familiar object: the sign, the lamp, the demonstration tube. Then read the lines to see which wavelengths are doing the coloring. If the section is missing, the pack has no discharge copy for this element. Many elements are not put in commercial tubes. Their spectra are still real, and they are measured in arcs, sparks, and plasmas rather than in a glowing shop sign.\n\n'
            'The note is not a safety instruction. A real discharge tube is a high-voltage device, and several of the gases are hazardous for reasons that have nothing to do with the color. Element Deck describes the light.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.astrophysics,
    title: 'Astrophysics',
    group: 'Spectrum',
    lede: 'The Astrophysics note is a sourced teaching sentence about where this element\'s spectrum, or this element\'s nuclei, shows up beyond the laboratory. It is not a match percentage against a star, and it is not a measurement the device has made of the sky.',
    sections: [
      GuideSection(
        'What the sentence is for',
        'Spectra are how a laboratory element is recognized at a distance. The same wavelengths that a discharge tube emits are absorbed or emitted by a stellar atmosphere, a nebula, or a planet\'s air. Kirchhoff and Bunsen\'s identification of solar lines is the start of that habit. A note such as a Balmer-series fingerprint, or a line of sight through a particular nebula, is a pointer from the card toward that use of the spectrum.\n\n'
            'Some notes are about nuclei rather than lines. Stellar nucleosynthesis builds helium, carbon, and the heavier elements in specific burning stages. A sentence about helium burning, or about a supernova, is that story, kept short enough to sit under the lines. It is a caption. The full argument is a textbook of astrophysics, not a row.',
      ),
      GuideSection(
        'How the sky became a spectrometer',
        'Fraunhofer\'s dark lines, Kirchhoff\'s law that a cool gas absorbs the lines it would emit when hot, and the laboratory spectra of Bunsen\'s flames made the Sun a chemical laboratory in 1859. Helium\'s D₃ line, seen by Pierre Janssen and Norman Lockyer during the 1868 eclipse, did not match a known element. Lockyer named it and waited. William Ramsay found the gas on Earth in 1895. The element was admitted on spectroscopic evidence before it was ever weighed.\n\n'
            'The origin of the elements themselves was set out in the 1950s, especially by Margaret and Geoffrey Burbidge, William Fowler, and Fred Hoyle, and in parallel by Alastair Cameron. Hydrogen burning, helium burning, and the slow and rapid neutron-capture processes account for the pattern of abundances. A teaching note on this card may allude to one of those stages. It does not compute an abundance, and Element Deck does not print a percentage match between a stellar spectrum and the line list.',
      ),
      GuideSection(
        'Why there is no unit and no score',
        'The note is prose. It has no unit for App Config to convert. A wavelength mentioned inside it is in the same nanometres as the Wavelength row. A temperature mentioned inside it would be in kelvin. The pack\'s actual sentences are short qualitative remarks, and they should stay qualitative.\n\n'
            'Match percentages are deliberately not part of the product. A percentage would pretend that a phone had fitted an observed stellar spectrum. It has not. The line list is a compiled laboratory list. The note is a sentence about the wider use of that kind of list. If the section is absent, no sentence was written. The element is still in the universe.',
      ),
      GuideSection(
        'How to read the note',
        'Read it after the lines, as the reason a stranger might care about those wavelengths. Then go back to the wavelength and the transition if you want the laboratory fact the sentence depends on. The dataset pin on the identity card covers the compilation the sentence belongs to. Quoting the sentence in a lab report is fair only with that context: it is teaching copy from the pack, not a new observation.\n\n'
            'Nuclear astrophysics and optical spectroscopy meet on this card and are not the same row. A decay mode is about a nucleus transforming. A transition is about an electron jumping. An astrophysics note may mention either, because stars do both. The label tells you the sentence is the astronomical remark, not a third kind of number.',
      ),
    ],
  ),
];
