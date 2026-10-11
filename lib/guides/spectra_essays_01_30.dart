import 'spectra_detail.dart';

final spectraEssays01 = <ElementSpectrumEssay>[
  spectrumEssay(
    1,
    'Hydrogen is the spectrum the quantum theory was built to explain. One electron, a ladder of levels labeled by a single number n, and a handful of series that a formula from 1885 already fitted before anyone knew what the formula meant.',
    [
      spec(
        'The series',
        '''The visible lines are the Balmer series. Every one of them lands on n = 2. The red member is the jump from n = 3, then a blue-green from n = 4, a blue from n = 5, and a violet from n = 6. The lines crowd toward a limit in the near ultraviolet, near 365 nm, which is the energy needed to free an electron that starts on n = 2. Shorter than that limit, the Lyman series lands on n = 1 and lives in the ultraviolet. Lyman-alpha, the jump from n = 2 to n = 1, is the workhorse line of ultraviolet astronomy. Longer than the red, the Paschen series lands on n = 3 and lives in the infrared. One atom, three windows, one ladder.

The strip draws the Balmer lines this pack stored. A research list is longer. Fine structure splits each Balmer line by a fraction of an angstrom, and the Lamb shift, a still smaller discrepancy between two levels that the Dirac theory had called equal, became a founding measurement of quantum electrodynamics. The card does not draw that split. It draws the teaching lines a grating in a classroom can see.''',
      ),
      spec(
        'How the light is made, and how a star uses it',
        '''A thin discharge of hydrogen glows pinkish red because the red Balmer line carries much of the visible energy, mixed with the bluer members. In a star the same lines are usually dark. The photosphere shines a continuum, and cooler hydrogen above it absorbs the Balmer wavelengths. The atom does not care whether it sits in a tube or in the atmosphere of Vega. Temperature decides which lines are strong. A hot star shows strong Balmer absorption. A cool star's Balmer lines weaken, because too few electrons are waiting on n = 2. An emission nebula glows red in the n = 3 to n = 2 line because ultraviolet light from a hot star ionizes hydrogen, and the recombinations cascade down through that jump.

The wavelength shift of the red line measures velocity: a galaxy's rotation, an accretion disk, the expansion of a remnant. None of that is a match score. It is the same laboratory wavelength, moved by the Doppler effect.''',
      ),
      spec(
        'What else belongs to hydrogen, and is not on the strip',
        '''The 21-centimetre line is a spin flip of the electron in the ground state, a radio transition, not an optical one. It maps neutral hydrogen across the Milky Way and it will never appear on a visible-window strip. Deuterium and tritium have the same electronic ladder with a tiny isotope shift, because a heavier nucleus changes the reduced mass and therefore the Rydberg constant by a little. The isotopes on the Spectra tab are a nuclear story. The lines are an electronic story. They meet in that small shift.

Hydrogen and deuterium lamps are laboratory tools for a different reason. A deuterium lamp is used as an ultraviolet continuum for spectrophotometers, a smooth source against which some other sample's absorption is measured. That continuum is not the line spectrum of the atom.''',
      ),
    ],
  ),
  spectrumEssay(
    2,
    'Helium was an element in the sky before it was an element in a bottle. A yellow line in the Sun\'s outer atmosphere, seen during the eclipse of 1868, matched nothing Bunsen and Kirchhoff had catalogued, and the gas was named for the Sun.',
    [
      spec(
        'A two-electron spectrum',
        '''Helium's neutral spectrum is not a copy of hydrogen with a different Rydberg constant. Two electrons interact, and the lines split into two families that hardly talk to each other: singlets, in which the electron spins are paired, and triplets, in which the spins are parallel. A jump from one family to the other is strongly discouraged. The famous yellow line near 588 nm, the one Lockyer could not force onto sodium, is a triplet line. Red, blue, and green members sit nearby, which is why a helium discharge looks pale and peach rather than a single color.

The pack stores a teaching handful of He I lines, quoted as emission. He II, singly ionized helium, is a hydrogen-like spectrum of its own, with a Rydberg constant four times larger because the nuclear charge is 2. Its lines masquerade near hydrogen's and have to be told apart in hot stars. The card's lines are the neutral atom.''',
      ),
      spec(
        'From the eclipse to the flask',
        '''Pierre Janssen and Norman Lockyer saw the yellow line in the chromosphere in 1868. For a generation helium was a streak and a name. In 1895 William Ramsay collected the gas driven out of the uranium mineral cleveite, sparked it, and found Lockyer's line. The identification was spectroscopic in both directions: first the Sun against the laboratory, then the rock against the Sun.

In a modern tube the same lines are a convenience. Helium-neon lasers use a helium discharge to pump neon, and the familiar red laser line is a neon line, not a helium line. Helium's own visible lines remain the calibration marks of discharge lamps and the signature of helium in stellar atmospheres, where the lines appear only when the star is hot enough to excite so tightly bound an atom.''',
      ),
      spec(
        'What the color is not',
        '''The noble-gas violet of a table tile is a family color. It is not the color of a helium tube. The tube is a blend of the stored lines, weighted by how strongly each one is excited at the pressure and current of that tube. Change the pressure and the blend shifts. The wavelengths do not.

Helium's nucleus has a spectrum too, in a different sense: alpha particles and nuclear energy levels. Those are millions of electronvolts, not the few electronvolts of these optical lines. A glow on a radioactive source is not this spectrum.''',
      ),
    ],
  ),
  spectrumEssay(
    3,
    'Lithium\'s visible spectrum is almost a single red line. The atom is hydrogen\'s first alkali cousin: one electron outside a closed shell, a strong resonance doublet that the eye reads as crimson.',
    [
      spec(
        'The red resonance line',
        '''The line near 671 nm is the jump of the valence electron between the ground 2s level and the first excited 2p level. Spin-orbit coupling splits the p level, so a fine instrument shows a doublet, unresolved in a flame. The pack stores that red line and a weaker orange line. Together they are why a lithium salt in a Bunsen flame is carmine, and why the color is used as a firework red when strontium is not the chosen salt.

The doublet is the D line of lithium, the same kind of jump as sodium's yellow pair, shifted because the electron is more tightly held in a smaller atom. The resonance wavelength marches to longer and longer values as you go down the alkali group: lithium red, sodium yellow, potassium deep red and violet, rubidium and caesium out toward the infrared with violet companions. The group trend is a spectrum trend.''',
      ),
      spec(
        'Where the line is used',
        '''Flame photometry reads lithium in serum and in brines by this red line. The measurement is old, specific, and still used, because few other elements put a strong line exactly there. In the laboratory the same transition is a favorite of laser cooling. Lithium's light mass and its accessible resonance line made it one of the atoms in which degenerate quantum gases were built. That experiment uses the wavelength. It does not change it.

In stars, lithium is a fragile element. It burns at temperatures that leave hydrogen untouched, so the strength of the red line in a stellar atmosphere is a clue to how much mixing has carried lithium down to hot layers. The line is doing cosmological and stellar work from a wavelength a flame already shows.''',
      ),
      spec(
        'What not to confuse it with',
        '''The red of a lithium flame is atomic. The red of a ruby is chromium ions sitting in a crystal, a solid-state color, not a line of lithium and not a line of free chromium. Strontium's scarlet flame is the practical look-alike. A spectroscope separates them at once, because strontium's strong visible pattern is not this single red resonance line.

The pack's line list is the free atom. Lithium metal, lithium-ion batteries, and lithium salts in solution have colors and spectra of a different kind, belonging to bands and to ions in fields. Those are real. They are not the marks on the strip.''',
      ),
    ],
  ),
  spectrumEssay(
    4,
    'Beryllium keeps its strongest lines in the ultraviolet. There is no classroom flame color to memorize, and that absence is part of the spectroscopy: the resonance jump is too large for the visible window.',
    [
      spec(
        'An ultraviolet fingerprint',
        '''The Be I resonance line near 235 nm is the one analytical chemistry actually uses. A second line near 457 nm falls in the blue, and the pack stores both. The blue line is real and usually weaker in the sources that measure beryllium. The ultraviolet line is the persistent one, which is why beryllium is a plasma-emission and atomic-absorption element rather than a flame-test element. The eye never gets a turn.

Two electrons outside the helium core make the neutral spectrum a distant, tighter cousin of helium's singlet and triplet structure. The ion Be II is lithium-like, one electron outside a closed shell, and it has its own strong ultraviolet resonance line. Spark spectra of beryllium alloys show both stages. The roman numeral is not decoration.''',
      ),
      spec(
        'Why the measurement is careful',
        '''Beryllium is toxic as a dust and as a fume, so the spectrum is also an occupational fact. Workshops that machine beryllium copper watch the air, and the ultraviolet line is one of the ways a laboratory says whether the metal is present at a trace. The card is not a safety procedure. It is the reason such a procedure can be specific: the wavelength belongs to beryllium and not to the copper beside it.

In astrophysics the same ultraviolet lines are a light-element diagnostic, read from space because the Earth's air absorbs them. Beryllium, like lithium and boron, is scarce in stars. It is made by cosmic rays splitting heavier nuclei more than by the fusion that runs a star. A weak line can be a clue to that history.''',
      ),
      spec(
        'No flame, no sign tube',
        '''Beryllium is not bottled as a discharge color, and it is not a firework. The metal is used for windows on X-ray tubes precisely because it is transparent to soft X-rays, a different region of the electromagnetic spectrum from these optical lines. X-ray absorption edges are another spectrum of the same element, belonging to inner shells. The optical lines belong to the valence electrons. Both are beryllium. They are not the same jumps.''',
      ),
    ],
  ),
  spectrumEssay(
    5,
    'Boron\'s atomic lines hide in the ultraviolet, while the green flame students remember is a molecule. Telling those two spectra apart is the whole lesson of this element.',
    [
      spec(
        'The atomic doublet, and the green that is not it',
        '''Neutral boron has a strong pair of lines near 249.7 and 249.8 nm, unresolved in many instruments into one ultraviolet mark. The pack stores that pair. They are the lines an inductively coupled plasma uses to measure boron in steel, in glass, and in water. They do not make a flame look green.

The green flame test for boron comes from molecular bands of the oxide, often written BO2, a band spectrum with fluting in the green. A molecule has vibrations and rotations stacked on the electronic jump, so the light is a shaded band rather than a sharp atomic line. The test is honest chemistry and a different spectrum. A grating settles the argument: bands have a head and a degradation; the atomic pair is two sharp marks in the ultraviolet.''',
      ),
      spec(
        'How boron is excited on purpose',
        '''Boron carbide, borosilicate glass, and boron in nuclear moderators are solids. Their colors, if they have any, are solid-state. To see the atomic spectrum the sample has to be turned into free atoms. A plasma does that. Flame atomic absorption struggles with boron, because the oxide is hard to break and the useful line is deep in the ultraviolet, where a flame is a poor source. The practical method followed the wavelength, not the other way around.

In stars, boron is another fragile light element, read in the ultraviolet from above the atmosphere. The same 249 nm region that a plasma lab uses is the region a space spectrograph uses. The identification is the wavelength match, made once in the nineteenth-century style and still in use.''',
      ),
      spec(
        'What the card is claiming',
        '''The strip will show these lines only as marks outside the visible window, or it will say they fall outside 380 to 780 nm. That caption is right. Boron has not failed to have a visible spectrum so much as it has put its strongest atomic evidence where the eye cannot follow. The green of a boric-acid flame remains a useful observation, filed under molecules.

Boron-11 and boron-10 differ in nuclear properties that matter to reactors. Their electronic spectra are almost the same, shifted by a tiny isotope effect. Neutron capture is not a color.''',
      ),
    ],
  ),
  spectrumEssay(
    6,
    'Carbon\'s atomic lines are mostly ultraviolet, and the pretty colors of a carbon flame belong to a molecule. The atom and the soot are both carbon. Their spectra are not interchangeable.',
    [
      spec(
        'Atomic carbon, and the Swan bands',
        '''The persistent C I line near 193 nm is an ultraviolet line used in the spark and plasma analysis of steels, where carbon is the element the alloy is built around. The pack stores it, and it lies far outside the visible strip. Neutral carbon does have weaker lines at longer wavelengths, but the line a foundry instrument trusts is the ultraviolet one.

A candle, a Bunsen flame with the air hole closed, and a comet all show the Swan bands, a band spectrum of the molecule C2. They sit in the green and the blue and they are why a carbon-rich flame has structure a pocket spectroscope can see. Comets show them so faithfully that the bands were once called the comet-head spectrum. CN adds violet bands. None of these is a line of the free carbon atom. The molecule is the emitter.''',
      ),
      spec(
        'Stars, and the carbon sequence',
        '''Cool stars divide by their molecules. A carbon star is one whose atmosphere shows C2 and CN bands rather than the oxide bands of an oxygen-rich red giant. The classification is spectroscopic, and it records which element is left over after the other has been locked into carbon monoxide. Atomic carbon lines in the ultraviolet add a hotter-star diagnostic. The 193 nm line is one of the tools for carbon abundance when the star is hot enough that molecules have fallen apart.

Diamond, graphite, and soot have spectra of solids: broad absorption, infrared vibrational bands, and, for diamond, a wide transparent window. Those are carbon too. They are not the marks a discharge of carbon vapor would show.''',
      ),
      spec(
        'Reading the single stored line',
        '''One stored line is not the whole atlas. It is the line this pack chose as the teaching mark for carbon, an ultraviolet fingerprint rather than a visible color. If the strip says the stored lines are outside the visible window, it is describing that choice. Carbon has not become invisible. The eye is the wrong detector for the line the analysts use.

The isotope shift between carbon-12 and carbon-13 is small in the optical spectrum and large in nuclear magnetic resonance and in mass spectrometry. Those are other ways of telling the isotopes apart. The line near 193 nm does not, at classroom resolution, label which isotope emitted it.''',
      ),
    ],
  ),
  spectrumEssay(
    7,
    'The pink of a discharge in air is mostly nitrogen molecules, not nitrogen atoms. The atomic lines are a thinner, redder fact, easy to miss behind the bands that make the aurora and the spark look the way they do.',
    [
      spec(
        'Bands first, atoms second',
        '''A spark in air, an aurora, and the glow of a nitrogen-filled tube are dominated by band systems of N2 and of the molecular ion N2+. They are dense, they sit across the blue, violet, and red, and they are what a small spectroscope shows as fluted bands. The pack's atomic lines are N I, near 744 and 747 nm, in the deep red. They are real lines of the neutral atom. They are not the source of the familiar pink.

The distinction matters as soon as the gas is hot enough, or thin enough, for molecules to break. In a hot plasma the atomic and ionic lines take over. N II and N III appear in the spectra of hot stars and of nebulae. The roman numeral again marks the ion, not a second element.''',
      ),
      spec(
        'The aurora and the laboratory',
        '''Auroral colors are a layered spectrum: green and red forbidden lines of atomic oxygen, and blue and red bands of nitrogen. A textbook that calls the aurora "nitrogen" has kept the molecule and lost the oxygen. Both are there. The wavelengths say which is speaking.

In analytical chemistry, nitrogen in metals is measured, but the strong atomic lines lie in the vacuum ultraviolet, absorbed by air, so the instrument is purged or evacuated. The red lines the pack stores are the ones that fit an ordinary window. They are a teaching selection, not the lines a steel lab prefers when it is counting nitrogen in a sample.''',
      ),
      spec(
        'What the pink does not measure',
        '''The color of a nitrogen discharge changes with pressure, purity, and whether oxygen is mixed in. A pretty tube is a blend. It is a poor assay. Identification uses the band heads or the atomic wavelengths, compared with a chart.

Nitrogen's chemistry, from ammonia to nitrates, has no bearing on these wavelengths. The atom in a molecule has given its outer electrons to bonds, and the spectrum it shows is the molecule's. To get N I, the bond has to be broken and the atom set free.''',
      ),
    ],
  ),
  spectrumEssay(
    8,
    'Oxygen owns two different visible reputations, and they are different kinds of line. The allowed triplet in the deep red is what a spark and a plasma show. The green of the aurora is a forbidden line the pack is not drawing.',
    [
      spec(
        'The red triplet, and the green that is forbidden',
        '''The O I triplet near 777 nm, three lines within a few tenths of a nanometre, is the persistent allowed transition of neutral oxygen. The pack stores those three. They sit at the red edge of the visible window. Lightning, some plasma sources, and the analysis of oxygen in metals lean on this region or on stronger lines farther into the ultraviolet.

The famous green auroral line at 557.7 nm, and the red auroral and nebular lines near 630 and 636 nm, are forbidden lines of neutral oxygen, written [O I]. They violate the ordinary selection rules, so they are vanishingly faint in a discharge, where collisions interrupt the atom, and bright in the upper atmosphere and in nebulae, where the gas is thin. A fuller atlas includes them. This pack's stored lines are the allowed triplet. Calling the aurora "the 777 nm line" would be the wrong identification.''',
      ),
      spec(
        'Where each kind of line is read',
        '''Nebulae are classified by forbidden lines of oxygen, nitrogen, and other ions. [O III], the doubly ionized atom, gives the green pair that made nineteenth-century observers invent a new element, nebulium, before Bowen showed in 1927 that the lines were ordinary oxygen in extraordinary conditions. The element was never missing. The selection rule was.

In industry the allowed lines measure oxygen dissolved in copper and in steel, because oxygen changes the metal and the line strength tracks the amount once the sample is sparked. Medical pulse oximetry, by contrast, uses the broad absorption of hemoglobin, a molecular band of a protein, not these atomic lines. Same element, different spectrum, different question.''',
      ),
      spec(
        'Molecules of oxygen',
        '''The air's own color at sunset and the blue of the sky are scattering, not emission lines. Molecular oxygen does absorb in narrow bands in the red and the infrared, the bands named by Fraunhofer and later workers, and those bands are how satellite instruments watch the atmosphere. They are a band spectrum of O2.

Ozone's ultraviolet absorption is a third spectrum, and it is why the vacuum-ultraviolet lines of every element, oxygen included, have to be recorded from space or through an evacuated instrument. The Earth's air is an optical filter before it is a sample.''',
      ),
    ],
  ),
  spectrumEssay(
    9,
    'Fluorine is spectroscopically a hard element. Its resonance lines lie in the vacuum ultraviolet, its visible lines are weak, and this pack stores none. The essay is about that spectrum anyway.',
    [
      spec(
        'Why the card is empty of lines',
        '''The strongest transitions of neutral fluorine fall below 100 nm, where air is opaque and ordinary optics stop. Weaker lines exist in the red, and analytical work sometimes uses a line near 686 nm, but fluorine is not an element a flame announces. The pack's gap matches the teaching difficulty. It does not mean the atom has no levels.

Fluorine's electronegativity is the chemical face of the same tight binding. The valence electrons are held hard, so the jumps between their levels are large, and large jumps are short wavelengths. The spectrum is pushed out of the visible window by the same fact that makes fluorine a fierce reagent.''',
      ),
      spec(
        'How it is measured when it must be',
        '''Plasma emission can see fluorine lines if the optics are chosen for them. A more common assay is not atomic emission at all: ion-selective electrodes, ion chromatography, or molecular bands of alkaline-earth fluorides, which do sit in the visible and give a band spectrum when a fluoride is introduced into a flame with calcium or strontium. Those bands are a useful test and a molecular spectrum.

In stars, fluorine abundances are often read from hydrogen fluoride bands in the infrared, again a molecule, in cool giants. The free-atom lines are left to hot stars and to the ultraviolet. Spectroscopy followed the carrier that would actually show up.''',
      ),
      spec(
        'Colors that are not the atom',
        '''Fluorite's glow under ultraviolet light is fluorescence of a mineral, often from rare-earth impurities or from color centers, not an atomic fluorine line. The name "fluorescence" was taken from that mineral. The word outlived the explanation.

A fluorine discharge would be a dangerous object, and it is not a sign-making gas. The noble-gas tubes work because those atoms are content to be excited and to return. Fluorine is content to react. Its spectrum is a laboratory spectrum.''',
      ),
    ],
  ),
  spectrumEssay(
    10,
    'Neon is the element whose spectrum people have seen without calling it a spectrum. The orange-red of the sign is a blend of many Ne I lines, and the strongest of them sit in the red and the orange.',
    [
      spec(
        'The blend the eye calls neon',
        '''A low-pressure neon tube emits a thicket of Ne I lines from the 3s–3p family of jumps. Red and orange members dominate the sum, so the tube looks orange-red even though green lines are in the list. The pack stores a yellow-orange line near 585 nm, a red line near 640 nm, and a green line near 540 nm, with the coupling labels spectroscopists use when a single n is not enough. The 585 nm line is among the strongest. The green line is real and loses the vote when the eye adds the light up.

The tile color for the noble gases is a family violet. Neon's discharge is not that violet. Element Deck keeps the two colors apart on purpose. The glow note on the Spectra tab is about the tube. The tile is about the column of the table.''',
      ),
      spec(
        'The laser line, and the sign',
        '''The helium-neon laser line at 632.8 nm is a neon transition, one chosen line amplified in a cavity, pumped by collisions with excited helium. It may or may not be among the three lines this pack drew. It is part of neon's real spectrum, and it is a good example of a line being selected from a blend. The sign uses the blend. The laser throws the rest away.

Georges Claude's signs, from the 1910s, bent the same discharge into letters. The identification of the gas was already spectroscopic: Ramsay and Travers, in 1898, had a crimson glow from a fraction of liquid air that matched no known fill. The color was the announcement. The wavelengths were the proof.''',
      ),
      spec(
        'Neon beyond the sign',
        '''Planetary nebulae show forbidden lines of neon ions, [Ne III] among them, in the ultraviolet and the infrared. The astrophysics note on this card points at that use. Those lines are not the sign's Ne I blend. They are neon that has lost electrons, radiating slowly in a thin gas. The element is the same. The spectrum is the ion's.

Neon is also a fill gas in high-voltage indicators and a coolant in other trades. Only the discharge uses the visible lines. A neon sign that has been mixed with argon or mercury on purpose is no longer a pure neon spectrum, which is why some "neon" colors are not neon at all.''',
      ),
    ],
  ),
  spectrumEssay(
    11,
    'Sodium is the yellow the eye trusts too quickly. Almost all of that yellow is one doublet, a pair of lines near 589 nm, and the pair is both a flame test and a Fraunhofer line.',
    [
      spec(
        'The D lines',
        '''Fraunhofer's letter D marks the dark pair in the solar spectrum. Kirchhoff and Bunsen showed it was sodium. The two lines, near 589.0 and 589.6 nm, are the resonance doublet: the valence electron falling from the split 3p level to the 3s ground level. A cheap spectroscope blends them into one yellow streak. A better one splits them. The pack stores both.

Because the lines are so strong, a speck of sodium contaminates every flame. A yellow flame is not an identification until a spectroscope has checked that the light really is this doublet and not a blend that merely looks warm. The street lamp settled the question in public. Low-pressure sodium lamps radiate almost only these two lines, which is why they are efficient and why they make every surface look grey or yellow. High-pressure sodium lamps broaden the lines into a wider gold.''',
      ),
      spec(
        'Absorption as a measuring instrument',
        '''Atomic absorption was built on this kind of line. A hollow-cathode lamp of sodium emits the D lines. A flame full of sodium atoms absorbs them in proportion to how many atoms are there. The wavelength match between lamp and sample is the specificity. Sodium in serum, in soil, and in water is still read this way, or by the emission of the same lines in a flame photometer.

In the Sun the D lines are dark. In a prominence or a flare they can be bright. Same wavelengths, two directions, Kirchhoff's rule. The strength and the shape of the solar D lines also report how much sodium sits in the atmosphere and how the light is scattered. The card's astrophysics of sodium is that long habit, not a percentage match.''',
      ),
      spec(
        'Yellow that is not sodium',
        '''A yellow diamond, a yellow pigment, and the yellow of a sodium-vapor lamp are three mechanisms. The lamp is the D lines. The pigment is molecular absorption, broad and chemistry-dependent. The diamond is a solid-state defect. Only the lamp will show two sharp marks at 589 nm.

The orange of a high-pressure sodium lamp still comes from sodium, but pressure has smeared the levels, so the spectrum is no longer two hairlines. Conditions change the drawing. They do not change which element owns the levels.''',
      ),
    ],
  ),
  spectrumEssay(
    12,
    'Magnesium\'s visible fingerprint is a green triplet, three lines near 517 nm that a flame and a flare both show. Its most famous astronomical lines are a different pair, in the ultraviolet, from the ion.',
    [
      spec(
        'The green triplet and the ultraviolet doublet',
        '''The pack stores the Mg I b triplet, near 516.7, 517.3, and 518.4 nm. They are the lines of the neutral atom that sit in the visible window, and they are why magnesium in a flame has a green flash and why flares and some fireworks use it for white-green light. White, because other lines and a continuum join in when the metal burns hot. Green, because this triplet is strong.

Mg II adds the resonance doublet near 279.6 and 280.3 nm, called the h and k lines by analogy with calcium. They are not in this pack's visible selection. They dominate the ultraviolet spectra of stars and of the interstellar medium, and a space spectrograph reads magnesium abundance from them. Neutral triplet in the green, ionic doublet in the ultraviolet: both are magnesium, and the roman numeral says which.''',
      ),
      spec(
        'A solar and a laboratory element',
        '''The green triplet is a standard feature of the solar spectrum and of cool-star spectra, used for abundances and for the surface gravity of a star, because the wings of strong lines respond to pressure. In the metals lab the same region, or the ultraviolet ionic lines, measures magnesium in aluminum alloys. The identification is old. The calibration is what the modern instrument adds.

Burning magnesium ribbon is a continuum plus lines, a hot solid particle glowing white and a vapor glowing in the triplet. A photograph of the ribbon is not a spectrum. A grating pointed at the vapor is.''',
      ),
      spec(
        'Colors that belong to compounds',
        '''Chlorophyll's green is a molecular band of a magnesium-bearing molecule, and the magnesium ion in that molecule is not radiating the b triplet. The metal is essential to the molecule. The color is the molecule's. Epsom salt and magnesia are white solids with no atomic emission until they are dissociated.

The isotope magnesium-26 in meteorites is a nuclear story about aluminum-26 decay. It is read by mass spectrometry, not by a shift of the green triplet at classroom resolution.''',
      ),
    ],
  ),
  spectrumEssay(
    13,
    'Aluminium\'s persistent signature is a pair of lines at the violet edge of the visible, near 394 and 396 nm. They are the resonance doublet of the neutral atom, and they are how a spark names the metal in an alloy.',
    [
      spec(
        'The resonance pair',
        '''The two lines are the jump from the ground 3p configuration's partner levels down toward the ground state, split by spin-orbit coupling into a pair a little under 2 nm apart. The pack stores both. They sit so close to the ultraviolet that a flame looks colorless to the eye even while a spectrometer is shouting. Aluminum is not a flame-test color. It is a spark-test element.

Al II and Al III add their own ultraviolet lines once the spark is hot enough to ionize the atom. In a foundry the instrument is taught which line belongs to which stage, and which neighboring lines of iron or copper might blend with it. A single coincidence is not an identification. A pair, at the right separation, is much harder to counterfeit.''',
      ),
      spec(
        'Alloys, stars, and the interstellar gas',
        '''Spark and plasma emission measure aluminum in steels and in aluminum alloys as a control on composition, not as a discovery. The wavelengths have been known for a century. The work is the intensity.

In space the same resonance lines, and the stronger ionic line of Al III, appear in stellar atmospheres and in gas between the stars. Aluminum is an odd-Z element, less abundant than magnesium or silicon on either side of it, and the line strength is one of the ways that odd-even pattern is checked. The laboratory pair is the template.''',
      ),
      spec(
        'The metal\'s shine is not the line',
        '''Polished aluminium reflects because it is a metal with a plasma of conduction electrons, a solid-state response across the visible. That mirror color is not the 394 and 396 nm doublet. Anodized colors are dyes and interference in an oxide layer. Ruby\'s red, sometimes grown in alumina, is chromium.

The element on the card is the free atom's spectrum. The saucepan is the solid. Both are aluminium, and only one of them has these two lines.''',
      ),
    ],
  ),
  spectrumEssay(
    14,
    'Silicon\'s useful atomic lines are ultraviolet. The element is better known, spectroscopically, as a partner in molecules and in solids: SiO bands in cool stars, and the indirect absorption edge that makes a wafer a detector.',
    [
      spec(
        'The lines the pack stores',
        '''Neutral silicon's persistent lines include a strong ultraviolet mark near 288 nm and another near 252 nm, plus a weaker violet line near 391 nm. The pack stores that selection. The 288 nm line is a standard in the analysis of steels, of aluminum alloys, and of rocks. On the strip it falls outside the visible window. The violet line is the one that can appear as a mark inside the rainbow.

Si II and Si III matter in hotter sources. Early-type stars show silicon ionic lines that help classify them. The neutral lines belong to cooler vapors and to the analytical spark, where the sample is not a stellar atmosphere but a piece of metal.''',
      ),
      spec(
        'Stars and minerals',
        '''In cool stars, silicon is often read from the molecule SiO as much as from the atom, especially in variables where the oxide bands come and go with temperature. The atomic lines return when the star is warmer and the molecule breaks. A spectral type is in part a statement about which of those carriers is present.

On Earth, silicates are the crust. Their spectra in the infrared are vibrational bands of the Si–O bond, a molecular and solid-state spectrum used by geologists and by remote sensing. That absorption is how a rock is recognized from orbit. It is not the 288 nm atomic line, and it does not replace it when the question is "how much silicon is in this steel?"''',
      ),
      spec(
        'The wafer',
        '''A silicon photodiode detects light because of a band gap in the solid, near the infrared edge of the visible. Photons above that energy lift electrons into the conduction band. That is a spectrum of the crystal, continuous above a threshold, not a line list of Si I. Solar cells and camera sensors are this solid-state spectrum put to work.

The atomic lines remain the assay of the element as an ingredient. A clean room cares about both: the crystal's band gap, and the atomic lines of the impurities in it.''',
      ),
    ],
  ),
  spectrumEssay(
    15,
    'Phosphorus was discovered by a glow, and the glow is not its atomic spectrum. The waxy element\'s pale light is chemiluminescence of a slow oxidation. The atomic lines are ultraviolet, and this pack does not store them.',
    [
      spec(
        'A glow that is a reaction, not a line list',
        '''Hennig Brand's seventeenth-century residue shone in the dark. That light is a chemical reaction with air, a faint continuous and banded emission from excited molecules produced as the element oxidizes. It does not form the sharp lines of free phosphorus atoms, and it does not need a discharge. Locking the sample away from air puts the glow out. A spectral line of an atom does not behave that way.

The atomic spectrum lies mainly in the ultraviolet, with strong lines in the 178 nm region and useful analytical lines nearer 214 and 254 nm. Vacuum or purged optics are part of the measurement. The absence of stored lines on this card is a pack gap. The lines exist in the atlas.''',
      ),
      spec(
        'How phosphorus is assayed',
        '''Steels, fertilizers, and waters are analyzed for phosphorus by plasma emission at those ultraviolet lines, or by colorimetry of a molecular complex, the phosphomolybdate blue, which is a broad absorption and not an atomic line. Both methods are about the element. Only one is a spectrum of the free atom.

In stars, phosphorus lines in the ultraviolet contribute to abundance work. The element is odd-Z and relatively scarce. Biology's interest in phosphate is chemical. Bone and DNA do not emit the atomic lines.''',
      ),
      spec(
        'White, red, and the name',
        '''The allotropes look different as solids. White phosphorus is the one that glows and burns. Red phosphorus does not glow in the same way. Neither color is a flame test of the Bunsen kind, and neither is a substitute for the ultraviolet wavelengths when the element has to be identified in a mixture.

The name, from the Greek for light-bearer, records the chemiluminescence. It is a historical clue, not a wavelength.''',
      ),
    ],
  ),
  spectrumEssay(
    16,
    'Sulfur\'s atomic spectrum is an ultraviolet spectrum. The blue of a sulfur flame and the smell of a struck match are chemistry and molecular bands. This pack stores no atomic lines, and the distinction is the teaching point.',
    [
      spec(
        'Atom versus flame',
        '''Strong S I lines lie in the vacuum ultraviolet, near 180 nm and shorter, with further lines used in plasmas around 182 nm. Air absorbs them. A laboratory that measures sulfur in steel by emission uses a vacuum spectrometer or an inert purge. That is why sulfur has no classroom emission color of the sodium kind.

Burning sulfur looks blue because of molecular emission and continuum from the flame, including bands of S2 and related species, not because of a single atomic line in the blue. The eye is reporting a band spectrum plus a hot gas. A grating shows structure that does not match a one-line flame test.''',
      ),
      spec(
        'Sulfur in stars and in air',
        '''In astrophysics, sulfur is often called an alpha element, forged in massive stars and returned in supernovae. Its abundance is read from ionic lines, S II among them, in nebulae and in stars, frequently in the ultraviolet or as forbidden lines in thin gas. Those lines are the astronomical face of the element. They are not the blue flame.

On Earth, sulfur dioxide has a rich molecular spectrum that matters to the atmosphere and to pollution monitoring. Infrared and ultraviolet bands of SO2 are how instruments watch volcanic plumes. Again a molecule. The free atom appears when the molecule is torn apart in a plasma.''',
      ),
      spec(
        'Solids and allotropes',
        '''Yellow crystalline sulfur is a solid of S8 rings. Its color is the absorption edge of that molecular solid, broad and chemical. It will not show atomic emission until it is vaporized and dissociated. The red of a volcanic sunset can involve sulfate aerosols scattering light, which is neither absorption by S I nor the atomic line list.

The pack's empty line list should be read as a limit of the teaching selection. Sulfur has a spectrum. Most of it does not fit the 380 to 780 nm drawing.''',
      ),
    ],
  ),
  spectrumEssay(
    17,
    'Chlorine is another halogen whose atomic lines refuse the flame-test tradition. The greenish gas people picture is molecular chlorine. The atomic spectrum is a thicket of weaker lines, mostly outside the romantic colors, and this pack stores none.',
    [
      spec(
        'The gas and the atom',
        '''Cl2 is a yellow-green gas because the molecule absorbs in the violet and the blue, a broad molecular absorption. That color is real and it is not a set of Cl I emission lines. Atomic chlorine, once the bond is broken, has lines spread from the ultraviolet into the red, none of them a famous classroom singlet. Analytical plasmas use ultraviolet and vacuum-ultraviolet lines when chlorine in oil or in a polymer has to be measured.

The pack's silence is consistent with that awkwardness. A teaching strip of persistent visible lines would overstate how useful the visible lines are. The essay is the place for the spectrum the strip does not draw.''',
      ),
      spec(
        'Ions in nebulae',
        '''Forbidden lines of chlorine ions appear in some planetary nebulae, a minor but real ionic spectrum, used as a density or abundance check alongside the stronger oxygen and neon lines. The wavelengths are catalogued. They are not a glow a tube of chlorine would be asked to produce, and a tube of chlorine is a miserable and poisonous object besides.

In the laboratory, chloride in water is usually titrated or measured with an electrode or by ion chromatography. Those are not spectroscopy. When spectroscopy is chosen, it is often the molecular spectrum of a complex, or the atomic lines in a plasma, depending on the matrix.''',
      ),
      spec(
        'Sodium lamps and chlorine',
        '''There is no chlorine lamp in the street-lamp sense. Halogen lamps, the incandescent kind, contain a halogen so that tungsten can cycle chemically back to the filament. The light is still the continuous spectrum of hot tungsten. The halogen is a chemical partner, not the emitter. A "halogen spectrum" of that lamp would be a mistake.

Chlorine-35 and chlorine-37 are a nuclear and mass-spectrometric pair. Their electronic spectra coincide at ordinary resolution.''',
      ),
    ],
  ),
  spectrumEssay(
    18,
    'Argon is the quiet majority of the air and a brilliant red-violet discharge when it is bottled alone. Its neutral lines crowd the red and the near infrared, which is why an argon tube looks nothing like a neon tube.',
    [
      spec(
        'The red Ar I lines',
        '''The pack stores several Ar I emission lines between about 697 and 764 nm. They are part of the dense 4s–4p array, the argon analogue of neon's 3s–3p array, shifted to longer wavelength. A pure argon discharge looks pale violet or lavender in some tubes and wine-red in others, depending on the glass, the pressure, and how much the deep red is weighted. The eye is summing a list. The list is what the strip draws.

Argon ion, Ar II, is a different spectrum and a different color. Argon-ion lasers emit strong blue and green lines, the 488 and 515 nm lines among them, from the ion, not from the neutral atom. A blue "argon" laser and a red argon glow tube are both argon. The roman numeral distinguishes them.''',
      ),
      spec(
        'The plasma people use without looking at it',
        '''Inductively coupled plasma emission, the workhorse of multi-element analysis, is an argon plasma. The argon lines are the background against which every other element's lines are measured. Analysts know them in self-defense, so they do not mistake an argon line for the analyte. The same gas fills incandescent lamps to slow the filament's evaporation, and there it is not asked to glow. The continuous spectrum belongs to the hot tungsten.

Argon was identified by Lord Rayleigh and William Ramsay when atmospheric nitrogen and chemical nitrogen disagreed in density, and the residue's spectrum was new. The discovery was physical and spectroscopic together. The red lines are the descendant of that residue.''',
      ),
      spec(
        'Color, again, is not the tile',
        '''The noble-gas tile is not argon's discharge color. The discharge color is not a single wavelength. Of the stored lines, the deepest red contributes to a warmth the eye reads as violet only because weaker blue and violet lines, some of them outside this short list, join the sum. A full Ne I or Ar I atlas runs to hundreds of lines.

Forbidden lines of argon ions appear in supernova remnants and in nebulae. They are the astrophysical argon spectrum, used for abundances. They are not the lines in the sign tube.''',
      ),
    ],
  ),
  spectrumEssay(
    19,
    'Potassium\'s flame is lilac because the atom is sending light from both ends of the visible window at once: a violet pair near 405 nm and a deep-red pair near 767 and 770 nm.',
    [
      spec(
        'Two doublets, one flame',
        '''Both pairs are resonance structure of the valence electron, the same alkali pattern as sodium, split by spin-orbit coupling. The red pair is the true resonance doublet, enormously strong, sitting at the edge of the visible and into the very near infrared. The violet pair is a higher jump and weaker, but the eye is more sensitive there than in the deep red, so the flame looks pale violet rather than red. A spectroscope shows both, and the pack stores both.

Cobalt glass is the old trick for seeing the violet lines when sodium contamination has flooded the flame with yellow. The glass absorbs the D lines and lets the potassium violet through. It is a filter, a crude spectrograph made of colored glass.''',
      ),
      spec(
        'Soil, blood, and stars',
        '''Flame photometry of potassium is a clinical and an agricultural measurement. The red doublet is intense and specific. Sodium is the usual interferent, and the instrument, or the cobalt glass, exists to refuse it.

In the Sun and in cool stars the red doublet is a major feature, often strongly absorbed, and the line wings are a classical probe of the star's atmosphere. The violet pair is visible on the same spectra as a fainter echo. Potassium is an alkali, easily ionized, so in hotter stars the neutral lines fade and the ion would have to be sought instead. The neutral spectrum is a cool-gas spectrum.''',
      ),
      spec(
        'The isotope that is not a color',
        '''Potassium-40 is radioactive and is a geological clock. Its decay is nuclear. It does not move the 767 nm line by a classroom-sized amount. The lilac flame of a potassium salt is the ordinary mixture of isotopes, and the color does not say which isotope is present.

Potassium vapor lamps exist but never took the streets the way sodium did, partly because the resonance lines sit where the eye is a poor customer. The physics is the same physics. The photometry is less kind.''',
      ),
    ],
  ),
  spectrumEssay(
    20,
    'Calcium owns the H and K lines, the darkest pair in the violet of the solar spectrum, and a flame that is brick red for a different reason. The ion and the neutral atom divide the fame between them.',
    [
      spec(
        'H and K, and the red line of the neutral atom',
        '''Fraunhofer's H and K are the Ca II resonance doublet near 393.4 and 396.8 nm. They are lines of singly ionized calcium, extraordinarily strong in the Sun, in cool stars, and in the interstellar medium. The pack stores them, together with the neutral Ca I resonance line near 422.7 nm, which is deep violet, and a blue line near 445 nm.

The flame test is brick red, and it is mostly molecular bands of calcium oxide and chloride plus the neutral atomic lines, a blend the eye integrates to red. The H and K lines are not what make the flame red. They sit in the violet, and in a flame much of the calcium may be neutral or tied up in molecules. In a star, calcium is easily ionized, and H and K take over. Same element, different carrier, different color.''',
      ),
      spec(
        'What H and K are used for',
        '''The widths of H and K track luminosity in cool stars, the Wilson–Bappa effect and its descendants, because the lines form over a great range of depths. Emission in the cores of H and K traces magnetic activity, the chromosphere talking. Interstellar clouds imprint narrow H and K absorption on the spectra of background stars, and the Doppler shift of those narrow lines maps the gas.

In the laboratory the 422.7 nm neutral line is the atomic-absorption line for calcium in water, serum, and soil. A hollow-cathode lamp and a flame are enough. The ionic pair is the astronomer's line. The neutral resonance line is the analyst's. Both are on this card.''',
      ),
      spec(
        'The red flame, named carefully',
        '''Strontium is scarlet, lithium is carmine, calcium is brick. The words are a mnemonic, not a measurement. Any of the three, contaminated with sodium, turns yellow. The spectroscope, not the adjective, finishes the identification.

Calcium's role in bones and in lime is chemistry. The sulfate in plaster does not emit H and K until it is dissociated into atoms and ions. The lines are a property of the free species.''',
      ),
    ],
  ),
  spectrumEssay(
    21,
    'Scandium has a rich visible spectrum for such a scarce metal, which is exactly why it is put into some lamps. A pinch of scandium iodide fills the visible window with lines and the light looks white.',
    [
      spec(
        'A thicket that the eye adds up to white',
        '''The pack stores Sc I lines near 391, 402, and 402 nm, in the violet. They are a sample, not the census. Neutral scandium and singly ionized scandium both have many lines across the blue, the violet, and the near ultraviolet, because a single d electron outside a closed shell still produces a complicated term structure once spin and orbit are counted.

Metal-halide lamps use that richness. Scandium iodide, with sodium iodide, evaporates in the arc and the metals emit their lines. Sodium supplies the yellow. Scandium supplies a crowd of lines across the rest of the visible. The sum approximates daylight better than either spectrum alone. The lamp is a designed blend, and scandium is in it for the shape of its line list.''',
      ),
      spec(
        'A rare earth that is not a lanthanide',
        '''Scandium sits above the lanthanides and behaves a little like them in minerals, which is why it hid in Scandinavian rare-earth ores. Spectroscopically it is a transition element with a d electron, not an f electron. Its lines are numerous but not the ultra-sharp f–f lines of the later rare earths in crystals. In an arc, they look like a transition-metal forest, which is what they are.

In stars, scandium is a touchstone of nucleosynthesis oddities, an odd-Z element, and Sc II lines are measured in cool-star atmospheres for abundances. The violet lines of the neutral atom are the laboratory face of a measurement the ion often carries in the sky.''',
      ),
      spec(
        'What the stored trio is for',
        '''Three lines are enough to show that scandium is not a one-line alkali. They are not enough to simulate the metal-halide lamp. The essay's claim is the pattern: many lines, visible, useful as a fill. The strip's claim is the pack's selection.

Scandium metal itself is silvery. That color is the solid. It will not look like the lamp until the metal is a vapor in an arc.''',
      ),
    ],
  ),
  spectrumEssay(
    22,
    'Titanium\'s atomic spectrum is a forest of lines in the blue and the violet, and its stellar reputation is a molecule. TiO bands are what make an M-type star look the way it does through a spectroscope.',
    [
      spec(
        'Lines of the atom, bands of the oxide',
        '''The pack stores Ti I lines near 400 nm and a group near 498 to 501 nm. They are persistent neutral lines, the kind a spark of a titanium alloy shows, and they sit in the violet and the blue-green. Ionized titanium adds the famous Ti II forest used in stellar spectroscopy, hundreds of lines that blanket the blue.

In a cool star the molecule TiO takes over. Its band systems cut the spectrum into a ragged shape that is the definition of spectral class M. The bands strengthen as the star cools. They weaken if the star is a carbon star and the oxygen is locked in carbon monoxide instead. Titanium is present either way. The carrier changes. An atomic line list and a TiO band list are two chapters of one element.''',
      ),
      spec(
        'Alloys and pigments',
        '''Spark optical emission measures titanium in steels and in titanium alloys, using lines such as the ones stored here, chosen because they are free of blends with iron. The measurement is routine industrial spectroscopy. The wavelengths are the classical ones.

Titanium dioxide is white because it scatters broadly across the visible, a solid-state optical property of the crystal. Paint is not emitting Ti I. Anastase and rutile have absorption edges in the ultraviolet, which is why the pigment is a sunscreen ingredient as well as a whitener. That edge is not a line on the strip.''',
      ),
      spec(
        'The white spark',
        '''Burning titanium and titanium sparks look white because many lines plus a hot-particle continuum reach the eye together. White is a sum. The spectroscope undoes the sum and finds the blue and violet lines underneath.

The element's reputation for strength and for aircraft belongs to the metal lattice. The spectrum belongs to the vapor. The card is about the vapor.''',
      ),
    ],
  ),
  spectrumEssay(
    23,
    'Vanadium\'s visible lines cluster in the blue, a tight group a spark spectroscopist learns beside iron\'s. In cool stars the oxide VO joins TiO as a banded signature of the coolest atmospheres.',
    [
      spec(
        'A blue group of V I lines',
        '''The pack stores three V I lines near 438, 438.5, and 441 nm. They are a fragment of a dense neutral spectrum. Vanadium has an open d shell, five valence electrons counting the s electrons, and the term structure is crowded. An arc spectrum is a picket fence. The three stored lines are persistent ones in the blue, useful for identification, not a complete portrait.

V II is equally important in stars. Singly ionized vanadium supplies lines that abundance work actually measures in G and K stars, where the neutral atom is partly ionized. The analyst's spark and the astronomer's atmosphere do not always quote the same stage.''',
      ),
      spec(
        'VO bands and the coolest stars',
        '''Below a certain temperature, TiO is joined by VO, and the vanadium oxide bands become a classification criterion for late M stars and for some brown dwarfs. The bands are molecular. They are as diagnostic as a line, and they are not lines of V I. A spectrum of a very cool object can be more oxide than atom.

On Earth, vanadium in steel is a hardenability addition, and the mill's spark spectrometer reads it with the atomic lines. The blue of some vanadium compounds in solution is a charge-transfer color of an ion, broad and chemical, unrelated to the 438 nm triplet except by the name of the element.''',
      ),
      spec(
        'A name from a goddess, a spectrum from a d shell',
        '''Vanadium's compounds are famously polychrome, yellows and blues and greens of different oxidation states. That rainbow is coordination chemistry. It tempts people to expect a rainbow of atomic lines. The atomic lines are many, but they are sharp and they are not those paint-pot colors.

The stored blue lines are the honest visible sample. The rest of the atlas is the same kind of mark, repeated.''',
      ),
    ],
  ),
  spectrumEssay(
    24,
    'Chromium has a green triplet that really is atomic, near 520 nm, and a violet triplet near 427 nm. The green of an emerald is a different chromium, an ion in a crystal, and it does not have these lines.',
    [
      spec(
        'Two triplets',
        '''The pack stores Cr I lines at about 425.4, 427.5, and 429.0 nm, and the green triplet at about 520.5, 520.6, and 520.8 nm. The green three are so close that a small instrument may draw them as one mark. They are persistent neutral lines, and they are why chromium can contribute green to a flame or a spark when the conditions free the atoms. The violet triplet is equally classical in the atlas.

Cr II and Cr III appear in hotter sparks. Analytical lines for chromium in steel are chosen from this forest for freedom from iron blends. The green triplet is one of the regions people remember because it sits where the eye is sensitive.''',
      ),
      spec(
        'Emerald, ruby, and the laser',
        '''Emerald is green and ruby is red because Cr3+ replaces a few aluminum ions in a beryl or a corundum lattice. The color is a crystal-field spectrum of a d-shell ion: broad absorption bands, plus, in ruby, a sharp emission that the laser community calls R1 and R2, near 694 nm. That sharp emission is famous and it is not a Cr I arc line. It is the ion, perturbed by the crystal, and the sharpness survives because the transition is a bit forbidden and the lattice is quiet.

The ruby laser is that solid-state line, amplified. Chromium's gas-phase triplets are the analytical and astronomical spectrum. Both are spectroscopy. They are not interchangeable on the strip.''',
      ),
      spec(
        'Stars and steel',
        '''Chromium abundances in stars come from both neutral and ionized lines, and chromium is one of the iron-peak elements whose pattern records supernova yields. In the mill, chromium in stainless steel is read by spark emission many times a minute. The same wavelengths, two economies.

The yellow of a chromate solution is yet a third spectrum, a molecular ion. Chromium is a lesson in how many spectra one element can own.''',
      ),
    ],
  ),
  spectrumEssay(
    25,
    'Manganese announces itself in the violet, a tight triplet near 403 nm that a steel spark and a stellar spectrum both know. The purple of permanganate is not that triplet.',
    [
      spec(
        'The 403 nm triplet',
        '''The pack stores three Mn I lines within a few tenths of a nanometre of 403 nm. They are the resonance triplet of neutral manganese, strong and characteristic, sitting at the violet edge. A flame or a spark rich in manganese shows them clearly, and they are a standard analytical group for manganese in iron and in aluminum. Because they are close, resolution is part of the identification. A blend with a neighboring element has to be ruled out by the pattern, not by a single peak.

Mn II lines carry much of the stellar abundance work. Manganese is easily ionized in solar-type stars, so the ion is the fairer representative. The neutral triplet remains the laboratory's calling card.''',
      ),
      spec(
        'A purple that is a molecule',
        '''Potassium permanganate is purple because the MnO4− ion absorbs broadly across the green and the yellow, a charge-transfer band. The absorption is molecular. It will not resolve into the 403 nm triplet. Dilute the solution and the band stays broad. That purple is still manganese, and it is still not the atomic spectrum.

The brown of manganese dioxide and the colors of manganese glazes are solid-state. The element's reputation for color comes from these ions. The element's identity in a metal comes from the sharp triplet.''',
      ),
      spec(
        'Iron-peak company',
        '''Manganese sits with chromium, iron, and nickel as an iron-peak element, made in explosive burning and in nuclear statistical equilibrium in supernovae. Stellar manganese abundances, read from the lines, are one of the checks on those models. The triplet on the card is the terrestrial template for a cosmic argument.

In biology, manganese in enzymes is a cofactor, present as an ion in a protein. It has no emission line in a leaf. The spectrum appears when the analyst digests the sample and frees the atoms.''',
      ),
    ],
  ),
  spectrumEssay(
    26,
    'Iron is the element whose spectrum looks like a barcode. Thousands of lines cross the ultraviolet and the visible, and the solar spectrum is so full of them that nineteenth-century maps of the Sun were, in large part, maps of iron.',
    [
      spec(
        'A forest, and the handful the pack keeps',
        '''The pack stores a teaching selection of Fe I lines: a violet group near 372, 373, and 375 nm, blue lines near 438 and 440 nm, and green lines near 517 and 527 nm. They are persistent neutral lines. They are not "the iron line." There is no single iron line the way there is a sodium doublet. Identification is the pattern, the way the lines cluster and the way their strengths stand in a known ratio.

Fe II is a second forest, and in many stars it is the dominant one, because iron is partly ionized. The classification of stars, from the Henry Draper catalogue onward, leaned on the appearance of these forests. Spectral type is, among other things, a statement about which iron lines are strong.''',
      ),
      spec(
        'Why iron is both the calibrator and the nuisance',
        '''A hollow-cathode lamp of iron, or a simple arc, is a classical wavelength calibrator, because the lines are everywhere and their wavelengths are known to high precision. The same density is a nuisance. In a crowded spectrum an analyst hunting a trace element must be sure the mark is not an iron line of the matrix. Line lists exist largely to answer that question.

In the Sun, iron lines measure abundance, velocity fields, magnetic fields through the Zeeman effect, and the temperature structure of the atmosphere. Helioseismology uses the shifts and the shapes. The element is common enough in stars that its lines are a background against which peculiar abundances of other elements are judged.''',
      ),
      spec(
        'Sparks, rust, and the color of the metal',
        '''A grinding spark from steel is a burst of iron lines plus a hot-particle continuum, which is why it looks yellow-white and why a spectroscope pointed at a spark can read the alloy. Rust is an iron oxide with a broad solid-state color. It has no Fe I lines until it is dissociated. The grey of cast iron and the shine of a blade are metallic reflection.

The pack's seven lines are a door into the forest. A research atlas of Fe I alone fills volumes. The strip is honest about being a selection.''',
      ),
    ],
  ),
  spectrumEssay(
    27,
    'Cobalt\'s atomic lines lie mostly in the ultraviolet, with a spill into the violet. The deep blue of cobalt glass is an ion in a melt, and it is the color people mean by cobalt, which makes the atomic spectrum easy to misremember.',
    [
      spec(
        'Ultraviolet lines of Co I',
        '''The pack stores Co I lines near 341, 345, and 400 nm. The first two are in the ultraviolet, the third at the violet edge. They are persistent lines used in the emission analysis of steels and of high-temperature alloys, where cobalt is an intentional addition. The neutral spectrum is dense, as an open d shell guarantees. The stored lines are the ones that survive as identification marks.

Co II supplies further lines that stellar spectroscopy uses. Cobalt is an iron-peak element, and its abundance relative to iron is a constraint on supernova models, read from these forests with great care about blends.''',
      ),
      spec(
        'The blue that is not the arc',
        '''Cobalt glass, smalt, and the blue of some ceramics are Co2+ in a tetrahedral or similar site, a crystal-field absorption that removes the red and the yellow and leaves the blue. The absorption bands are broad. They will not become the 345 nm line if you look harder. They are the ion, coordinated by oxygen, not the free atom.

Cobalt blue as a painter's pigment is this chemistry. A discharge tube is not how that pigment was designed, and the pigment will not help you calibrate a spectrograph.''',
      ),
      spec(
        'A metal known late, a spectrum known well',
        '''Cobalt was a miner's nuisance, the ore that would not yield copper, before it was a named metal. Once the metal existed, its spark spectrum joined the atlas. Nothing about the folklore of kobolds predicts the wavelengths. The d-shell structure does.

Vitamin B12 contains cobalt in a corrin ring. That is bioinorganic chemistry. The cobalt there has the spectrum of a complex, if it has a color at all, not the ultraviolet triplet of Co I.''',
      ),
    ],
  ),
  spectrumEssay(
    28,
    'Nickel is iron\'s neighbor in the forest of lines, with its strongest neutral marks in the near ultraviolet around 341 to 352 nm. In stars and in stainless steel it is measured by refusing to confuse it with iron.',
    [
      spec(
        'The near-ultraviolet triplet',
        '''The pack stores Ni I lines near 341.5, 351.5, and 352.5 nm. They sit just short of the visible window, which is why nickel has no flame color of its own and a very clear instrumental signature. The lines are persistent and they are standard in spark spectrometry of steels, of nickel alloys, and of meteoritic metal.

The spectrum is dense. Nickel's electron configuration, a nearly filled d shell, produces many terms. An atlas page for Ni I is a barcode of the same kind as iron's, shifted and with its own intensity pattern. The pattern, not any one romantic color, is the identification.''',
      ),
      spec(
        'Meteorites, stars, and coinage',
        '''Iron-nickel metal in meteorites is assayed chemically and spectroscopically. The cosmic Ni/Fe ratio is a nucleosynthesis result, the product of nuclear statistical equilibrium, and stellar nickel lines are part of how that ratio is watched from star to star. In cooler stars Ni I is useful. In hotter stars Ni II takes over.

The silvery color of the metal and the green of oxidized nickel salts are not these lines. The green of a nickel compound in solution is a d–d band of the ion, broad, the sort of spectrum a colorimeter sees and a grating resolves only as a hump.''',
      ),
      spec(
        'Reading a line that the strip may hide',
        '''Because the stored lines are shorter than 380 nm, the visible strip can honestly say that nickel's selection lies outside the window. That is a property of the wavelengths, not a defect in the lamp. A near-ultraviolet spectrograph sees them at once.

Nickel carbonyl and other chemicals are a safety story with no optical-line content. The spectrum on this card is the free atom's.''',
      ),
    ],
  ),
  spectrumEssay(
    29,
    'Copper is a green flame and an ultraviolet doublet. The flame that students remember comes largely from the green lines near 511 to 522 nm, helped by molecular bands. The lines analysts trust for traces are the resonance pair near 325 and 327 nm.',
    [
      spec(
        'Two regions, one element',
        '''The pack stores both: Cu I at 324.8 and 327.4 nm, the resonance doublet in the ultraviolet, and the green group near 510.6, 515.3, and 521.8 nm. The resonance lines are the atomic-absorption and plasma lines for copper in water, soils, and alloys. They are intense because they connect to the ground state. The green lines are higher jumps, weaker in absorption from a cold vapor, and bright in a flame or a brass spark, where collisions populate the upper levels.

A borax bead or a flame with a copper salt looks green to blue-green. Part of that light is the atomic green group. Part is molecular, CuCl bands and their kin, a band spectrum that comes and goes with the halide in the flame. The teaching color is a mixture. The strip separates the atomic part.''',
      ),
      spec(
        'The color of the metal, and the color of the ion',
        '''Copper metal is red because of its band structure, a solid-state absorption that begins in the green and the blue and lets the red reflect. That is not Cu I emission. The blue of hydrated Cu2+ is a d–d band of the ion in water, broad and shifted by whatever ligands surround it. Ammonia turns it deeper blue. None of those blues is the 325 nm line.

Colloidal copper and copper alloys add still more ways for the element to color an object. The spectroscopist who wants the element, rather than the object, asks for the sharp lines.''',
      ),
      spec(
        'Brass, bronze, and the spark',
        '''A spark from brass shows copper's lines and zinc's lines together, and the intensity ratio is a classical assay of the alloy. The method is older than electronics. It is still the method, automated, on a foundry floor. Bronze adds tin's ultraviolet lines to the same argument.

In stars, copper is a heavier element, made by neutron capture, and Cu I lines in the visible and the near ultraviolet measure it. The green group and the resonance doublet are the laboratory originals of those stellar marks.''',
      ),
    ],
  ),
  spectrumEssay(
    30,
    'Zinc\'s resonance line is deep in the ultraviolet, near 214 nm, and it is one of the great atomic-absorption lines. The visible lines, blue and red, are what a brass spark shows when the eye is allowed to watch.',
    [
      spec(
        'The 214 nm line, and the visible companions',
        '''The pack stores Zn I at 213.9 nm, the resonance line, and visible lines near 472, 481, and 636 nm. The ultraviolet line connects to the ground state and is the one used for traces of zinc in water, serum, and alloys. It is far outside the strip's window. The blue pair and the red line are higher excitations, prominent in emission from an arc or a spark, secondary in absorption work.

Zinc has a closed d shell and two s electrons, so the neutral spectrum is simpler than iron's. It resembles an alkaline earth more than it resembles its d-block neighbors. The lines are fewer and more decisive. That simplicity is a gift to the analyst and a mild disappointment to anyone hoping for a barcode.''',
      ),
      spec(
        'Brass and the stars',
        '''In brass the zinc lines beside copper's are the composition measurement, as they have been since spark spectra were photographed on glass plates. The red line near 636 nm is an easy mark in emission. The assay that decides a specification more often uses the ultraviolet resonance line, where the sensitivity is higher.

Zinc abundances in stars constrain the later stages of nucleosynthesis and the contribution of supernovae. The ultraviolet resonance region is again the workhorse, often from space. The visible lines are the part a ground-based teaching spectrograph can still see.''',
      ),
      spec(
        'A metal without a flame color',
        '''Zinc salts do not give a useful Bunsen color. The resonance jump is too far into the ultraviolet, and the visible lines are not strong enough in a cool flame to paint it. If a zinc sample colors a flame, suspect sodium, or copper, or the match.

The white of zinc oxide pigment is scattering from a powder, a solid-state optical trick, the same family of explanation as titanium white. It is not the 472 nm line. The line appears when the oxide is dissociated in a plasma, which is a different experiment from painting a wall.''',
      ),
    ],
  ),
];
