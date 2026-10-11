import 'property_guide.dart';

const physicalGuides = <PropertyGuide>[
  PropertyGuide(
    id: GuideId.covalentRadius,
    title: 'Covalent radius',
    group: 'Physical properties',
    lede: 'The covalent radius is a way of saying how far an atom reaches when it forms a single covalent bond. It is half of a characteristic bond length, not the edge of a hard ball, and not the radius of the electron cloud.',
    sections: [
      GuideSection(
        'What is being halved',
        'Measure the distance between two nuclei in a single bond between identical atoms, then take half of it. That half is the covalent radius. The carbon–carbon distance in diamond is about 154 pm, so carbon\'s single-bond covalent radius is about 77 pm. In a bond between two different atoms, the bond length is often close to the sum of the two radii. "Close" is doing real work. Multiple bonds are shorter. Polar bonds and crowded molecules shift the length. The radius is a useful addend, not a law.\n\n'
            'Other radii answer other questions. The van der Waals radius reaches to the contact distance between atoms that are not bonded. The metallic radius is half the distance between nuclei in the metal. The ionic radius depends on the charge and on how many neighbors the ion has. A chloride ion is larger than a covalent chlorine atom. The row is labeled covalent so those are not mixed in.',
      ),
      GuideSection(
        'How the radii were established',
        'X-ray diffraction, after Max von Laue\'s 1912 experiment and the Bragg law in 1913, gave internuclear distances in crystals. Gas-phase electron diffraction and microwave spectroscopy gave them in molecules. Linus Pauling, and others beside him, turned tables of those distances into tables of radii that students could add. Later compilations redid the averaging with more structures and clearer rules. The sets named for Slater, Cordero, Pyykkö, and others disagree by picometres, because "a typical single bond" is a judgment over many molecules.\n\n'
            'There is no single official covalent radius the way there is an official atomic number. Element Deck stores one teaching value per element, in picometres, and leaves the row blank when the pack has no honest figure. A blank is preferable to a radius invented by continuing a trend.',
      ),
      GuideSection(
        'Where the unit comes from',
        'The stored unit is the picometre. One picometre is 10⁻¹² metre, a trillionth of a metre. A carbon radius of about 76 pm is 7.6 × 10⁻¹¹ m. The older chemical unit is the ångström, 10⁻¹⁰ metre, so 100 pm. It is named for Anders Jonas Ångström, who mapped the solar spectrum in the 1860s and needed a small length. Crystallographers still say ångströms. School tables often say picometres.\n\n'
            'App Config can show this row in picometres or in ångströms. The stored number does not change. An ångström display divides the picometre value by 100. Neither unit is a radius "in atoms." Both are lengths.',
      ),
      GuideSection(
        'How to read the row',
        'Compare down a group and across a period, not against a van der Waals table from another book. Down a group the radius generally grows, because a new shell has been added. Across a period it generally shrinks, because the nuclear charge rises while the valence shell stays the same. The famous break between a tiny second-period atom and a much larger third-period atom, fluorine to chlorine, or oxygen to sulfur, is this number.\n\n'
            '"Not reported" means the compilation has no covalent radius it is willing to print. That is normal for many superheavy elements, and it happens for lighter ones when a single-bond distance is a poor description of the chemistry. Do not treat a missing radius as zero. Compare mode skips a bar rather than draw one from nothing.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.electronegativity,
    title: 'Electronegativity',
    group: 'Physical properties',
    lede: 'Electronegativity is a measure of how strongly an atom in a molecule attracts the electrons of a bond. The number on this row is Pauling\'s scale. It is a comparative index, not a force in newtons and not an energy.',
    sections: [
      GuideSection(
        'What the scale compares',
        'Fluorine sits at the top, just under 4. Cesium and francium sit near the bottom, under 1. Hydrogen is near 2.2. A large difference between two bonded atoms means a polar bond, and a very large difference means the bookkeeping of oxidation states starts to look like real ions. A small difference means a bond that is covalent and nearly nonpolar. Carbon and hydrogen are close. Carbon and fluorine are not.\n\n'
            'The value is for an atom in a bonding context. It is not a property of an isolated atom in the way ionization energy is, even though the two are related. It also depends a little on the bond the atom finds itself in. Tables quote one number per element anyway, because one number is enough to predict the direction of a great many polarities.',
      ),
      GuideSection(
        'How Pauling built it',
        'Linus Pauling, in 1932, started from bond energies. A bond between A and B is usually stronger than the average of an A–A bond and a B–B bond. He took the extra strength as a sign that electrons were being drawn toward the more greedy atom, and he turned the square root of that extra energy into a difference of electronegativities. Differences do not fix a zero point. He chose one so that hydrogen landed near 2.1, and the familiar scale fell out. Later he adjusted the numbers as better bond energies arrived. Fluorine\'s 3.98, rather than a round 4, is one of those adjustments.\n\n'
            'Other scales test the same idea differently. Robert Mulliken averaged the ionization energy and the electron affinity, which makes electronegativity look like a property of the bare atom. Allred and Rochow used the electrostatic pull of the nucleus at the covalent radius. Leland Allen used the average energy of the valence electrons from spectra. The scales correlate. They are not identical, and they are not interchangeable inside a formula. This row is Pauling\'s. The word Pauling is printed next to the number so a Mulliken value is not compared with it by accident.',
      ),
      GuideSection(
        'Why there is no SI unit',
        'Pauling electronegativity is dimensionless. The original construction used electronvolts inside a square root and then discarded the unit, leaving a pure number on a scale fixed by hydrogen. You cannot convert it to joules in App Config. The energy setting does not apply. There is no degree and no picometre hiding in the figure.\n\n'
            'Because the zero is conventional, a value of 2.2 does not mean "twice as electronegative" as 1.1 in a physical proportion. Differences are the meaningful arithmetic. Subtract, and compare the gap with the gap in another bond. Do not multiply.',
      ),
      GuideSection(
        'How to read the row',
        'Noble gases are often blank. A Pauling value needs bond energies, and a family that barely bonds does not have a full set. "Not reported" is that blank. Zero would be wrong, because zero would look like a real place on the scale, below the alkali metals.\n\n'
            'Across a period the number generally rises. Down a group it generally falls. Those two trends, together with the covalent radius and the first ionization energy, are the quantitative backbone of the periodic law as a first course teaches it. The number is only as sharp as the scale. Quoting it past two decimals pretends the scale was measured like a length.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.firstIonization,
    title: 'First ionization',
    group: 'Physical properties',
    lede: 'The first ionization energy is the energy needed to remove the least tightly held electron from a neutral atom in the gas phase, leaving a singly charged positive ion. It is a ground-state to ground-state quantity.',
    sections: [
      GuideSection(
        'The process the number refers to',
        'Write it as a reaction. Atom, in the gas, becomes ion-plus and a free electron. Both the atom and the ion are in their lowest states, and the electron is removed to rest at infinity. The energy of that change is the first ionization energy. "First" means the first electron, not the first element. The second ionization energy removes an electron from the ion that is already positive, and it is always larger, because you are pulling a negative electron away from a cation. This row is only the first.\n\n'
            'The atom has to be isolated. Ionization energy is not the work function of a metal, which is the energy to remove an electron from the solid. It is not the electrochemical potential of an ion in water, which includes solvation and is a different experiment entirely. Sodium\'s ionization energy is modest. Sodium metal is still perfectly willing to give up an electron to water, because the ion is then surrounded by solvent. The row does not describe that willingness. It describes the bare atom.',
      ),
      GuideSection(
        'How it was measured',
        'The early values came from spectra. A series of lines crowds toward a limit, and the limit is the energy at which the electron is free. Johannes Rydberg\'s formula for hydrogen, and the Rydberg constant, made that limit quantitative. Hydrogen\'s first ionization energy is 13.6 eV. Helium, with a tighter hold on its two electrons, is the highest of all the elements, near 24.6 eV. The alkali metals are the lowest among the common elements, which is the same fact as their violent chemistry, seen from the gas phase.\n\n'
            'Later, photoelectron spectroscopy measured the energies by shining light of known energy on a gas and watching the kinetic energy of the electrons that came out. The difference is the ionization energy. Tabulated values are spectroscopic. Element Deck stores one teaching value in electronvolts. It is not a measurement the device has just performed.',
      ),
      GuideSection(
        'Where the units come from',
        'The stored unit is the electronvolt. One electronvolt is the kinetic energy an electron gains when it is accelerated through a potential difference of one volt. Since the 2019 SI revision, the elementary charge is an exact constant, so one electronvolt is exactly 1.602176634 × 10⁻¹⁹ joule. The name records the experiment: a charge e times a voltage.\n\n'
            'Chemists often want the energy per mole of atoms, in kilojoules per mole. That is the same quantity multiplied by Avogadro\'s number. One electronvolt per atom is 96.485 kJ/mol. App Config can show either. The pack keeps electronvolts, and the display multiplies when you ask for kJ/mol. A second ionization energy is not hiding in the conversion. Switching units does not change which electron was removed.',
      ),
      GuideSection(
        'How to read the row',
        'The periodic pattern is the lesson. Ionization energy generally rises across a period, as the atom gets smaller and the nuclear charge gets harder to escape, and it falls when a new shell starts, which is why the alkali metal under a noble gas is so much easier to ionize. Small dips, at boron and at oxygen in period 2, are part of the pattern too: a newly started p electron, or the first paired p electron, comes off a little more easily.\n\n'
            '"Not reported" means the pack has no value. Do not read a blank as zero, and do not borrow the second ionization energy from another table and drop it in this row. They are different processes. The figure is for the neutral gas atom, once.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.meltingPoint,
    title: 'Melting point',
    group: 'Physical properties',
    lede: 'The melting point is the temperature where the solid and the liquid of the element are in equilibrium at a stated pressure. Above it, the solid is no longer the stable condensed form. Below it, the liquid freezes.',
    sections: [
      GuideSection(
        'What equilibrium means here',
        'At the melting point, solid and liquid can sit together indefinitely, with no net freezing and no net melting, provided the pressure is the pressure the table assumed. Add heat and the temperature stays put while solid turns to liquid. The heat you add is the enthalpy of fusion, which is a different quantity and is not on this row. The row is only the temperature.\n\n'
            'Pressure matters, and allotropes matter. Carbon\'s quoted melting point is for conditions where liquid carbon exists at all. At ordinary pressure, graphite sublimes. Helium does not freeze at 1 bar no matter how cold it gets. A melting point listed for helium belongs to a pressure high enough to force the solid into existence. White tin and gray tin switch near room temperature, slowly. The row is a single teaching temperature. It does not print the pressure, and it does not print which allotrope.',
      ),
      GuideSection(
        'How temperatures acquired a zero',
        'Early melting points were comparative: this metal melts in a furnace that does not melt that one. Quantitative tables needed a scale. Daniel Fahrenheit, Anders Celsius, and others built scales from the freezing and boiling of water, or from brine and blood. Celsius proposed his hundred-degree division in 1742. The modern direction, water freezing at 0 and boiling at 100, was fixed soon afterward.\n\n'
            'William Thomson, later Lord Kelvin, argued in 1848 for a scale with a real zero, the point where thermal motion in the ideal sense is gone, fixed by the efficiency of heat engines rather than by the properties of water. Absolute temperatures made the gas laws simple. In the 2019 revision of the SI, the kelvin is defined by fixing the Boltzmann constant. The triple point of water is no longer exactly 273.16 K by decree. It is a measured temperature on a scale whose zero and whose size are defined elsewhere. Melting points of the elements are still reported on that scale.',
      ),
      GuideSection(
        'Where the displayed unit comes from',
        'The pack stores kelvin. A degree Celsius is the same size as a kelvin, shifted so that water\'s normal freezing point is 0 °C, which is 273.15 K. App Config can show either. The Celsius display subtracts 273.15 and rounds to the nearest degree. A stored value of 13.99 K for hydrogen\'s melting point is about −259 °C. The rounding is the display. The pack still holds the kelvin figure.\n\n'
            'There is no degree Fahrenheit in App Config. Older engineering tables use it. If you meet one, convert through Celsius rather than by editing this row. The unit is a temperature, not a temperature difference, so the 273.15 offset is required. Forgetting the offset is how a melting point ends up below absolute zero on the page.',
      ),
      GuideSection(
        'How to read the row',
        'Compare it with the standard state. A melting point far below 298 K is a substance that is liquid or gas at room temperature, if the boiling point is above or below that as well. A melting point of thousands of kelvin is a refractory solid. Tungsten and carbon are the familiar extremes. "Not reported" is common for elements that have never been prepared as a visible piece of matter.\n\n'
            'A superheavy melting point, when a book quotes one, is usually a calculation. This catalog would rather leave the row blank than print an estimated temperature as if it had been watched in a crucible. If a number is present, read it as the compiled teaching value, and remember that the pressure and the allotrope are part of the meaning even when they are not printed.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.boilingPoint,
    title: 'Boiling point',
    group: 'Physical properties',
    lede: 'The boiling point is the temperature where the liquid and the gas of the element are in equilibrium at a stated pressure. The usual quoted figure is the normal boiling point, at one atmosphere, or the nearby standard value at one bar.',
    sections: [
      GuideSection(
        'What the equilibrium is',
        'At the boiling point, bubbles of vapor can form inside the liquid and the pressure of that vapor equals the surrounding pressure. Below the boiling point a liquid still evaporates from its surface. It does not boil. Above it, the liquid is no longer stable at that pressure. The heat you must add to boil the liquid, at constant temperature, is the enthalpy of vaporization. It is not this row. This row is the temperature only.\n\n'
            'Some elements never pass through a liquid at ordinary pressure. They sublime. The solid\'s vapor pressure reaches the surrounding pressure before a melting point is crossed. Iodine is the classroom example. Carbon at one bar is another. A boiling point in a table for such an element may be a value at a different pressure, a calculated critical-region figure, or a number this catalog has simply declined to print. Read "Not reported" as a refusal, not as a temperature of zero.',
      ),
      GuideSection(
        'How the points were fixed',
        'Boiling was a laboratory thermometer\'s second landmark, after freezing, because pure water boils at a reproducible temperature once the air pressure is named. Travelers learned that water boils colder on a mountain. That is the pressure dependence, and it is why a boiling point without a pressure is unfinished. The Clausius–Clapeyron relation, from the nineteenth century, connects the shift in boiling temperature to the enthalpy of vaporization. Low-temperature physicists then extended the same idea to oxygen, nitrogen, hydrogen, and helium, condensing the "permanent gases" and measuring where they boil.\n\n'
            'Helium boils near 4.2 K. That figure, more than any other, is why helium is the working fluid of low-temperature physics. The noble gases make a clean column of boiling points, rising as the atoms get heavier and more polarizable. Metals often boil only at thousands of kelvin. Both patterns are this row, read down a group.',
      ),
      GuideSection(
        'Where the unit comes from',
        'The pack stores kelvin, the same unit as the melting point. App Config can display degrees Celsius by subtracting 273.15 and rounding to a whole degree. The size of the degree is the same on both scales. Only the zero differs. Celsius is named for Anders Celsius\'s 1742 scale. Kelvin is named for William Thomson\'s absolute scale of 1848, and the modern kelvin is defined by the Boltzmann constant.\n\n'
            'A difference of boiling point and melting point is the width of the liquid range, and it must be taken in one unit. Subtracting a Celsius display from a kelvin display is meaningless. If you want the liquid range, subtract the stored temperatures, or subtract two displays that use the same unit. The row itself is one temperature, not that range.',
      ),
      GuideSection(
        'How to read the row',
        'Place it next to the melting point and the standard state. A standard state of gas means room temperature is already above the boiling point. A standard state of liquid means room temperature sits between melting and boiling, which is the situation of bromine and mercury. A standard state of solid means room temperature is below the melting point, so the boiling point is higher still.\n\n'
            'Quoted boiling points of the heaviest elements, where the row has a number at all, may be estimated. The dataset pin on the identity card tells you which compilation you are looking at. The article does not replace that compilation, and a blank row is data.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.density,
    title: 'Density',
    group: 'Physical properties',
    lede: 'Density is mass divided by volume. For an element, which mass and which volume depend on the form: the solid metal, the liquid, or the gas at a stated temperature and pressure. The row is one teaching value in grams per cubic centimetre.',
    sections: [
      GuideSection(
        'Which density this is',
        'A cubic centimetre of gold and a cubic centimetre of aluminum are the same size and very different masses. That ratio is what the row is for. Solids and liquids of the elements are often quoted near room temperature. Gases are quoted as gas densities, which are a thousand times smaller, so hydrogen appears as a number like 0.000084 g/cm³ rather than as the density of liquid hydrogen. The standard state tells you which phase the catalog is likely to mean. The row does not repeat the temperature.\n\n'
            'Allotropes disagree. Diamond is denser than graphite. White tin is denser than gray tin. A single density is the density of the form the compilation chose, often the standard-state form. It is not an average over every allotrope, and it is not the density of the nucleus. Nuclear density is a different regime, around 10¹⁴ g/cm³, and it is not what a chemistry table means.',
      ),
      GuideSection(
        'How it was measured',
        'The method is ancient. Archimedes, in the third century BCE, compared the weight of a piece with the weight of the water it displaced, which is a measurement of volume. Modern pycnometers, buoyancy balances, and X-ray densities from a measured lattice and a known atomic mass are refinements of that ratio. Gas densities came later, with precise volumes and the ideal-gas law, and they are how early atomic weights were sometimes checked against vapor density.\n\n'
            'X-ray density and buoyancy density can differ when a real crystal is full of voids. The X-ray value is the density of the ideal lattice. A teaching table usually wants the bulk density a sample has. Element Deck stores one figure and does not say which method produced it. Treat it as the compilation\'s bulk teaching value.',
      ),
      GuideSection(
        'Where the unit comes from',
        'The row uses grams per cubic centimetre, a centimetre-gram descendant of the old metric system. One g/cm³ is exactly 1000 kg/m³, the SI form. Water sits near 1 g/cm³, which is why the unit is intuitive: a number above 1 sinks in water, a number below 1 floats, for a solid that does not dissolve or react. Osmium and iridium, near 22, are the densest ordinary metals. Lithium, near half a gram per cubic centimetre, floats.\n\n'
            'App Config does not convert density. Length, energy, and temperature have switches. Density stays in g/cm³. A gas density may be printed in scientific notation so the zeros do not hide it. Scientific notation is still g/cm³. It is not a different unit.',
      ),
      GuideSection(
        'How to read the row',
        'Check the standard state before you compare two elements. Comparing the gas density of nitrogen with the solid density of iron is a comparison of two different kinds of "a cubic centimetre." Comparing iron with copper is fair. Down the alkali metals the solids get denser in a mild way while their atomic volume grows. The two trends together are a lesson in how much empty space a large atom leaves in its lattice.\n\n'
            '"Not reported" means the pack has no density. Do not insert the density of a compound, an ore, or the nucleus. Those are different materials or different physics.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.crystalLattice,
    title: 'Crystal lattice',
    group: 'Physical properties',
    lede: 'The crystal lattice is the repeating pattern of atoms in the solid element. The row names that pattern in teaching language, such as body-centered cubic or hexagonal close packed. Gases, and solids the pack does not describe, are left unreported.',
    sections: [
      GuideSection(
        'What the name describes',
        'A crystal is a motif repeated by translation. The motif plus the way it repeats is the lattice in the loose laboratory sense. Strictly, the lattice is the set of translation points, and the structure is the lattice plus the atoms attached to each point. Teaching tables blur the two, and so does this row. "Body-centered cubic" means a cubic cell with an atom at each corner and one in the center, the structure of iron at room temperature and of the alkali metals. "Face-centered cubic" puts an atom on each face as well, the structure of copper, silver, and gold. "Hexagonal close packed" is the other common way to stack spheres as tightly as geometry allows.\n\n'
            'Close packing fills about 74 percent of space with equal spheres. Body-centered cubic fills less. The density row is the measured consequence. The lattice row is the pattern. Allotropes are different patterns of the same element: carbon as hexagonal graphite, or as diamond, which is a cubic network of tetrahedra. The row names one form, the one the catalog chose to teach.',
      ),
      GuideSection(
        'How lattices were identified',
        'Crystal faces had been measured for centuries. René Just Haüy argued that they were the outer expression of a repeated inner block. The proof that the block is real, and a measurement of its size, came from diffraction. Max von Laue, Walter Friedrich, and Paul Knipping sent X-rays through a crystal in 1912 and got a pattern of spots. William Henry Bragg and William Lawrence Bragg showed, in 1913, that the spots are reflections from stacks of planes, and that the angle and the wavelength give the spacing. Structures of metals and of diamond followed within a few years.\n\n'
            'Auguste Bravais had already enumerated the possible translation lattices in 1850: fourteen of them, in seven crystal systems. Not every lattice is a structure an element adopts. The elements concentrate in a few simple ones, because identical atoms with no directional preference pack like spheres. Directional bonding, as in carbon or in the molecular crystals of iodine, produces the less metal-like patterns.',
      ),
      GuideSection(
        'Why there is no single unit',
        'The row is a name. Lattice constants, the edge lengths of the cell, are lengths, in picometres or ångströms, and they are not printed here. App Config\'s length switch does not rewrite a name. Angles in the cell, when they are not fixed by symmetry, are in degrees. They are not printed here either.\n\n'
            'A name without a temperature is slightly unfinished. Iron is body-centered cubic at room temperature and switches structure when it is hot. Tin switches near the cold of a winter. The row gives the teaching structure, generally the one stable at ordinary temperature, and leaves the phase diagram to a fuller reference.',
      ),
      GuideSection(
        'How to read the row',
        '"Not reported" is the right text for a gas, for a liquid, and for an element whose solid structure is not in the pack. It is not a claim that the frozen element is amorphous. Helium does crystallize under pressure. The catalog simply has no lattice string for it.\n\n'
            'Read the name with the standard state. A solid with a lattice is the ordinary form. A solid whose lattice says hexagonal graphite is the carbon the atomic weight and the density also refer to, unless a note says diamond. Compare two metals by lattice when you are explaining slip, ductility, or why one metal is soft. The name is the structure. It is not a hardness value.',
      ),
    ],
  ),
];
