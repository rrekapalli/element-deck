"""Uses for elements 1-60. Image keys are optional and must exist in use_images.SOURCES."""

USES: dict[int, list[tuple[str, str, str | None]]] = {
    1: [
        ("Water", "Hydrogen is one of the two elements in water. Two hydrogen atoms join one oxygen atom to make the liquid in rain, rivers, and every drink.", "water"),
        ("Stars", "The Sun is mostly hydrogen. Stars shine because hydrogen nuclei fuse into helium and release energy.", "sun"),
        ("Industry", "Factories combine hydrogen with nitrogen to make ammonia, the starting point for most fertilizer. Hydrogen is also added to oils, and it burns easily enough to be a fuel.", "ammonia"),
    ],
    2: [
        ("Balloons", "Helium is lighter than air and, unlike hydrogen, it does not burn. That is why party balloons and some scientific balloons are filled with it.", None),
        ("Keeping things cold", "Liquid helium is colder than any other liquid. MRI magnets and many physics experiments use it to stay near absolute zero.", None),
        ("Shielding gas", "Welders sometimes use helium around a hot weld so oxygen in the air cannot spoil the metal. The gas does the job by refusing to react.", None),
    ],
    3: [
        ("Batteries", "The rechargeable battery in a phone or a laptop moves lithium ions from one side to the other. That is the use most people meet, and the mining that supplies it is a real landscape.", "lithium"),
        ("Medicine", "A few medicines are lithium salts, prescribed and dosed by a doctor. That is a compound in a pill, not a piece of the metal.", None),
        ("Alloys", "Small amounts of lithium make some aluminum and magnesium alloys lighter and stiffer. The pure metal is stored away from air and water.", None),
    ],
    4: [
        ("Light alloys", "Beryllium is stiff and very light, so it goes into parts for spacecraft and into special alloys that must not sag.", "aircraft"),
        ("X-ray windows", "A thin beryllium window lets X-rays out of a tube while holding the vacuum in. The metal is transparent to those rays in a way glass is not.", None),
        ("A hazard to respect", "Beryllium dust and fumes can scar the lungs. The useful alloys are made in controlled shops, not sanded on a workbench at home.", None),
    ],
    5: [
        ("Heat-proof glass", "Borosilicate glass, the kind used in lab beakers and some bakeware, contains boron. It expands less when it is heated, so it is less likely to crack.", None),
        ("Detergents", "A boron compound called borax has been used in laundry powders and cleaning mixes. It is a salt of boron, not the hard element itself.", None),
        ("Plant nutrient", "Plants need a trace of boron. Too little shows up in the crop, and too much is harmful, so fertilizer formulas measure it carefully.", None),
    ],
    6: [
        ("Living things", "Proteins, fats, DNA, and sugars are built on chains and rings of carbon. No other element forms that variety of stable molecules.", None),
        ("Diamond and graphite", "Diamond is a hard form of carbon used to cut and to sparkle. Graphite is the soft form in pencil lead and in some lubricants.", "diamond"),
        ("Fuel and steel", "Coal, charcoal, and the carbon in oil are fuels and, in a blast furnace, the ingredient that pulls oxygen away from iron ore.", "graphite"),
    ],
    7: [
        ("The air", "About four fifths of dry air is nitrogen. You breathe it in and out all day, and it does not burn.", "earth"),
        ("Fertilizer", "Plants need nitrogen in a form they can use. Factories turn nitrogen from the air into ammonia and then into fertilizer.", "ammonia"),
        ("Proteins", "Every protein contains nitrogen, in the amino acids the protein is built from. That nitrogen started, ultimately, as gas in the air.", None),
    ],
    8: [
        ("Breathing", "The oxygen in air is what your cells use when they release energy from food. A fire uses the same gas when it burns.", "earth"),
        ("Water", "Water is hydrogen joined to oxygen. Most of the oxygen atoms on the surface of the Earth are locked in water and in rock, not free in the air.", "water"),
        ("Steelmaking", "A blast furnace uses oxygen-rich air to burn carbon and to help turn iron ore into iron. Hospitals also pipe pure oxygen to patients who need it.", None),
    ],
    9: [
        ("Toothpaste", "Fluoride in toothpaste is a compound of fluorine, not the pure gas. It helps tooth enamel resist acid.", "toothpaste"),
        ("A fierce reactant", "Fluorine gas reacts with almost everything, which is why it is used in industry to make non-stick coatings and special plastics, under strict controls.", None),
        ("Not a home chemical", "The pure element burns tissue and is not a demonstration reagent. The fluoride in a toothpaste tube is a different, much calmer substance.", None),
    ],
    10: [
        ("Signs", "A classic neon sign is a glass tube of neon with a current through it. The gas glows orange-red.", None),
        ("Other colors", "Many signs that people call neon are actually other gases or tinted glass. Pure neon is the orange-red one.", None),
        ("A cold liquid", "Liquid neon is an inert refrigerant, colder than liquid nitrogen and less expensive than liquid helium for some jobs.", None),
    ],
    11: [
        ("Table salt", "Table salt is sodium chloride. The sodium in it has already reacted and is part of a calm crystal, not the soft metal.", "halite"),
        ("Street lights and nerves", "Older yellow street lamps were sodium vapor. In the body, sodium ions help nerve cells send signals.", None),
        ("Industry", "Sodium hydroxide, made from salt, is used to make soap, paper, and many other chemicals. The pure metal is a starting point in some of those plants.", None),
    ],
    12: [
        ("Light metal", "Magnesium alloys are light and strong enough for luggage, car parts, and some aircraft pieces.", "aircraft"),
        ("Green leaves", "A magnesium atom sits at the center of chlorophyll, the molecule that makes leaves green and catches sunlight.", None),
        ("Flares", "Burning magnesium gives an intense white light, which is why it was used in flares and in old camera flash powder.", None),
    ],
    13: [
        ("Airplanes and cans", "Aluminum is light, and a clear oxide coat keeps it from rusting through. Aircraft skin, drink cans, and foil are the everyday forms.", "aircraft"),
        ("Power lines", "Aluminum conducts electricity well and is much lighter than copper, so many overhead power lines are aluminum.", None),
        ("The oxide coat", "The dull surface of a can is a thin, tight layer of aluminum oxide. That layer is why the metal survives rain.", None),
    ],
    14: [
        ("Computer chips", "Nearly every computer chip is a slice of silicon, altered in tiny regions so it can switch electrical signals.", "wafer"),
        ("Sand and glass", "Sand is mostly silicon dioxide, silicon joined to oxygen. Melted with other ingredients, that sand becomes the glass in windows and bottles.", "sand"),
        ("Solar cells", "A solar panel is also silicon, made so that sunlight knocks electrons loose and produces a current.", None),
    ],
    15: [
        ("Bones and DNA", "Bones contain calcium phosphate, and the backbone of DNA uses phosphate links. Both are phosphorus joined to oxygen.", None),
        ("Fertilizer", "Crops remove phosphorus from the soil, and fertilizer puts it back. The form plants use is phosphate, not the white element that catches fire.", None),
        ("Matches", "The striking surface of a safety match uses red phosphorus. White phosphorus, a different form, is dangerous and is not a household material.", None),
    ],
    16: [
        ("Sulfuric acid", "Most sulfur mined or recovered from fuels is burned and turned into sulfuric acid, one of the chemicals industry uses in the largest amounts.", "sulfur"),
        ("Proteins", "Some amino acids contain sulfur, and a link between two sulfur atoms helps many proteins hold their shape.", None),
        ("Rubber and matches", "Vulcanized rubber is heated with sulfur so it is tough rather than sticky. Sulfur is also part of the chemistry of matches and of black gunpowder.", None),
    ],
    17: [
        ("Drinking water", "A carefully controlled dose of chlorine, or of a chlorine compound, kills germs in drinking water and in swimming pools.", None),
        ("Table salt", "The chlorine in table salt is the chloride ion, paired with sodium. It is not the green gas.", "halite"),
        ("Plastics", "PVC, the plastic in some pipes and window frames, is made from a chlorine-containing building block. The pure gas is an industrial hazard, not a craft supply.", None),
    ],
    18: [
        ("Welding", "Argon is blown around a weld so the hot metal meets an inert gas instead of oxygen. The weld stays clean.", None),
        ("Light bulbs", "Some bulbs are filled with argon so the hot filament lasts longer than it would in air.", "bulb"),
        ("Dating rocks", "A little of the potassium in a mineral slowly becomes argon. Measuring that argon tells geologists how long the rock has been solid.", None),
    ],
    19: [
        ("Nerves and food", "Potassium ions inside your cells help nerves and muscles work. Fruits and vegetables are the ordinary way people meet it.", None),
        ("Fertilizer", "Potash fertilizer supplies potassium that crops take out of the soil. It is a potassium salt, not the metal.", None),
        ("The metal itself", "Pure potassium reacts violently with water and is kept under oil. It is a laboratory and industrial chemical, not a supplement.", None),
    ],
    20: [
        ("Bones and teeth", "Bone and tooth mineral are calcium compounds. Dairy foods and many greens are the usual sources in a diet.", None),
        ("Cement and lime", "Cement, mortar, and agricultural lime are calcium compounds made from limestone. They are among the most-used materials on Earth.", None),
        ("Hard water", "The scale in a kettle is mostly calcium carbonate left behind when hard water boils. A water softener trades those calcium ions for sodium.", None),
    ],
    21: [
        ("Aluminum alloys", "A little scandium makes some aluminum alloys stronger without making them much heavier. Aerospace and sports equipment have used those alloys.", "aircraft"),
        ("Lighting", "Scandium iodide in some metal-halide lamps helps the light look more like daylight.", None),
        ("Not a hardware-store metal", "Scandium is uncommon and is sold to alloy makers, not as a bar for a workshop. The interesting chemistry is the steady +3 ion.", None),
    ],
    22: [
        ("Aircraft", "Titanium is as strong as many steels and much lighter, and it resists seawater. Airframes and engine parts use it.", "aircraft"),
        ("White paint", "The white in a lot of paint, plastic, and toothpaste is titanium dioxide, a powder, not the metal.", "toothpaste"),
        ("Implants", "Hip joints and bone screws are sometimes titanium because the body tolerates the metal and the oxide on its surface.", None),
    ],
    23: [
        ("Tough steel", "A small amount of vanadium in steel makes the steel finer-grained and tougher. Tools and springs use that alloy.", None),
        ("Sulfuric acid plants", "Vanadium pentoxide is the catalyst that helps turn sulfur dioxide into sulfur trioxide on the way to sulfuric acid.", None),
        ("Colorful ions", "Vanadium compounds can be purple, green, blue, or yellow depending on the oxidation state. That is a teaching exhibit more than a product.", None),
    ],
    24: [
        ("Stainless steel", "Stainless steel stays bright because a little chromium forms a thin, tight oxide that keeps rust from starting.", None),
        ("Chrome plate", "A thin coat of chromium on another metal is the shiny finish on some taps and trim. The coat is hard and resists tarnish.", None),
        ("Colored compounds", "Chromium pigments have been yellow, orange, and green. The ones that contain chromium in the +6 state are toxic, which is why many have been phased out.", None),
    ],
    25: [
        ("Steel", "Manganese is added to almost all steel, to make it tougher and to keep sulfur from making the metal brittle.", "iron"),
        ("Batteries", "The black paste in an ordinary dry-cell battery is manganese dioxide. It accepts electrons as the battery runs.", None),
        ("A purple oxidizer", "Dissolved potassium permanganate is an intense purple solution used as an oxidizer in labs and, carefully, in water treatment.", None),
    ],
    26: [
        ("Steel and structures", "Iron, turned into steel, is the metal of bridges, rails, reinforcing bars, and car bodies. The ore is mined in huge amounts.", "iron"),
        ("Blood", "Hemoglobin uses a little iron to carry oxygen in red blood cells. That is a trace of iron in a protein, not a piece of metal.", None),
        ("Magnets", "Iron is the familiar magnetic metal. Motors, transformers, and refrigerator magnets depend on that property, often as an alloy.", None),
    ],
    27: [
        ("Magnets and alloys", "Cobalt goes into strong permanent magnets and into alloys that stay hard when they are hot, including some cutting tools.", None),
        ("Blue glass", "A little cobalt compound gives glass and glaze a deep blue. The color has been used for centuries.", None),
        ("Vitamin B12", "Vitamin B12 holds one cobalt atom in a large molecule. People need a trace of that vitamin, which is not the same as needing the metal.", None),
    ],
    28: [
        ("Stainless steel and coins", "Nickel toughens stainless steel and has given its name to a coin. The coin is an alloy, not pure nickel.", None),
        ("Batteries", "Nickel appears in several rechargeable batteries, paired with other metals. The electrode is a compound or an alloy, not a bare lump.", None),
        ("A catalyst", "Finely divided nickel helps add hydrogen to oils, the step that makes some margarines and industrial chemicals. The powder is a factory material.", None),
    ],
    29: [
        ("Wires", "Copper is the usual metal in electrical wiring because it conducts so well and can be drawn into wire.", "copper"),
        ("Plumbing and roofs", "Copper pipe carries water, and copper roofs last for decades under a green coat that protects the metal.", None),
        ("Alloys", "Brass is copper with zinc, and bronze is copper with tin. Both were useful long before anyone explained why copper conducts.", None),
    ],
    30: [
        ("Galvanizing", "A coat of zinc on a steel nail or a roof sheet rusts first, on purpose, and the steel underneath lasts much longer.", None),
        ("Brass", "Brass is zinc mixed with copper. Door hardware, instruments, and fittings use it because it is harder than copper and resists corrosion.", "copper"),
        ("The body", "A number of enzymes need a zinc ion to work. The amount in food is tiny compared with the zinc on a galvanized bucket.", None),
    ],
    31: [
        ("LEDs and chips", "Gallium nitride and gallium arsenide are the materials in many LEDs and in some fast electronics. The pure metal is not what you see glowing.", None),
        ("A metal that melts easily", "Gallium melts just above room temperature, so a warm hand can liquefy a piece. That is a real property and a poor party trick with an unlabelled sample.", None),
        ("Thermometers", "Some high-temperature thermometers have used a gallium alloy instead of mercury. The alloy is chosen to be liquid, and it is still not a toy.", None),
    ],
    32: [
        ("Fiber optics", "A little germanium in the glass of a fiber changes how the fiber bends light, which helps carry a signal.", None),
        ("Electronics", "Germanium was an early transistor material and is still used in some infrared optics and detectors.", None),
        ("A predicted element", "Mendeleev left a gap under silicon and described the missing element before it was found. Germanium filled that gap.", None),
    ],
    33: [
        ("Semiconductors", "Gallium arsenide, used in some LEDs and high-speed electronics, contains arsenic. The work is done in sealed industrial processes.", None),
        ("Old pigments, a warning", "Some historical greens contained arsenic compounds and were poisonous. They are a reason to treat old paint with care, not a recipe.", None),
        ("Wood treatment, now restricted", "Arsenic compounds once preserved outdoor wood. Many countries have limited that use because the element is toxic.", None),
    ],
    34: [
        ("Glass and photocopiers", "Selenium colors some glass red, and the gray form was used in early photocopiers because light changed how well it conducted.", None),
        ("A trace nutrient", "A few enzymes in the body use selenium. The useful amount is tiny, and extra selenium is harmful.", None),
        ("Alloys", "A little selenium improves the machining of some steels and brasses. It is added at the mill, not in a home shop.", None),
    ],
    35: [
        ("Flame retardants", "Some plastics contain bromine compounds that slow a fire. The use is industrial, and several of those compounds have been restricted.", None),
        ("Water treatment", "Bromine compounds disinfect some pools and industrial water. The red liquid element itself is not poured into a pool.", None),
        ("The liquid halogen", "Bromine is one of the only elements that is liquid in a normal room, and the vapor is choking. It is a fume-hood chemical.", None),
    ],
    36: [
        ("Bright lamps", "Krypton fills some high-performance lamps and flashes. The light is bright and white compared with neon's orange-red.", "bulb"),
        ("Windows", "Double glazing is sometimes filled with krypton because the heavy gas slows heat leaking through the window.", None),
        ("A rare gas", "Krypton is a tiny fraction of air. Pulling it out is a job for an air-separation plant, not a classroom.", None),
    ],
    37: [
        ("Atomic clocks and sensors", "Rubidium atoms are used in some compact atomic clocks and in light sensors. The device uses the atom's outer electron, not a lump of metal.", None),
        ("Research", "Physicists cool rubidium atoms when they study matter at extremely low temperatures. The metal is sealed because it reacts violently with water.", None),
        ("Not a household metal", "There is no rubidium pan and no rubidium supplement worth taking. The pure metal is a specialty chemical.", None),
    ],
    38: [
        ("Red fireworks", "Strontium compounds give fireworks and flares a crimson color. The color is the public use of an otherwise quiet metal.", "fireworks"),
        ("Magnets and glass", "Strontium ferrite is a common permanent-magnet material, and strontium compounds are used in some picture-tube and ceramic glass.", None),
        ("A caution about one isotope", "Strontium-90, made in nuclear fission, can be taken up by bone because it resembles calcium. That isotope is a hazard, not a firework ingredient.", None),
    ],
    39: [
        ("Lasers and phosphors", "Yttrium aluminum garnet is a host crystal for many lasers, and yttrium phosphors help some lamps and screens glow.", None),
        ("Alloys", "Small amounts of yttrium strengthen some aluminum and magnesium alloys used where the metal must stay light.", "aircraft"),
        ("With the rare earths", "Yttrium is separated from the same ores as the lanthanides, because its chemistry matches theirs. The metal is a specialty product.", None),
    ],
    40: [
        ("Nuclear reactors", "Fuel rods in many reactors are clad in a zirconium alloy, because the metal resists hot water and does not steal many neutrons.", None),
        ("Ceramics", "Zirconium dioxide is a hard ceramic used in knives, dental crowns, and fake diamonds.", None),
        ("Separated from hafnium", "Reactor zirconium has to be freed of hafnium, which would absorb the neutrons the cladding is meant to ignore.", None),
    ],
    41: [
        ("Superconducting magnets", "The wire in many MRI and accelerator magnets is a niobium alloy that carries current with no resistance when it is kept very cold.", "mri"),
        ("Steel", "A little niobium in steel makes the grains smaller and the steel stronger. Pipelines use that alloy.", None),
        ("A high melting point", "Niobium stays strong when it is hot, so it also appears in rocket nozzles and in chemical equipment that must resist acid.", None),
    ],
    42: [
        ("Steel", "Molybdenum makes steel hard and strong at high temperature. Drill steel and pressure vessels often contain it.", None),
        ("A dry lubricant", "Molybdenum disulfide is a soft gray powder that lets metal parts slide. It is a compound, layered like graphite.", None),
        ("Enzymes", "The enzyme that lets some bacteria use nitrogen from the air contains molybdenum. Animals need a trace of the element for other enzymes.", None),
    ],
    43: [
        ("Medical images", "A short-lived form of technetium is the most-used tracer in nuclear medicine. A scanner follows where it goes in the body, and then the radioactivity fades.", None),
        ("No stable form", "Technetium has no stable isotope, so there is no technetium ore to mine. It is made from molybdenum in a generator at the hospital's supplier.", None),
        ("A made element", "Technetium was the first element produced artificially. That history is why the box on the table was empty for so long.", None),
    ],
    44: [
        ("Electronics", "A thin layer of ruthenium is used in some resistors and hard-disk coatings. The amount in any one device is tiny.", None),
        ("Catalysts", "Ruthenium compounds and surfaces help a number of chemical reactions, including some routes to ammonia and to specialty chemicals.", "ammonia"),
        ("Hardening platinum", "A little ruthenium makes platinum and palladium alloys harder. Electrical contacts use that hardness.", None),
    ],
    45: [
        ("Catalytic converters", "Rhodium in a car's converter helps turn nitrogen oxides in the exhaust into nitrogen gas. A thin coat does the work.", None),
        ("A bright plate", "Rhodium plating is a hard, silvery finish on some jewelry and on optical mirrors. It does not tarnish.", None),
        ("A scarce metal", "Rhodium is one of the rarest and most expensive metals in use. The converter holds milligrams, not a bar.", None),
    ],
    46: [
        ("Catalytic converters", "Palladium, like platinum, oxidizes leftover fuel and carbon monoxide in exhaust. Many converters now use more palladium than platinum.", None),
        ("Jewelry", "Palladium is a white jewelry metal that stays bright and is lighter than platinum.", None),
        ("Hydrogen", "Palladium metal can absorb a very large volume of hydrogen. That property is used in some purifiers and is a classic teaching demonstration of a metal hydride.", None),
    ],
    47: [
        ("Jewelry and coins", "Silver has been jewelry and money for thousands of years. It stays bright until sulfur in the air darkens the surface.", None),
        ("The best conductor", "Silver conducts electricity better than any other element. Some high-end electrical contacts use it where copper is not quite enough.", "copper"),
        ("Old photographs", "Black-and-white film was a silver-salt process. Light reduced the salt to tiny grains of silver metal, and those grains made the dark parts of the picture.", None),
    ],
    48: [
        ("Older batteries", "Nickel-cadmium rechargeable batteries used cadmium in one electrode. Many countries have restricted them because cadmium is toxic.", None),
        ("Coatings, now limited", "Cadmium was plated onto steel to stop rust, and cadmium sulfide was a bright yellow pigment. Both uses have been cut back.", None),
        ("A metal to treat carefully", "Cadmium accumulates in the body. There is no hobby use that justifies heating or sanding it.", None),
    ],
    49: [
        ("Touch screens", "The clear layer that conducts electricity on many screens is indium tin oxide. It lets light through and still carries a current.", None),
        ("Solder", "Indium alloys melt at low temperatures, so they can solder parts that must not get hot.", None),
        ("A soft metal", "Pure indium is soft enough to cut with a knife and squeaks when it is bent. Those are curiosities. The industrial use is the thin oxide film.", None),
    ],
    50: [
        ("Solder and cans", "Solder is often a tin alloy that melts easily and joins wires. A tin can is steel with a thin coat of tin so the food does not taste of iron.", None),
        ("Bronze", "Bronze is copper with tin, hard enough for bells, bearings, and historical tools.", "copper"),
        ("A coat, not the can", "The metal you think of as tin is usually a coating or an alloy. The pure element has a gray form that can crumble in severe, prolonged cold.", None),
    ],
    51: [
        ("Flame retardants", "Antimony oxide is combined with some halogenated plastics so the plastic resists catching fire. The use is in the factory formulation.", None),
        ("Alloys", "Antimony hardens lead in some older batteries and type metal. The element itself is brittle.", None),
        ("An old pigment", "Stibnite, an antimony sulfide, was ground as a black cosmetic in the ancient world. Modern compounds are handled as industrial chemicals, several of them toxic.", None),
    ],
    52: [
        ("Solar cells", "Some thin-film solar panels use cadmium telluride. Tellurium is the scarce ingredient in that compound.", None),
        ("Steel and copper", "A little tellurium makes some steels and coppers easier to machine. The addition is small and is done at the mill.", "copper"),
        ("A rare element", "Tellurium is uncommon in the crust and is mostly recovered as a byproduct of copper refining. It is not a shop metal.", None),
    ],
    53: [
        ("The thyroid", "Thyroid hormone contains iodine, and iodized salt is how many people get enough. The amount in the salt is a compound, measured in micrograms.", "halite"),
        ("Antiseptic", "Iodine solutions and iodine complexes have been painted on skin as antiseptics. The dark crystals themselves stain and are not a first-aid toy.", None),
        ("A violet vapor", "Warm iodine crystals give off a violet gas. That vapor, and the blue-black color iodine makes with starch, are the classroom observations.", None),
    ],
    54: [
        ("Bright lamps", "Xenon arc lamps are the intense white source in some cinema projectors, car headlights, and scientific instruments.", "bulb"),
        ("Ion thrusters", "Some spacecraft push themselves by accelerating xenon ions. The gas is heavy and unreactive, which suits an engine that runs for months.", None),
        ("A few real compounds", "Xenon fluorides are genuine compounds of a noble gas. They are reactive laboratory chemicals, not the filling of the lamp.", None),
    ],
    55: [
        ("Atomic clocks", "The second is defined by a property of cesium atoms. Cesium clocks are the reference other clocks are checked against.", None),
        ("A metal that melts easily", "Cesium melts on a warm day and reacts violently with water. It is sealed in the devices that use it.", None),
        ("Drilling fluids", "A cesium salt solution is dense enough to be used as a specialty drilling fluid in some oil wells. The salt is not the free metal.", None),
    ],
    56: [
        ("Green fireworks", "Barium compounds give fireworks a green color. The pure metal is not what is packed in the shell.", "fireworks"),
        ("Medical images", "A suspension of barium sulfate is swallowed so an X-ray can outline the stomach. That particular compound does not dissolve. Other barium salts are poisonous.", None),
        ("Drilling mud", "Barium sulfate is also the dense mineral added to drilling mud so the fluid can hold back pressure in a well.", None),
    ],
    57: [
        ("Camera lenses", "Lanthanum oxide raises the refractive index of some optical glass, so a lens can bend light more in a thinner piece.", None),
        ("Catalysts", "Lanthanum compounds are part of the catalysts in oil refining and in some catalytic converters.", None),
        ("Lighter flints", "The sparking flint in many lighters is a mix of rare-earth metals rich in cerium and lanthanum, alloyed with iron.", None),
    ],
    58: [
        ("Catalytic converters", "Cerium oxide stores oxygen and gives it back as a car's exhaust changes. That keeps the converter working.", None),
        ("Lighter flints", "The sparks from a lighter flint are burning bits of a cerium-iron alloy. The metal is pyrophoric when it is finely divided.", None),
        ("Glass polishing", "Cerium oxide powder polishes glass, from telescope mirrors to the screens of phones. The powder is a compound, not a lump of the metal.", None),
    ],
    59: [
        ("Magnets", "Praseodymium is paired with neodymium in many strong magnets. The two metals are neighbors and are often used together.", None),
        ("Glassblowers' goggles", "Didymium glass, which contains praseodymium, blocks the yellow glare of hot glass so the worker can see the piece.", None),
        ("A green salt", "Praseodymium compounds are green, which is what the name records. The color is the salt, not the silvery metal.", None),
    ],
    60: [
        ("Strong magnets", "The magnets in headphones, hard drives, and many wind turbines are a neodymium-iron-boron alloy. They are strong enough to be dangerous if two of them snap together.", None),
        ("Lasers", "Neodymium in a crystal is the heart of a common infrared laser, used in industry and in some medical tools.", None),
        ("Colored glass", "Neodymium glass absorbs yellow light and is used in some welding goggles and in decorative glass that looks different under different lamps.", None),
    ],
}
