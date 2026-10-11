"""Uses for elements 61-118."""

USES: dict[int, list[tuple[str, str, str | None]]] = {
    61: [
        ("Made, not mined", "Promethium has no stable form, so every sample is produced in a reactor. There is no promethium ore.", None),
        ("Nuclear batteries", "A few specialized batteries have used the heat or the radiation from a promethium isotope. The amounts are sealed and small.", None),
        ("A gap in the table", "For a long time element 61 was the missing rare earth. Finding it in fission products, rather than in a rock, closed that gap.", None),
    ],
    62: [
        ("Magnets that stay hot", "Samarium-cobalt magnets keep their strength at temperatures where many other magnets weaken. They are used in motors that run hot.", None),
        ("Reactor control", "Some samarium isotopes absorb neutrons strongly, so the element is used in control rods that slow a reactor.", None),
        ("Headphones, an older design", "Before neodymium magnets were common, samarium-cobalt was the strong small magnet in many headphones and pickups.", None),
    ],
    63: [
        ("Red phosphors", "The red glow in many fluorescent lamps and older screens comes from a europium phosphor. A little of the element goes a long way.", None),
        ("Anti-counterfeiting", "Euro banknotes have used a europium compound that glows under ultraviolet light, as a mark that is hard to fake.", None),
        ("Two ions, two colors", "Europium can glow red in one ionic form and blue in another. Lamp makers use that pair on purpose.", None),
    ],
    64: [
        ("MRI contrast", "Some MRI scans use a gadolinium compound, injected so that particular tissues stand out in the picture. The metal itself is not injected.", "mri"),
        ("Magnets", "Gadolinium alloys are studied for magnetic refrigeration, a way of cooling with a changing magnetic field.", None),
        ("Neutrons", "Gadolinium absorbs neutrons very strongly, so it is used in some reactor shielding and in neutron radiography.", None),
    ],
    65: [
        ("Green phosphors", "Terbium compounds provide the green in many fluorescent lamps, next to europium's red.", None),
        ("Actuators", "An alloy called Terfenol-D, which contains terbium, changes shape in a magnetic field. That motion can drive a precise device.", None),
        ("A specialist metal", "There is no terbium hardware in a kitchen. The uses are the phosphor and the magnetostrictive alloy.", None),
    ],
    66: [
        ("Magnets in hot places", "A little dysprosium in a neodymium magnet helps the magnet keep its strength when a motor or a turbine runs hot.", None),
        ("Control rods", "Dysprosium absorbs neutrons and is used in some nuclear control rods, for the same reason samarium is.", None),
        ("Hard to separate", "The name means hard to get. Dysprosium is separated from the other rare earths for those two uses, not sold as a pure bar in a shop.", None),
    ],
    67: [
        ("Surgical lasers", "A holmium laser is used in some surgeries, including work on soft tissue and kidney stones. The holmium is a dopant in a crystal, not a rod of metal.", None),
        ("Magnetic pole pieces", "Holmium has an unusually high magnetic moment, so it is used in the pole pieces of some very strong laboratory magnets.", None),
        ("A rare-earth metal", "The ordinary chemistry is a +3 ion in a specialty salt. The public uses are the laser and the magnet.", None),
    ],
    68: [
        ("Internet cables", "A short stretch of optical fiber doped with erbium amplifies the infrared signal that carries data under the ocean and across continents.", None),
        ("Pink glass", "Erbium oxide tints glass pink. That is the visible form of an element whose important job is invisible infrared light.", None),
        ("Lasers in medicine", "Erbium lasers are also used in some skin and dental treatments. Again the element is a dopant in a crystal.", None),
    ],
    69: [
        ("Portable X-ray", "A sealed thulium isotope has been used as a small X-ray source where a full X-ray tube is impractical.", None),
        ("Lasers", "Thulium-doped fiber lasers emit in the infrared and are used in surgery and in materials work.", None),
        ("One of the scarcer rare earths", "Thulium is a small fraction of rare-earth ores. There is no bulk consumer product made of the metal.", None),
    ],
    70: [
        ("Atomic clocks", "One isotope of ytterbium is used in some of the most accurate atomic clocks. The clock uses trapped atoms, not a piece of metal.", None),
        ("Stainless steel", "A small addition of ytterbium improves the grain and the strength of some stainless steels.", None),
        ("A softer rare earth", "Ytterbium metal is softer than its neighbors and can form a +2 ion. Both facts matter to chemists more than to a hardware store.", None),
    ],
    71: [
        ("PET scanners", "A crystal containing lutetium detects the gamma rays in a PET scan. The dense crystal is the use, not a lutetium tool.", None),
        ("Catalysts", "A few petroleum catalysts use lutetium compounds. The amounts are small and the metal is expensive.", None),
        ("The end of the row", "Lutetium is the last lanthanide, and it is scarce. Its uses stay in instruments and catalysts.", None),
    ],
    72: [
        ("Control rods", "Hafnium absorbs neutrons, so it is used in control rods that regulate a reactor. That is the opposite job from zirconium cladding.", None),
        ("Very hard materials", "Hafnium carbide is among the most heat-resistant materials known. It is studied for surfaces that must survive extreme temperature.", None),
        ("Separated on purpose", "Hafnium has to be removed from the zirconium used in fuel cladding. The two metals are chemical twins with opposite nuclear jobs.", None),
    ],
    73: [
        ("Phone capacitors", "A tiny tantalum capacitor stores charge in phones and computers. The insulator is a thin layer of tantalum oxide on tantalum powder.", None),
        ("Surgery", "Tantalum is used in some implants and skull plates because the body tolerates the metal and it does not corrode.", None),
        ("Acid plants", "Tantalum equipment survives hot acids that would destroy steel. The metal is reserved for those harsh jobs.", None),
    ],
    74: [
        ("Light-bulb filaments", "The wire in an old incandescent bulb is tungsten. It can be white-hot without melting.", "bulb"),
        ("Cutting tools", "Tungsten carbide is the hard tip on drill bits and lathe tools. It is a compound, much harder than the pure metal.", None),
        ("The highest melting point", "Among the metals, tungsten melts at the highest temperature. That is why it survives where other wires would fail.", None),
    ],
    75: [
        ("Jet engines", "A few percent of rhenium in a turbine-blade alloy lets the blade stay strong at a higher temperature. Hotter engines use less fuel.", "aircraft"),
        ("Catalysts", "Rhenium catalysts help turn crude oil into high-octane fuel. The metal is recovered and reused because it is so scarce.", None),
        ("A rare stable metal", "Rhenium was one of the last stable elements discovered. There is very little of it in the crust, so every use is a thin addition, not a solid part.", None),
    ],
    76: [
        ("Pen tips and contacts", "A hard osmium alloy has been used for fountain-pen tips and for electrical contacts that must not wear away.", None),
        ("The densest stable element", "Osmium is the densest stable element, about twice as dense as lead. A small piece feels startlingly heavy.", None),
        ("A dangerous oxide", "Osmium tetroxide is used, carefully, to stain samples for electron microscopes. The vapor is toxic, and the compound is not a curiosity.", None),
    ],
    77: [
        ("Spark plugs", "The tip of a long-life spark plug may be a tiny amount of iridium. The metal resists the spark and the heat.", None),
        ("Crucibles", "Iridium crucibles survive chemical reactions that eat through platinum. Laboratories use them for those few jobs.", None),
        ("A clue in the rocks", "A thin layer of iridium-rich clay marks the time an asteroid struck Earth at the end of the age of dinosaurs. The metal is rare in the crust and more common in meteorites.", None),
    ],
    78: [
        ("Catalytic converters", "Platinum helps oxidize carbon monoxide and leftover fuel in a car's exhaust. Jewelry is the famous use. The converter is the larger one.", None),
        ("Jewelry", "Platinum stays bright and does not tarnish, so it is a jewelry metal. It is denser and usually more expensive than gold.", None),
        ("A cancer medicine", "Cisplatin, a platinum compound, is a chemotherapy drug. It is a specific molecule given by a doctor, not platinum metal.", None),
    ],
    79: [
        ("Jewelry and coins", "Gold stays yellow and shiny in air and water, which is why it has been jewelry and money for thousands of years.", "gold"),
        ("Electronics", "A thin coat of gold on a connector resists corrosion, so a computer contact still works years later.", None),
        ("Not just decoration", "Gold is also an excellent reflector of infrared light and a reliable conductor. The softness that makes it easy to shape is the same softness that makes a pure coin wear away.", None),
    ],
    80: [
        ("Old thermometers", "Mercury's even expansion made it the liquid in many thermometers. Those thermometers are being retired because the vapor is poisonous.", "mercury"),
        ("Old switches and lamps", "A tilt switch could use a drop of mercury to close a circuit, and fluorescent lamps contain a small amount of mercury vapor. Broken lamps are a disposal problem.", None),
        ("Amalgams", "Mercury dissolves some other metals to make an amalgam. Dental amalgam is a historical filling material that dentistry has been moving away from.", None),
    ],
    81: [
        ("Electronics, limited", "A little thallium has been used in some specialty electronics and in infrared optics. The amounts are controlled because the element is very toxic.", None),
        ("Old poisons, withdrawn", "Thallium salts were once rodenticides. That use was stopped after people were poisoned. There is no safe home use.", None),
        ("A medical isotope", "A radioactive thallium isotope has been used in heart imaging. The dose is a medical decision, and the metal is not a reagent to keep.", None),
    ],
    82: [
        ("Car batteries", "A lead-acid battery, the kind that starts a car, uses lead plates and a lead compound in sulfuric acid. The case stays sealed.", None),
        ("Radiation shields", "Lead is dense enough that a sheet of it stops X-rays. Aprons in a radiology room and the walls of some labs use that density.", None),
        ("Taken out of daily life", "Lead pigment in house paint and tetraethyllead in gasoline were banned because lead harms the nervous system, especially in children. Old paint is still a reason to be careful when renovating.", None),
    ],
    83: [
        ("Stomach medicine", "Bismuth subsalicylate is the active ingredient in some upset-stomach medicines. It is a compound, taken as directed, not a chunk of metal.", None),
        ("Low-melting alloys", "Bismuth alloys can melt in hot water. They are used in fire-sprinkler links and in metal casts that must not get extremely hot.", None),
        ("A pretty crystal", "Bismuth crystals grow in stair steps and flash rainbow colors from a thin oxide film. The color is that film, like a soap bubble.", None),
    ],
    84: [
        ("No everyday product", "Polonium is too radioactive for any ordinary material. There is no polonium pan, pigment, or school sample.", None),
        ("A historical static eliminator", "A few industrial devices once used a sealed polonium source to neutralize static charge. Those sources are regulated and are not a consumer part.", None),
        ("A decay product", "Polonium forms in uranium ores as the ore decays. The amount in the rock is tiny, and separating it was the Curies' work.", "uranium"),
    ],
    85: [
        ("No bulk use", "Astatine has never been gathered into a visible piece. There is no product, pigment, or medicine made from a bottle of it.", None),
        ("Tracer studies", "What chemists know comes from following a few radioactive atoms. That is research, not a use in the ordinary sense.", None),
        ("A halogen on paper", "On the table, astatine sits under iodine. Any guess about its color or its chemistry is an inference from that place.", None),
    ],
    86: [
        ("A gas to vent, not to use", "Radon seeping into a house is a health risk, not a resource. The practical response is to test and, if needed, to vent the foundation.", None),
        ("How it gets indoors", "Uranium and thorium in soil decay through a chain that includes radon. The gas can move through cracks that a liquid or a dust cannot.", None),
        ("Old medical uses, abandoned", "Radon was once sealed into small tubes for medical treatments. That practice belongs to the history of radiation, not to a current household product.", None),
    ],
    87: [
        ("No product", "Francium decays so quickly that there is never enough of it to make an object. It has no use as a material.", None),
        ("Research atoms", "Physicists study a few francium atoms when they want the heaviest alkali metal. The sample is a beam or a trap, not a bottle.", None),
        ("What the column predicts", "If it could be collected, francium would behave like cesium: one outer electron, and a violent reaction with water. The atoms do not last long enough to test that in bulk.", None),
    ],
    88: [
        ("A use that was stopped", "Radium paint made watch dials glow. The workers who painted it were harmed, and the use was abandoned. Old dials are a disposal problem, not a collectible to scrape.", None),
        ("Why it was dangerous", "Radium behaves a little like calcium, so the body can deposit it in bone. The glow was never worth that.", None),
        ("Research sources", "Sealed radium sources still exist in some legacy medical and industrial equipment. They are regulated radioactive objects.", None),
    ],
    89: [
        ("Research", "Actinium is scarce and radioactive. The work done with it is research, including studies of how such a heavy atom behaves in solution.", None),
        ("A parent of a decay series", "One natural radioactive series is named for actinium because the chain passes through it on the way from uranium to lead.", "uranium"),
        ("No consumer product", "There is no actinium alloy in a device you can buy. Samples large enough to see are a radiological project.", None),
    ],
    90: [
        ("Old lantern mantles", "Gas-lantern mantles once glowed because they were made of thorium oxide. That use has been dropped because the ash is radioactive.", None),
        ("A possible nuclear fuel", "Thorium-232 can be converted in a reactor into uranium-233, which can split. A few reactor designs are built around that idea.", None),
        ("Welding electrodes", "Some welding rods used thorium oxide to help the arc start. Many shops have switched to electrodes that are not radioactive.", None),
    ],
    91: [
        ("No household use", "Protactinium is too scarce and too radioactive for a product. A ton of uranium ore holds only a fraction of a gram.", "uranium"),
        ("Part of the uranium chain", "Protactinium-231 is a decay product of uranium-235. That is why it exists in the ore at all.", None),
        ("Research chemistry", "The chemistry that has been studied is mostly the +5 oxidation state, compared with niobium and tantalum. It is a specialist subject.", None),
    ],
    92: [
        ("Reactor fuel", "Nuclear reactors use uranium, usually enriched so there is more of the isotope that can split. The fuel is a ceramic pellet, handled under strict rules.", "uranium"),
        ("A long-lived isotope", "Most natural uranium is uranium-238, which is only weakly radioactive. The energy comes from the much smaller share of uranium-235.", None),
        ("Historical glass", "Uranium compounds once colored glass yellow-green. That glass is a collector's item and is mildly radioactive. It is not a craft glaze to revive.", None),
    ],
    93: [
        ("A product of reactors", "Neptunium is made when uranium captures neutrons. It is part of the material a reactor creates, not an ore that is mined for sale.", None),
        ("Research", "Chemists study neptunium because it is the first element beyond uranium and it has several oxidation states. The work is done in specialized labs.", None),
        ("No consumer metal", "There is no neptunium tool or alloy on the market. The element is a nuclear-material question first.", None),
    ],
    94: [
        ("Reactor fuel", "Some reactors run on a mix that includes plutonium recovered from used fuel. The handling is a national-laboratory and industry task.", None),
        ("Weapons, a fact to state plainly", "Plutonium-239 can split in a chain reaction, and it has been used in nuclear weapons. That is why the metal is guarded. It is not a teaching sample.", None),
        ("Made from uranium", "Plutonium is produced by neutron capture in uranium-238, followed by two decays. It is manufactured in a reactor, not dug out of a plutonium mine.", "uranium"),
    ],
    95: [
        ("Smoke detectors", "Many household smoke detectors contain a tiny sealed source of americium-241. The alpha particles ionize air, and smoke changes the current. The source stays inside the detector.", None),
        ("Do not open one", "Prying the source out, or throwing a detector in a fire, spreads a radioactive material. Detectors are returned or recycled, not broken apart.", None),
        ("Made from plutonium", "Americium is produced by irradiating plutonium. The smoke-detector isotope is a managed byproduct, not a mineral.", None),
    ],
    96: [
        ("Targets for heavier elements", "Curium is bombarded to make still heavier actinides. A target is a use, and it is not a product you can buy.", None),
        ("Power for instruments", "A few isotopes of curium have powered specialized instruments where a battery would not last. The source is sealed and radioactive.", None),
        ("Named for the Curies", "The name honors Marie and Pierre Curie. The element is synthetic and is handled as a strong alpha emitter.", None),
    ],
    97: [
        ("A target", "Berkelium has been made into a target and bombarded with calcium to produce tennessine. That campaign is the public use.", None),
        ("Research quantities", "The amounts are milligrams or less, and the isotope decays while the experiment is planned. There is no stockpile on a shelf.", None),
        ("No commercial product", "Berkelium is not in an alloy, a detector, or a medicine. It exists so heavier atoms, and its own chemistry, can be studied.", None),
    ],
    98: [
        ("A neutron source", "Californium-252 splits on its own and releases neutrons. A tiny sealed source is used in research and in some mining and medical instruments.", None),
        ("Made in a reactor", "Californium is built up by a long chain of neutron captures, starting from plutonium or curium. Only specialized reactors make it.", None),
        ("Micrograms matter", "A microgram of the neutron-emitting isotope is already an intense source. That is why the element is valuable and why it is not a sample to display.", None),
    ],
    99: [
        ("Research only", "Einsteinium is produced in microgram amounts for chemical studies. There is no device in a home or a car that contains it.", None),
        ("Found in bomb debris", "The element was first identified in the fallout of a thermonuclear test. Modern samples are made in reactors instead.", None),
        ("A limit on experiments", "The sample heats itself and decays while it is being studied. Measurements are planned around that, which is part of why so little chemistry is published.", None),
    ],
    100: [
        ("Research only", "Fermium is studied in very small amounts, and there is no fermium product to buy or to hold.", None),
        ("The end of reactor synthesis", "Fermium is about as far as neutron capture in a reactor can go and still leave a chemist something to track. Heavier elements need an accelerator.", None),
        ("Found with einsteinium", "Fermium was in the same test debris as einsteinium. The name honors Enrico Fermi.", None),
    ],
    101: [
        ("One atom at a time", "Mendelevium was identified from a handful of atoms. That method, not a material use, is why it matters in the history of the table.", None),
        ("Named for Mendeleev", "The name honors the chemist who arranged the elements by their properties. Element 101 is a late confirmation of that idea.", None),
        ("No weighable sample", "Chemistry is done by watching where single atoms come off an ion-exchange column. There is nothing to machine or to sell.", None),
    ],
    102: [
        ("Accelerator-made", "Nobelium is made by crashing lighter nuclei together. The atoms are studied and are gone. There is no nobelium part.", None),
        ("A chemical surprise", "In solution, nobelium prefers a +2 ion, more like ytterbium than like the actinides before it. That is a research result, not a product.", None),
        ("A long argument about the name", "Proving a few atoms exist is hard, and the name took years to settle. The element is still known only at that scale.", None),
    ],
    103: [
        ("The end of the actinides", "Lawrencium closes the bottom row of the table. It is made a few atoms at a time and has no material use.", None),
        ("Named for a machine", "The name honors Ernest Lawrence, whose cyclotron is the ancestor of the accelerators that make these elements.", None),
        ("A configuration question", "Researchers still discuss exactly which orbitals the last electrons occupy. That is a spectroscopy problem, not an application.", None),
    ],
    104: [
        ("Atom-at-a-time chemistry", "Rutherfordium is used only to test whether a transactinide really behaves like the metal above it, hafnium. The experiment uses single atoms.", None),
        ("No material", "There is no rutherfordium alloy, crucible, or sample jar. The atoms decay in seconds or less.", None),
        ("The first past the actinides", "Element 104 is the start of a new row of the middle block. Its existence is the use, in the sense that it extends the table.", None),
    ],
    105: [
        ("Compared with tantalum", "Dubnium chemistry, what little has been done, asks whether the atoms follow tantalum. That comparison is the work.", None),
        ("Made in a fusion reaction", "Dubnium is produced by crashing a lighter nucleus into a heavier one. A few atoms are the whole product.", None),
        ("No object you can hold", "Half-lives are too short for a melting point, a density, or a machine part. The element is a decay chain with a name.", None),
    ],
    106: [
        ("A group-6 test", "Seaborgium experiments look for the high oxidation states tungsten is known for. Finding them supports the place of element 106 on the table.", None),
        ("Named for Seaborg", "The name honors Glenn Seaborg, who proposed that the actinides form their own row. The element itself is not a material.", None),
        ("Seconds, not samples", "The atoms are gone almost as soon as they are made. Gas-phase molecules are detected. Nothing is bottled.", None),
    ],
    107: [
        ("A volatile oxide", "Researchers have looked for a bohrium oxide that behaves like the volatile oxide of rhenium. A few molecules are the evidence.", None),
        ("Named for Bohr", "The name honors Niels Bohr, whose model of the atom started with hydrogen. Element 107 is studied one atom at a time.", None),
        ("No bulk property", "There is no measured density or melting point. The periodic table predicts a heavier rhenium, and the experiments are beginning to check that.", None),
    ],
    108: [
        ("A detected oxide", "Hassium tetroxide has been detected, one molecule at a time, by analogy with osmium tetroxide. That is the chemical result.", None),
        ("Made in Hesse", "The element was produced at Darmstadt and named for the state of Hesse. The atoms last seconds.", None),
        ("Not a metal sample", "No one has a speck of hassium metal. The oxide experiment is done on atoms flying through a chromatography column.", None),
    ],
    109: [
        ("Identification only", "Meitnerium is known from its nuclear decay. Chemical experiments have not been practical, because the atoms do not last.", None),
        ("Named for Meitner", "The name honors Lise Meitner, who explained nuclear fission. The element is not a fission fuel and has no application.", None),
        ("Under iridium", "On the table, meitnerium sits under iridium. That is a prediction of its chemistry, not a measurement.", None),
    ],
    110: [
        ("Milliseconds", "Darmstadtium atoms last milliseconds. They are identified by the particles they emit as they decay.", None),
        ("Named for the city", "The laboratory that made the element is in Darmstadt, and the element carries the city's name.", None),
        ("A platinum analog, on paper", "Group 10 suggests a heavier platinum. No chemical test has confirmed or denied that. There is no use as a metal.", None),
    ],
    111: [
        ("A few atoms", "Roentgenium is produced a few atoms at a time and identified by its decay chain. There is no sample to machine or to plate onto a contact.", None),
        ("Named for Röntgen", "The name honors Wilhelm Röntgen, the discoverer of X-rays. The element is not an X-ray source.", None),
        ("A prediction about gold", "Calculations say relativity may change roentgenium's chemistry relative to gold. The prediction is waiting on an experiment that the lifetime barely allows.", None),
    ],
    112: [
        ("A volatile atom", "Single copernicium atoms have been studied to see whether they stick to a gold surface or fly on like a gas. They behave more like a volatile metal.", None),
        ("Under mercury", "Copernicium sits under mercury, the metal that is already a liquid. The experiments ask whether element 112 is even less metallic.", None),
        ("Named for Copernicus", "The name honors Copernicus. There is no copernicium device. The result is a place on the table plus a hint about the atom.", None),
    ],
    113: [
        ("Made in Japan", "One of the teams that made nihonium worked in Japan, and the element is named for that. The product was a few atoms.", None),
        ("The start of a new block", "Nihonium is the first superheavy element of the p-block, under thallium. A +1 chemistry is the prediction.", None),
        ("No chemistry yet in a beaker", "The atoms decay in less than a second. No compound has been isolated. The use of the element is the knowledge that it exists.", None),
    ],
    114: [
        ("A longer-lived superheavy", "Flerovium is predicted to live longer than its neighbors, and some isotopes last a fraction of a second. That is long enough for a cautious chemical test.", None),
        ("Does it behave like lead", "Adsorption experiments ask whether a flerovium atom sticks to gold the way a metal would. The answer is subtle and still being argued.", None),
        ("Named for a laboratory", "The name honors the Flerov laboratory, where the element was made from plutonium and calcium. There is no flerovium material.", None),
    ],
    115: [
        ("Identified by its decays", "Moscovium is known because the atoms emit a characteristic chain of alpha particles ending at known nuclei. That chain is the evidence.", None),
        ("Under bismuth", "The table places moscovium under bismuth. No chemical experiment has been reported.", None),
        ("Named for Moscow", "The discovery collaboration named the element for the Moscow region. A few atoms were the whole discovery.", None),
    ],
    116: [
        ("Calcium on a heavy target", "Livermorium is made by firing calcium at curium. The method is the same family of reactions that built this part of the table.", None),
        ("Under polonium", "Livermorium sits under polonium, which is already highly radioactive. Element 116 is rarer and shorter-lived. It has no use as a substance.", None),
        ("Named for Livermore", "The name honors Livermore, California, a partner in the discovery. The result is a decay chain, not a sample.", None),
    ],
    117: [
        ("Made from berkelium", "Tennessine was produced by crashing calcium into a berkelium target. The target itself was a campaign, because berkelium decays.", None),
        ("A halogen, maybe", "Tennessine sits in the halogen column. Whether it still behaves as a halogen is a prediction. There is no vapor and no crystal.", None),
        ("Named for Tennessee", "The name honors the state of Tennessee, home of the laboratory that made the berkelium. Only a few atoms were detected.", None),
    ],
    118: [
        ("The end of the table", "Oganesson is the last element known today. It completes period 7, under the noble gases.", None),
        ("A few atoms", "It was made from californium and calcium, a few atoms at a time. They decay in less than a second. There is no cylinder of oganesson.", None),
        ("Maybe not a noble gas", "Calculations suggest oganesson may be more reactive than radon, and perhaps not a gas at all, if anyone could ever gather it. The measured fact is the decay chain. The chemistry is still a prediction.", None),
    ],
}
