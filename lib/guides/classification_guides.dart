import 'property_guide.dart';

const classificationGuides = <PropertyGuide>[
  PropertyGuide(
    id: GuideId.category,
    title: 'Category',
    group: 'Identity',
    lede: 'Category is the chemical family used for the chip, the tile color, and the filters. It is a classification, not a measurement. The color is never the only signal. The name is printed as well.',
    sections: [
      GuideSection(
        'What the families are',
        'The usual cut is metals, metalloids, and nonmetals, then a finer cut that courses actually teach: alkali metals, alkaline earth metals, transition metals, post-transition metals, metalloids, reactive nonmetals, halogens, noble gases, lanthanides, and actinides. Hydrogen is filed here as a reactive nonmetal. Helium is a noble gas. The family is a summary of recurring chemistry: the alkali metals lose one electron and form +1 ions, the halogens gain one and form −1 ions, the noble gases mostly refuse both.\n\n'
            'Borders are the awkward part. Metalloids are the elements that sit on the staircase and behave partly like metals and partly like nonmetals. Which elements are on that list is a teaching convention. Polonium, astatine, and some of the heavier p-block elements get moved by different authors. A category is a decision about resemblance. It is not a value you can measure with a smaller uncertainty.',
      ),
      GuideSection(
        'How the families were recognized',
        'Johann Wolfgang Döbereiner grouped a few elements in triads in the 1820s. John Newlands tried octaves in the 1860s. Dmitri Mendeleev and Julius Lothar Meyer, working independently at the end of that decade, arranged elements so that chemical behavior repeated. The columns of that arrangement are the ancestors of the modern families. Mendeleev left holes where a family member seemed to be missing, and he described the missing elements well enough that gallium, scandium, and germanium were recognized when they turned up.\n\n'
            'The labels shifted as the table grew. The rare earths were a notorious swamp of almost identical chemistry until the f-block gave them a place. The noble gases were not in Mendeleev\'s early table at all. Argon was isolated in 1894, and a whole new family had to be inserted. Transition metals acquired their name from the way their properties seemed to transition between the strongly metallic groups and the groups that form acidic oxides. The name stuck after the d electrons made the pattern physical.',
      ),
      GuideSection(
        'Why there is no unit',
        'A family name has no dimension. App Config does not convert it. The color paired with the name is a display choice from the design system: cyan for reactive nonmetals, violet for noble gases, amber for the alkali and alkaline earth metals, emerald for transition metals, and so on. Halogens keep the nonmetal color and are distinguished by the chip text, and by the Tags row when that row is present.\n\n'
            'Do not treat the color as data about the emission spectrum. Neon\'s tile is the noble-gas violet. Neon\'s discharge is orange-red. Those are different facts, stored in different places.',
      ),
      GuideSection(
        'How to read the row',
        'The words match the header line under the mass. Filters on the periodic table use the same families. "All" is 118 elements. A halogen filter is narrower than the nonmetal color, which is why fluorine and oxygen can share a hue and still be separated by a tag. If a border element surprises you, the category is telling you which teaching family this catalog chose, not that nature drew a sharp line.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.tags,
    title: 'Tags',
    group: 'Identity',
    lede: 'Tags are extra labels that cut across the color family. The one this catalog uses is halogen. Fluorine is a reactive nonmetal by color and a halogen by tag, so a filter can be narrower than the tile hue.',
    sections: [
      GuideSection(
        'What a tag adds',
        'Category answers "which family colors the tile?" A tag answers "which tighter group should a filter be able to select?" Halogens are fluorine, chlorine, bromine, iodine, and astatine. They are taught as their own column, group 17, with a shared habit of forming a −1 ion and a diatomic molecule. In this app their tile color stays with the reactive nonmetals, because the palette has one cyan for that whole region. The tag keeps the halogen course from disappearing into the wider color.\n\n'
            'An element can have no tags. Most do not. The row is hidden when the list is empty. Hydrogen is not tagged as a halogen. Astatine is, when the catalog marks it so. Tags do not change Z, the block, or the chemistry. They are an index.',
      ),
      GuideSection(
        'Where the halogen label came from',
        'The name means salt-former. Humphry Davy isolated chlorine and showed in 1810 that it was an element, against Lavoisier\'s view that it was a compound of oxygen. Iodine followed in 1811, bromine in 1826. Jöns Jacob Berzelius grouped them. The family was obvious before the periodic table existed: similar smells, similar salts, a steady darkening and a rising boiling point as the atoms got heavier. Fluorine was suspected in fluorite long before Henri Moissan isolated it in 1886, because the element attacks the apparatus.\n\n'
            'Astatine, made in 1940, completed the classical column as a short-lived radioactive member. Tennessine, element 117, is the next seat in the column. Whether it still behaves as a halogen is an open question of relativistic chemistry, not something a tag can settle. The tag says "this is the group we teach as the halogens."',
      ),
      GuideSection(
        'Why there is no unit',
        'Tags are words. They have no uncertainty and no conversion. A comma-separated list on the row means several labels apply at once. Order in the list is not a ranking.\n\n'
            'A tag is also not a state of matter, an oxidation state, or a safety classification. Those are other systems. Element Deck uses tags only for overlaps the category color cannot express.',
      ),
      GuideSection(
        'How to read the row',
        'If the row says halogen, the element passes the halogen filter and still keeps its category color. If you arrived from a filter, the tag is why a cyan tile showed up in a halogen search. Absence of the row means this catalog filed no extra label, not that the element is somehow unclassifiable.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.block,
    title: 'Block',
    group: 'Identity',
    lede: 'The block says which kind of orbital is being filled across that stretch of the table: s, p, d, or f. It is a map of the electron configuration, drawn as a region of the periodic table.',
    sections: [
      GuideSection(
        'What the letter means',
        'Orbitals come in types named s, p, d, and f, from the old spectroscopic series sharp, principal, diffuse, and fundamental. An s subshell holds 2 electrons, a p subshell 6, a d subshell 10, an f subshell 14. The s-block is groups 1 and 2, plus helium. The p-block is groups 13 through 18. The d-block is the transition metals, groups 3 through 12. The f-block is the lanthanides and actinides, drawn as the two rows set underneath or set into period 6 and period 7.\n\n'
            'The letter on this row is the subshell that receives the last electron in the usual building-up description. Calcium is s because the last electrons are 4s. Iron is d. Chlorine is p. Cerium is f. The row prints it as "s-block," "p-block," "d-block," or "f-block."',
      ),
      GuideSection(
        'How the blocks appeared',
        'The spectroscopic names are nineteenth century. The assignment of those series to angular momentum is quantum mechanics: Schrödinger\'s hydrogen atom gives orbitals labeled by n, l, and m, and the letter is a nickname for l. The periodic table\'s blocks are what you get if you color the table by the l of the electron that distinguishes each element from the one before it.\n\n'
            'The filling order students memorize, 1s then 2s then 2p then 3s then 3p then 4s then 3d, is the Madelung order, an empirical rule, not a theorem. It has well-known exceptions. Chromium and copper borrow from the s subshell to half-fill or fill the d subshell. Palladium is a stronger exception. The block label follows the configuration the catalog stores, not a guess you have to repair by hand. Helium is the classic placement argument: its configuration is 1s², so this catalog marks it s-block, while the table draws it in group 18 with the noble gases because its chemistry, such as it is, belongs there.',
      ),
      GuideSection(
        'Why there is no unit',
        'A block is a region. It has no magnitude. "d-block" is not larger than "s-block" in a sense you could subtract. App Config does not convert it. The letter is lowercase on purpose. A capital S or P would look like an element symbol or a term symbol.\n\n'
            'Do not confuse the block with the period or the group. Period is the row. Group is the column. Block is which kind of column-group you are in. All three can be true at once: iron is period 4, group 8, d-block.',
      ),
      GuideSection(
        'How to read the row',
        'Use it to predict the kind of configuration you will see below. An s-block element\'s valence story is an s electron or two. A p-block element is filling p. A d-block element is where oxidation states multiply, because d and s electrons are close in energy. An f-block element is where the chemistry often stays +3 while the f electrons hide. The header repeats the block next to the category.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.period,
    title: 'Period',
    group: 'Identity',
    lede: 'The period is the horizontal row of the periodic table. There are seven. A period collects the elements that fill one principal shell before the next row begins, which is why the rows grow longer as the shells grow roomier.',
    sections: [
      GuideSection(
        'What a row contains',
        'Period 1 holds hydrogen and helium, two elements, because the first shell holds two electrons. Periods 2 and 3 hold eight each. Periods 4 and 5 hold eighteen, once the d orbitals join. Periods 6 and 7 hold thirty-two, once the f orbitals join. The long f rows are usually drawn aside so the table stays a width a page can hold. They are still part of period 6 and period 7.\n\n'
            'Moving right along a period, the proton count rises by one at each step and the valence shell fills. Metallic character generally falls. Ionization energy and electronegativity generally rise, with famous interruptions where a subshell is half full or newly started. Those interruptions are the point of the row. A period is not a smooth ramp. It is a ramp with structure.',
      ),
      GuideSection(
        'How the rows were drawn',
        'Mendeleev\'s table already broke the sequence into lines so that similar elements fell in columns. He did not know about shells. The lengths 2, 8, 8, 18, 18, 32 were a puzzle he and his successors adjusted as new elements appeared. The noble gases, once found, closed each row. Bohr argued in the early 1920s that the periods were the shells of his quantum atom, and he predicted that element 72 would be a zirconium-like metal rather than a rare earth. Hafnium, found in 1923, sat where he said. That was the period system acquiring a physical length, not only a chemical one.\n\n'
            'The modern seven periods follow the principal quantum number of the outermost electrons closely, and not perfectly. The 4s orbital fills before 3d is complete, so period 4 begins at potassium with a 4s electron while the third shell is still open. The period number is the row index students use. It is a close cousin of n, not a synonym you can trust in every configuration.',
      ),
      GuideSection(
        'Why there is no unit',
        'A period is an index from 1 to 7. It is dimensionless. There is no "period 4.5," and App Config does not convert it. People sometimes say "the fourth shell" when they mean period 4. That is good teaching language and slightly loose physics, for the reason above: the shell being filled is not always the shell with n equal to the period number.\n\n'
            'The row number is also not a distance. Elements in the same period are not the same size. Size usually shrinks from left to right as the nuclear charge climbs and the valence shell stays the same.',
      ),
      GuideSection(
        'How to read the row',
        'The integer matches the header, which prints "Period 1" and the rest in words. On the matrix view of the table, the period is the horizontal band. Lanthanides belong to period 6 even when they are drawn in a footnote row. Actinides belong to period 7. Element 119, if it is made, would open period 8. It is not in this catalog of 118.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.group,
    title: 'Group',
    group: 'Identity',
    lede: 'The group is the vertical column. Members of a group share a valence pattern, which is why lithium resembles sodium more than it resembles beryllium, its neighbor in the row. The number on this row is the IUPAC group, from 1 to 18.',
    sections: [
      GuideSection(
        'What the column shares',
        'Group 1, the alkali metals, have one electron past a noble-gas core. Group 2 has two. Group 17, the halogens, are one electron short of a closed p shell. Group 18 has the closed shell. Down the column, the pattern repeats and the atoms get larger, so the shared chemistry slowly changes emphasis. Iodine is still a halogen, and it is a solid with a milder temperament than fluorine.\n\n'
            'The d-block groups are numbered 3 through 12. Their resemblance down a column is real and looser, because d electrons complicate the valence. The f-block is drawn as its own rows. In this catalog those elements have no group number from 1 to 18, and the row says "f-block row" instead of an integer. That is a statement about the 18-column layout, not a claim that lanthanum has no chemical relatives.',
      ),
      GuideSection(
        'How the numbering settled',
        'Mendeleev used Roman numerals, I through VIII, and a split into A and B families. Later traditions disagreed about which side was A. In the United States, group IIIA often meant boron\'s column. In Europe, group IIIA often meant scandium\'s column. The same label pointed at different elements, which is a bad property for a label.\n\n'
            'IUPAC recommended the Arabic numbering 1 through 18 in 1988, one number per column of the long table, with no A and no B. That is the number Element Deck prints. Old textbooks and some laboratory habits still say "group IVA" or "the carbon family." When you meet those, translate them. Carbon\'s family is group 14. The alkali metals are group 1, not "group IA" unless you are reading a page that still means that.',
      ),
      GuideSection(
        'Why there is no unit',
        'A group index is dimensionless. Group 18 is not "twice" group 9 in any physical sense. The number is a column address. App Config does not convert it. Hydrogen sits in group 1 because it has one valence electron. It is not an alkali metal, and the Category row is there so the column number is not asked to carry that meaning alone.\n\n'
            'Helium is drawn in group 18. Its configuration is a filled 1s shell, not a filled p shell, and its block in this catalog is s. The group number records the column where the table places it, with the other closed-shell gases.',
      ),
      GuideSection(
        'How to read the row',
        'An integer from 1 to 18 is the IUPAC column. "f-block row" means this element is laid out with the lanthanides or actinides and the catalog stores no 1–18 group. The header abbreviates the same fact as "Grp 14" or an em dash when there is no group. Compare mode uses the group as the natural place to look for a congener, the element below or above.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.standardState,
    title: 'Standard state',
    group: 'Identity',
    lede: 'The standard state is the form of the pure element used as the zero of its thermochemistry, at a stated temperature and pressure. On this row it is the everyday word for that form: solid, liquid, gas, or unknown.',
    sections: [
      GuideSection(
        'What is being specified',
        'Thermochemistry needs a starting point. The enthalpy of formation of an element in its standard state is zero by definition, and the enthalpies of its compounds are measured from there. The standard state is the stable form of the pure element at the standard pressure, conventionally discussed at 298.15 K, which is 25 °C. Carbon\'s standard state is graphite, not diamond. Oxygen\'s is the gas O₂, not ozone. Tin\'s is the white metallic form, not the gray one.\n\n'
            'The words on the row are coarser than the full definition. "Solid," "liquid," and "gas" say which phase that reference form is in. They do not name the allotrope. Graphite versus diamond lives on the Crystal lattice row when the catalog has a lattice. Bromine and mercury are the familiar liquids. Gallium and cesium melt just above room temperature, so at a strict 25 °C they are still solids, and a warm hand is a different experiment.',
      ),
      GuideSection(
        'How the convention was fixed',
        'Lavoisier\'s list of elements already implied ordinary forms: oxygen as a gas, carbon as a solid. The numerical convention grew with thermochemistry in the nineteenth and twentieth centuries, as heats of formation became a shared ledger. Two pressures have served as the standard. For a long time it was 1 atmosphere, 101.325 kPa. In 1982 IUPAC moved the standard pressure to 1 bar, which is 100 kPa exactly. The change is small for condensed phases and visible for precise gas-phase work.\n\n'
            'Allotropes keep the convention slightly uncomfortable. White phosphorus is the traditional reference state of phosphorus even though red phosphorus is more stable. The reference is a choice the tables share, not an award for the most inert form. Hydrogen\'s reference is H₂ gas. Atomic hydrogen would be a different, much higher-energy starting point, and it is not the standard state.',
      ),
      GuideSection(
        'Why the row has no extra unit',
        'The phase name has no unit. The temperature and pressure that define it do, and they are not repeated on the row. Unless a note says otherwise, read "standard state" as the form at about 25 °C and 1 bar. App Config can change how melting points are displayed. It does not recompute this word. A switch from kelvin to Celsius does not turn a solid into a liquid.\n\n'
            'Phase depends on conditions. Nitrogen is a gas in the standard state and a liquid in a Dewar. The row is about the reference form, not about every form you can prepare.',
      ),
      GuideSection(
        'How to read the row',
        'Gas, liquid, solid, or unknown. Unknown means the catalog will not pretend, which is the honest answer for many superheavy elements that have never been seen as a bulk phase. Use the row as the answer to "what is a bottle of the ordinary element?" Then use Melting point and Boiling point for the temperatures where that answer changes, and Crystal lattice for the solid\'s pattern when there is one.\n\n'
            'Helium is a gas. It does not freeze at 1 bar at any temperature. A melting point quoted for helium elsewhere on the card belongs to a higher pressure. The standard state stays the gas.',
      ),
    ],
  ),
  PropertyGuide(
    id: GuideId.dataset,
    title: 'Dataset',
    group: 'Identity',
    lede: 'The dataset row is the pin of the compiled pack this element was read from. It tells you which release of the teaching catalog supplied the numbers. It is not itself a chemical property of the atom.',
    sections: [
      GuideSection(
        'What the pin identifies',
        'Element Deck ships a catalog, and the catalog has a version. The string on this row, typically a mark such as compiled-v1.1, is that version stamped onto the element. When a later pack corrects a mass, a radius, or a sentence, the pin moves. The atomic number does not. Z is the identity of the element. The dataset is the identity of the file the element was copied from.\n\n'
            'The same pin is what a comparison dossier and the spectra footer are pointing at when they name the dataset. If two devices disagree about a value, the first question is whether they are on the same pin. A bookmark does not freeze the numbers. Updating the pack updates the values under the same Z.',
      ),
      GuideSection(
        'Where the numbers come from',
        'The pack is a compilation for teaching, assembled into one local file so the app can work without asking a server for each element. Standard atomic weights of the kind this card describes are published by the Commission on Isotopic Abundances and Atomic Weights. Ionization energies and spectral lines of record live in spectroscopic databases, among them the NIST Atomic Spectra Database. Covalent radii, electronegativities, and crystal structures come from crystallographic and chemical compilations that do not always agree with each other in the last digit.\n\n'
            'Element Deck does not remeasure any of this on the phone. A radius is not the result of a sensor. A spectral line is not the result of the camera. The pin is how the app says "these figures belong to this compilation." When a row says "Not reported," the compilation has a gap, and the gap is left visible.',
      ),
      GuideSection(
        'Why there is no unit',
        'A version string has no dimension. It does not convert in App Config. Units on the other rows are a separate decision: the pack stores kelvin, electronvolts, and picometres, and App Config may display degrees Celsius, kilojoules per mole, or ångströms. The dataset pin stays put while those labels change, because the stored value did not change.\n\n'
            'Do not read the pin as a precision claim. "v1.1" does not mean the masses are accurate to one decimal. Precision is a property of each quantity and its source. The pin only names the bundle.',
      ),
      GuideSection(
        'How to read the row',
        'Quote it if you are comparing notes with someone else using the app, the way you would quote the edition of a table. Isotope rows that describe themselves as a representative teaching isotope are part of this same compilation. They are not a promise that every natural abundance has been evaluated. The article you are reading explains the property. The dataset row tells you which compiled file supplied the figure beside it.',
      ),
    ],
  ),
];
