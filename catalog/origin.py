"""How each element is thought to have been assembled before the Earth existed."""

from __future__ import annotations

# Two short paragraphs: the nuclear channel, then the isotope the reader actually meets.
COSMIC_ORIGIN: dict[int, str] = {
    1: (
        "Almost every hydrogen nucleus was made in the first few minutes of the Universe, once it had cooled enough for protons and neutrons to stick and before it cooled too far for them to fuse. "
        "The common isotope, protium, is that leftover proton. Deuterium was made in the same brief window. Stars destroy deuterium, so the deuterium still around is a fossil of those minutes."
        "\n\n"
        "Stars burn hydrogen into helium. They do not replace the cosmic supply. Tritium is a different, short-lived nucleus, knocked together by cosmic rays, and it is not part of the primordial stock."
    ),
    2: (
        "Most of the helium in the Universe was made in the first few minutes, about a quarter of ordinary matter by mass, while the cosmos was still hot enough for nuclei to fuse and then cooled below that point. "
        "Stars add a further share. Hydrogen fusion in their cores builds helium, and winds, planetary nebulae, and supernovae return some of it to space."
        "\n\n"
        "The helium in a party balloon has a separate biography. It is the alpha particles from uranium and thorium decaying in the crust, trapped in natural-gas wells. That gas is radiogenic. The helium in the Sun is the primordial and stellar kind."
    ),
    3: (
        "Lithium is fragile, and stars destroy it more readily than they make it. A little lithium-7 comes from the Big Bang. "
        "More of both lithium-6 and lithium-7 is chipped off carbon, nitrogen, and oxygen when cosmic rays strike interstellar gas. Novae and giant stars may add some lithium-7, which is then easy to burn away."
        "\n\n"
        "Old stars show less lithium-7 than the Big Bang calculation predicts. That shortage is still an open argument between the nuclear rates and the surfaces of the stars. The lithium in a battery is this scarce, mixed yield."
    ),
    4: (
        "Beryllium is not a product of the Big Bang in any amount that survives, and it is not an ash of ordinary fusion. Stars burn it. "
        "Nearly all of it is made by cosmic rays splitting larger nuclei, carbon and oxygen above all, in the gas between the stars."
        "\n\n"
        "Beryllium-9 is the only stable isotope. Its scarcity in the crust is the scarcity of that chipping process. Geology can concentrate it into beryl. It cannot invent a supply the stars did not leave."
    ),
    5: (
        "Boron sits with lithium and beryllium. Quiet fusion does not leave it behind. "
        "Cosmic rays knocking pieces off carbon and oxygen supply most of it. A second channel matters for boron-11: neutrinos pouring out of a collapsing stellar core can knock a fragment off carbon-12."
        "\n\n"
        "Boron-10 is mainly the cosmic-ray product. The two isotopes therefore record different mixes of the two channels, which is why their ratio is a clue to what happened in the gas before the Sun formed."
    ),
    6: (
        "Carbon is built in the cores of stars that are burning helium. Three helium nuclei meet and make carbon-12, the triple-alpha step. "
        "A little of that carbon captures one more helium nucleus and becomes oxygen, so the amount of carbon a star returns depends on how the race between those two captures goes."
        "\n\n"
        "Red giants and massive stars both run the reaction. Winds and supernovae put the carbon into space. The carbon in coal, diamond, and living tissue is that stellar ash, gathered into the cloud that became the solar system."
    ),
    7: (
        "Nitrogen is made in stars that already contain carbon and oxygen. In the CNO cycle, protons are added until the nucleus spends most of its time as nitrogen-14, the slow step of the cycle, and some of that nitrogen is later mixed out to the surface."
        "\n\n"
        "Intermediate-mass stars and giants do most of this returning. A star that makes its own carbon first, then runs the cycle, can make nitrogen even from gas that started with little carbon. The nitrogen in air and in protein is that processed stellar gas."
    ),
    8: (
        "Oxygen is the main metal a massive star returns. During helium burning, carbon-12 captures a helium nucleus to make oxygen-16. Neon burning later frees still more oxygen. "
        "The star’s explosion, a core-collapse supernova, throws it out."
        "\n\n"
        "Oxygen-16 is an especially tightly bound, even nucleus, which is why oxygen is more abundant in the Sun and in the crust than its neighbors. Water, silicates, and the oxygen of the air are this supernova product."
    ),
    9: (
        "Fluorine is easy for a star to destroy and hard for one to keep. The leading account of fluorine-19 is the neutrino process: neutrinos from a collapsing core strike neon-20 and chip it down to fluorine, which the explosion then ejects before the star can burn the fluorine away."
        "\n\n"
        "Aging giant stars can make a smaller share and dredge it into their winds. Either way the yield is small. Fluorine’s rarity, in minerals and in the cosmic mix, is the rarity of a nucleus that barely escapes the star that made it."
    ),
    10: (
        "Neon-20, the common isotope, is built by carbon burning in massive stars. Two carbon nuclei fuse, and one frequent result is neon plus a helium nucleus. The supernova that ends the star returns that neon to space."
        "\n\n"
        "Neon-22 has a second path. Helium burning on nitrogen-14 builds it in massive stars and in giants, and that neon-22 also releases neutrons those stars use for slow capture of heavier elements. The neon in air is mostly the neon-20 from massive stars."
    ),
    11: (
        "Sodium has a single stable isotope, sodium-23. It is made in massive stars during carbon burning, and again when neon burns explosively in the supernova. "
        "A cycle of proton captures on neon, the neon-sodium cycle, adds a further share in stars hot enough to run it."
        "\n\n"
        "Sodium is odd-numbered, with an unpaired proton, so it is less abundant than magnesium or neon on either side. The salt in the ocean is still that stellar sodium, dissolved out of rock that formed from the same gas."
    ),
    12: (
        "Magnesium-24 is built from helium nuclei by carbon burning and by neon burning in massive stars, and supernovae return it. "
        "It is one of the products astronomers call alpha elements, alongside oxygen, silicon, calcium, and titanium."
        "\n\n"
        "Magnesium-25 and magnesium-26 need extra neutrons, captured during helium and carbon burning. A radioactive cousin, aluminum-26, decays into magnesium-26. Its gamma rays are how telescopes map stars that made this part of the table in the last million years. The magnesium in an alloy is the stable mix."
    ),
    13: (
        "Aluminum-27, the only stable isotope, is made in massive stars, in carbon and neon burning and in the explosion. Proton captures and the rearrangement of nuclei near silicon both feed it. It comes out with the other products of the supernova."
        "\n\n"
        "Aluminum-26 is a radioactive neighbor with a half-life near 700,000 years. Massive stars make it, and satellites see its decay gamma ray across the Milky Way. The aluminum in the crust is the stable isotope. The radioactive one is a tracer of recent stellar deaths, not a mineral."
    ),
    14: (
        "Silicon-28 is the principal ash of oxygen burning in massive stars. Oxygen nuclei fuse, and the burning tends toward silicon, the most tightly bound nucleus the star can stockpile before the final collapse. Silicon burning then consumes part of that stock on the way to iron."
        "\n\n"
        "What survives is the silicon the explosion freezes before the conversion can finish. Silicon-29 and silicon-30 take a share of neutrons during the same burning. Sand, glass, and the rocky planets are largely this frozen supernova ash."
    ),
    15: (
        "Phosphorus-31 is the only stable isotope, and the odd proton number makes it a side product rather than a main ash. "
        "It forms in massive stars during neon and oxygen burning, and in the explosive burning of the supernova, where neutron captures on silicon also feed it."
        "\n\n"
        "The yield is small next to silicon and sulfur. That scarcity is cosmic, not only geological. The phosphate in DNA and in fertilizer rock is a minor channel of the same massive-star explosions that supplied the silicon around it."
    ),
    16: (
        "Sulfur-32 is built with silicon when massive stars burn oxygen, and the supernova returns both. "
        "Sulfur is abundant in the Sun for the same reason oxygen, silicon, and calcium are: the burning favors these even, tightly bound nuclei."
        "\n\n"
        "Heavier sulfur isotopes, especially sulfur-36, need additional neutrons and record a contribution from neutron capture. The sulfur in ore, and in the amino acids cysteine and methionine, is still the oxygen-burning product."
    ),
    17: (
        "Chlorine is odd-numbered, so it is not one of the main ashes. Chlorine-35 and chlorine-37 form in the explosive oxygen and silicon burning of supernovae, as side products of the same zones that make sulfur and argon."
        "\n\n"
        "The two isotopes are not made in the same ratio in every zone, and measurements in stars and in meteorites use that ratio as a tracer. The chloride of seawater is this supernova chlorine, later dissolved from rock."
    ),
    18: (
        "The argon in the Sun is mostly argon-36, built by oxygen burning in massive stars, with argon-38 beside it. That is the argon the Galaxy makes as a gas and returns in supernovae."
        "\n\n"
        "The argon in Earth’s air is a different isotope. Almost all of it is argon-40, the decay product of potassium-40 in rocks, accumulated in the atmosphere over geologic time. A cylinder of welding argon and a sample of solar argon are the same element and two different histories."
    ),
    19: (
        "Potassium is odd-numbered and less abundant than calcium or argon. Potassium-39, the common isotope, is made in the explosive burning of massive stars, in the oxygen- and silicon-burning shells the supernova shocks. Slow neutron capture in giant stars adds a share."
        "\n\n"
        "Potassium-40 is long-lived, with a half-life of about 1.25 billion years. Stars made it, the solar system inherited some, and its decay still heats the Earth’s interior and supplies the argon-40 of the air. The potassium in minerals is mostly the stable 39, with a trace of that clock."
    ),
    20: (
        "Calcium-40 is a doubly magic nucleus, built by oxygen burning and silicon burning in massive stars and ejected in the supernova. It dominates the calcium of the Sun and of limestone."
        "\n\n"
        "The neutron-richer isotopes, up to calcium-48, are not made by that even chain of helium nuclei. They need a neutron-rich environment, and calcium-48 in particular is still argued over. Bone, chalk, and cement are the common isotope, the massive-star product."
    ),
    21: (
        "Scandium has one stable isotope, scandium-45, and the odd proton number keeps it rare. It is made mainly in supernovae, as a side product of explosive oxygen and silicon burning. Slow neutron capture in giant stars adds a further share."
        "\n\n"
        "There is no abundant path of helium captures that stops on scandium, which is why it sits in a valley between calcium and titanium on the cosmic abundance curve. The scandium in a light alloy is that minor channel, concentrated later by geology."
    ),
    22: (
        "Stable titanium, mostly titanium-48, is a product of explosive silicon burning. The supernova assembles a radioactive parent, chromium-48, which decays through vanadium-48 down to titanium-48. The hot, expanding debris, called alpha-rich freeze-out, contributes more."
        "\n\n"
        "A radioactive cousin, titanium-44, is made in the same explosions and decays onward to calcium. Its gamma rays are still seen in the remnant Cassiopeia A. The titanium in an airframe is the stable isotope, frozen out of blasts of that kind before the Sun formed."
    ),
    23: (
        "Vanadium-51 is almost the whole of natural vanadium, and it is a decay product. Supernovae make manganese-51 and chromium-51 in explosive silicon burning, and those nuclei decay to vanadium-51. "
        "The odd proton number is why the element is scarce beside chromium and titanium."
        "\n\n"
        "Core-collapse supernovae and the white-dwarf explosions called Type Ia both contribute. The vanadium added to steel began as those short-lived parents in the iron-peak debris, not as a nucleus the star stored as vanadium."
    ),
    24: (
        "Chromium sits in the iron peak. The common isotope, chromium-52, is largely the daughter of radioactive iron-52, made when silicon burns explosively in a supernova and the debris freezes out near nuclear statistical equilibrium. Iron-52 decays through manganese-52 to chromium-52."
        "\n\n"
        "Core-collapse supernovae and Type Ia supernovae both contribute. A star that is quietly fusing does not stockpile chromium. Past the iron peak, fusion consumes energy, and chromium is reached in the explosion."
    ),
    25: (
        "Manganese-55 is the only stable isotope, and it is the daughter of cobalt-55 made in supernovae. The yield is higher, relative to iron, in Type Ia explosions, the disruption of a white dwarf, than in the collapse of a massive star. "
        "The manganese-to-iron ratio in a star is one clue to which kind of blast enriched it."
        "\n\n"
        "The odd proton number keeps manganese below chromium and iron on the abundance curve. The manganese added to steel, and the manganese in the purple permanganate ion, began as that cobalt parent in a thermonuclear explosion."
    ),
    26: (
        "Iron is where fusion stops paying. Silicon burning in a massive star, and the explosive burning after collapse, build nuclei up to the iron peak, and the most favored product of the explosion is nickel-56. "
        "Nickel-56 decays to cobalt-56 and then to iron-56, the common isotope. Type Ia supernovae make a large share of that nickel-56 as well."
        "\n\n"
        "Further fusion would absorb energy, so a living star does not climb past this peak. The iron in the Earth’s core, in hematite, and in heme is supernova ash. Slow neutron capture adds a trace beside the explosive yield."
    ),
    27: (
        "Cobalt-59, the only stable isotope, is mostly the daughter of nickel-59 made alongside the iron peak in supernovae. "
        "A further share is added by slow neutron capture in massive stars and in giants, past the point where fusion helps."
        "\n\n"
        "Cobalt is scarce next to iron because it is a side product of the blasts that make iron, plus a neutron-capture tail. The cobalt in a magnet, and the cobalt at the center of vitamin B12, is that combined yield."
    ),
    28: (
        "Nickel is an iron-peak element in its own right. Nickel-58, the common isotope, can be assembled directly when the explosion reaches nuclear statistical equilibrium. "
        "Nickel-60 comes from the decay of zinc-60 and of iron-60 in the alpha-rich freeze-out of the same debris."
        "\n\n"
        "Both kinds of supernova contribute, and nickel rides with iron into planetary cores. The nickel in stainless steel and in iron meteorites is this peak. It is not a later rarity built only by neutron capture."
    ),
    29: (
        "Copper lies just past the iron peak, where fusion no longer releases energy. Copper-63 and copper-65 are made by the weak s-process: neutrons released during helium and carbon burning in massive stars are captured slowly onto iron-peak seeds. "
        "Explosive burning in the supernova adds more, in the alpha-rich freeze-out."
        "\n\n"
        "The main slow process of giant stars, which matters for strontium, barium, and lead, contributes less of the copper. The copper of ores is this massive-star product, later concentrated by hot water in the crust."
    ),
    30: (
        "Zinc is made just beyond iron. Alpha-rich freeze-out in supernovae is a major channel, and the weak s-process in massive stars is the other. Zinc-64 is the most abundant of the five stable isotopes."
        "\n\n"
        "The heavier zinc isotopes take a larger share of neutron capture. Zinc is common enough, among iron-peak neighbors, that the metal in brass and in galvanizing is ordinary supernova debris."
    ),
    31: (
        "Gallium-69 and gallium-71 are fed by both neutron-capture channels. The slow process in aging giant stars, the asymptotic giant branch, builds a large share: a neutron at a time, with time for a nucleus to decay between captures. "
        "The rapid process, in a neutron-rich blast, supplies the rest."
        "\n\n"
        "Gallium is odd-numbered and scarce. The gallium in a semiconductor is that neutron-capture product. Fusion in a stellar core never reaches it. The iron peak is as far as energy-releasing fusion goes."
    ),
    32: (
        "Germanium’s isotopes do not share one origin. The lighter ones are largely the weak s-process in massive stars, the same neutron source that feeds zinc. "
        "The heavier ones take more from the main slow process in giant stars and from the rapid process."
        "\n\n"
        "Germanium-70, 72, 73, and 74 are the common mix in the metal. A bar of germanium is a blend of massive-star neutrons, giant-star neutrons, and the rapid blasts. The semiconductor use came long after that mix was already fixed in the solar cloud."
    ),
    33: (
        "Arsenic-75 is the only stable isotope. It sits where the slow capture of giant stars and the rapid capture of neutron-rich blasts both contribute, and solar abundances ask for both."
        "\n\n"
        "Arsenic is odd-numbered, which is why it is rarer than germanium or selenium. The arsenic of ores is that mixed neutron-capture yield, gathered into sulfide minerals long after the stars that made it had died."
    ),
    34: (
        "Selenium has six stable isotopes, and they split among channels. Several are fed by the slow process in giant stars. The neutron-richer ones take a large share from the rapid process. "
        "Selenium-74 is proton-rich. It belongs to the gamma process, in which a supernova’s light knocks neutrons off heavier seed nuclei."
        "\n\n"
        "The selenium in a photoconductor is therefore a blend. Past the iron peak, a single kind of star is rarely the whole story of an element."
    ),
    35: (
        "Bromine-79 and bromine-81 are each a mixture of the slow process in giant stars and the rapid process in neutron-rich blasts. "
        "Bromine is odd-numbered, so the yields stay small beside selenium and krypton."
        "\n\n"
        "Merging neutron stars are the leading site of the rapid process, and some rare supernovae are still discussed. The bromine in a brine was made in those events and in giants, then inherited by the cloud that became the Sun."
    ),
    36: (
        "Krypton’s stable isotopes are a blend of slow neutron capture in giant stars and rapid neutron capture in mergers and related blasts. "
        "Krypton is chemically inert, so once it is made it stays a gas until a new star and its planets trap it."
        "\n\n"
        "The krypton in air is that trapped gas. It was not made in the Earth. It was made in earlier generations of stars and in neutron-rich events, and it rode into the solar system already as krypton."
    ),
    37: (
        "Rubidium-85 is largely a product of the slow process in giant stars. Rubidium-87 is long-lived, with a half-life near 50 billion years, and it receives both the slow process and the rapid process. "
        "Its slow decay to strontium-87 is the clock used in rubidium-strontium dating of rock."
        "\n\n"
        "The element is an alkali metal and stays scarce. The rubidium in a mineral is mostly the giant-star isotope, with a trace of the radioactive one that the dating method reads."
    ),
    38: (
        "Strontium sits on the first peak of the slow process. A closed shell of 50 neutrons makes these nuclei reluctant to capture another neutron, so material piles up. "
        "Aging giant stars make most of strontium-88, the common isotope."
        "\n\n"
        "The rapid process adds a share, especially to the neutron-richer isotopes. Strontium lines in stars are one way to watch the slow process turn on as the Galaxy ages. The strontium in a crimson firework is that giant-star pile-up."
    ),
    39: (
        "Yttrium-89 is the only stable isotope, and it is mainly a slow-process product of giant stars, sitting with strontium and zirconium on the light peak. "
        "The closed neutron shell that stalls capture is the reason those three elements are richer than their neighbors."
        "\n\n"
        "A smaller rapid-process share is allowed by the models and is not the bulk. The yttrium in a laser crystal is the ash of neutrons added slowly inside red giants that died before the Sun formed."
    ),
    40: (
        "Zirconium is mostly that same slow-process peak. Zirconium-90, the common isotope, is built in giant stars. "
        "Zirconium-96 is the exception: it is neutron-rich and takes a substantial share from the rapid process, so a sample of zirconium is not quite a single story."
        "\n\n"
        "The slow process also makes zirconium-93, which is radioactive, with a half-life near 1.5 million years. It decayed to niobium-93 before the planets finished forming. The zirconium metal in reactor cladding is the stable mix, dominated by the giant-star isotopes."
    ),
    41: (
        "Niobium-93 is the only stable isotope, and much of it is a decay product. The slow process in giant stars makes zirconium-93. "
        "That nucleus lives about 1.5 million years, long enough to be made in the star and short enough that, by the birth of the solar system, it had become niobium."
        "\n\n"
        "A rapid-process contribution to niobium is small beside that decay. The niobium in a superconducting alloy is, in that sense, fossil zirconium from giant stars."
    ),
    42: (
        "Molybdenum’s isotopes refuse a single channel. Molybdenum-96 is mainly the slow process. Molybdenum-100 is mainly the rapid process. "
        "Molybdenum-92 and molybdenum-94 are proton-rich, and they are among the most abundant isotopes of the element. The usual neutron-capture paths do not make them."
        "\n\n"
        "The leading account of those proton-rich nuclei is the gamma process, photodisintegration in a supernova, and that account underproduces them. Their origin is an open problem. The molybdenum in an alloy is a blend of at least three histories."
    ),
    43: (
        "Technetium has no stable isotope. The long-lived ones last millions of years, far short of the age of the Earth, so none from the birth of the solar system remains in the crust. "
        "Stars do make it. The slow process in giant stars passes through technetium-99. In 1952 Paul Merrill saw its spectral lines in S-type stars."
        "\n\n"
        "Those lines showed that stars build heavy elements while we watch. On Earth the element has to be made again. Reactors produce it when uranium fissions. The stellar atom and the reactor atom are the same missing element, made in two places."
    ),
    44: (
        "Ruthenium’s seven stable isotopes split among the slow process, the rapid process, and the gamma process. Ruthenium-96 and ruthenium-98 are proton-rich. "
        "Ruthenium-104 is neutron-rich and largely a rapid-process isotope. The middle isotopes are mixed."
        "\n\n"
        "The metal in an electrical contact is that blend, from giant stars, from neutron-rich blasts, and from the photon-driven rare channel. No one site is asked to make all of it."
    ),
    45: (
        "Rhodium-103 is the only stable isotope. Models give a substantial share to the slow process in giant stars and a substantial share to the rapid process. The split is not settled to one number."
        "\n\n"
        "Rhodium is odd-numbered and scarce, which is why it is a precious metal. The rhodium in a catalytic converter is neutron-capture ash from both channels, later concentrated into the same ores as platinum."
    ),
    46: (
        "Palladium’s lighter stable isotopes take more from the slow process in giant stars. Palladium-110, the heaviest, takes more from the rapid process. "
        "Palladium-102 is proton-rich, a gamma-process isotope, and a minor part of the metal."
        "\n\n"
        "The element therefore records both of the great neutron-capture histories. The palladium in a catalyst is not the product of one kind of star."
    ),
    47: (
        "Silver-107 and silver-109 are fed by both neutron-capture channels, in amounts that are roughly comparable in solar-system material. "
        "The slow process runs in giant stars. The rapid process runs in neutron-rich blasts, with merging neutron stars the leading site."
        "\n\n"
        "Both isotopes are odd-numbered, so silver stays rarer than palladium or cadmium. Native silver and silver ores are that mixed yield, gathered by hot fluids in the crust."
    ),
    48: (
        "Cadmium is weighted toward the slow process. Several of its isotopes are built in giant stars, on the path that climbs from the strontium peak toward barium. "
        "Cadmium-116, the heaviest stable isotope, takes a larger rapid-process share."
        "\n\n"
        "Cadmium-106 and cadmium-108 are proton-rich and belong to the gamma process. They are a small fraction of the metal. The cadmium in a coating or a battery is mostly the giant-star share."
    ),
    49: (
        "Indium-115 is about 96 percent of natural indium, and it is mainly a rapid-process product. It is also very slightly radioactive, with a half-life so long that the metal can be held and worked. "
        "Indium-113, the minor isotope, is fed more by the slow process."
        "\n\n"
        "The rapid process is the channel associated with neutron-star mergers and with rare supernovae. The indium in a transparent conductor is, in bulk, that rapid-process isotope."
    ),
    50: (
        "Tin has ten stable isotopes, more than any other element, because it sits on a closed proton shell. The slow process in giant stars flows through several of them and piles material up. "
        "The rapid process feeds the neutron-richer isotopes, tin-122 and tin-124 especially. Tin-112 and tin-114 are proton-rich and minor."
        "\n\n"
        "A bar of tin is a stack of different events: giants, rapid blasts, and a trace of the gamma process. The slow process is the largest contributor to the common middle isotopes. Bronze Age tin and modern solder are the same stellar blend."
    ),
    51: (
        "Antimony-121 and antimony-123 are each a mixture of the slow process and the rapid process. The heavier isotope takes the larger rapid-process share. "
        "Antimony is odd-numbered, scarcer than tin or tellurium."
        "\n\n"
        "The antimony of stibnite is that mixture. Geology concentrated it into the sulfide. The nuclei were made in giant stars and in neutron-rich blasts before the Earth existed."
    ),
    52: (
        "Tellurium is weighted toward the rapid process. Tellurium-128 and tellurium-130 are the two most abundant isotopes, and both are made almost only by rapid neutron capture. "
        "The slow process and the gamma process account for the lighter, less abundant isotopes."
        "\n\n"
        "Those two heavy isotopes decay by a double-beta path so slow that they behave as stable in any mineral. The tellurium in an alloy is, in the main, rapid-process ash from neutron-rich blasts older than the Sun."
    ),
    53: (
        "Iodine-127 is the only stable isotope, and it is mainly a rapid-process product. The slow process contributes a smaller share. "
        "Iodine-129, with a half-life near 16 million years, was also made by the rapid process and was present when the solar system formed. It has since decayed to xenon-129."
        "\n\n"
        "The excess of xenon-129 in meteorites is the evidence of that extinct iodine. The iodine in thyroid hormone is the stable isotope, from the same family of neutron-rich events."
    ),
    54: (
        "Xenon’s isotopes split cleanly enough to be useful. Some are slow-process, some are rapid-process, and xenon-124 and xenon-126 are proton-rich. "
        "Xenon-129 is partly the decay product of iodine-129, so meteorites preserve a record that the rapid process ran shortly before the solar system formed."
        "\n\n"
        "The xenon in a lamp is the trapped planetary share of that mix. Like the other noble gases, it was inherited as a gas. The Earth did not manufacture it."
    ),
    55: (
        "Cesium-133 is the only stable isotope, and it is mainly a product of the slow process in giant stars, near the climb toward the barium peak. A rapid-process contribution is allowed and is not the bulk."
        "\n\n"
        "Cesium-135 and cesium-137 are radioactive fission products of reactors. They are not the cesium of minerals. The cesium in an atomic clock is the giant-star isotope, odd-numbered and scarce."
    ),
    56: (
        "Barium sits on the second peak of the slow process, where a closed shell of 82 neutrons stalls further capture. Giant stars make most of the barium, especially barium-138, the common isotope. "
        "Barium lines are strong enough that a whole class of giant stars is named for them."
        "\n\n"
        "The rapid process adds a minority share, notably to barium-135 and barium-137. Astronomers use barium against europium to separate the two channels in a star. The barium in a glass or a drilling mud is mostly the giant-star peak."
    ),
    57: (
        "Lanthanum-139 is the only stable isotope, and it is mainly a slow-process product, made with barium in giant stars. A rapid-process share is present and smaller. "
        "Lanthanum-138 is a long-lived trace, with a half-life near 100 billion years."
        "\n\n"
        "The lanthanum in a camera lens is the common isotope. It belongs to the same neutron-capture peak as barium, which is why the two elements track each other in many stars."
    ),
    58: (
        "Cerium is mostly the slow process. Cerium-140, the dominant isotope, is built in giant stars just after the barium peak. "
        "Cerium-136 is proton-rich and rare. Cerium-142 takes a rapid-process share."
        "\n\n"
        "The cerium in a catalytic converter and in lighter flints is, in bulk, giant-star ash. The proton-rich and rapid-process pieces ride along in the same metal."
    ),
    59: (
        "Praseodymium-141 is the only stable isotope. It is mainly a slow-process product of giant stars, on the path from the barium peak toward lead. The rapid process contributes a lesser share."
        "\n\n"
        "Praseodymium is odd-numbered and scarcer than cerium or neodymium. The green salts that gave the element its name, and the metal in a magnet alloy, are that giant-star nucleus."
    ),
    60: (
        "Neodymium’s isotopes divide. Neodymium-142, a large share of the element, is a slow-process product. "
        "The heavier isotopes, from 143 through 150, carry a much larger rapid-process share, and neodymium-150 is almost purely rapid-process."
        "\n\n"
        "Neodymium-142 also receives a little from the decay of samarium-146, which was alive in the early solar system. A neodymium magnet is a real blend: giant stars for the light isotope, neutron-rich blasts for the heavy ones."
    ),
    61: (
        "Promethium has no stable isotope. The longest-lived last about twenty years, not geological ages, so none survives from the birth of the solar system. "
        "The slow process in a giant star steps through the promethium numbers and beta-decays onward. The element is a doorway on that path, not a destination that accumulates."
        "\n\n"
        "On Earth, promethium is a fission product. Reactors make it when uranium splits. A star can hold a trace for a short time. A planet cannot inherit a stock."
    ),
    62: (
        "Samarium is a blend, and one isotope is a clock. Samarium-144 is proton-rich. Samarium-147 decays to neodymium-143 with a half-life near 100 billion years, and that decay dates rock. "
        "Samarium-152 and samarium-154 take a large rapid-process share. The middle isotopes are fed by the slow process as well."
        "\n\n"
        "The samarium in a magnet is that mixture. The dating method reads one radioactive isotope inside an otherwise ordinary rare earth. The nuclei came from giant stars, from the gamma process, and from rapid blasts."
    ),
    63: (
        "Europium is the classical tracer of the rapid process. Europium-151 and europium-153 are both made mostly that way. The slow process contributes a small share. "
        "Astronomers compare europium with iron, or with barium, to ask whether a star’s heavy elements came from a neutron-rich blast or from the slow trickle of giants."
        "\n\n"
        "The rapid process needs a blast so neutron-rich that captures outrun beta decay. Merging neutron stars are the leading site. The europium in a red phosphor was made in events of that kind before the Sun formed, not in a merger observed in our own time."
    ),
    64: (
        "Gadolinium’s heavier isotopes dominate the element, and they are largely rapid-process. Gadolinium-158 and gadolinium-160 are the abundant ones. "
        "Gadolinium-152 and gadolinium-154 are fed by the slow process and are minor. Gadolinium-152 is also weakly radioactive."
        "\n\n"
        "The gadolinium used for magnetic resonance is, in bulk, rapid-process ash, with a slow-process minority in the same sample. The same neutron-rich events that supply europium supply most of this metal."
    ),
    65: (
        "Terbium-159 is the only stable isotope. It is mainly a rapid-process product, with a slow-process share from giant stars. The odd proton number makes it one of the scarcer rare earths."
        "\n\n"
        "The terbium in a green phosphor is that mostly rapid-process nucleus. The heavy rare earths often occur in the same minerals because geology gathered them together. Their nuclei were made in overlapping, not identical, stellar channels."
    ),
    66: (
        "Dysprosium’s abundant isotopes are weighted toward the rapid process, and the slow process contributes. Dysprosium-164, 163, 162, and 161 carry most of the mass. "
        "Dysprosium-156 and dysprosium-158 are proton-rich and rare."
        "\n\n"
        "The metal in a magnet alloy is this blend, dominated by the neutron-rich channel. The gathering of rare earths into odd minerals is terrestrial. The assembly of the nuclei is stellar, and for dysprosium it is mostly the rapid process."
    ),
    67: (
        "Holmium-165 is the only stable isotope, and it is mainly a rapid-process product. The slow process adds a minority. Holmium is odd-numbered and scarce even by the standard of the rare earths."
        "\n\n"
        "The holmium in a magnetic alloy was made in neutron-rich blasts, most plausibly neutron-star mergers, and waited in the interstellar gas until the solar system formed. Giant stars are a side contribution here."
    ),
    68: (
        "Erbium is mixed. The rapid process supplies a large share of the heavier isotopes, including erbium-166, 167, 168, and 170. The slow process contributes across the set. "
        "Erbium-162 and erbium-164 are proton-rich and minor."
        "\n\n"
        "The erbium in an optical fiber is this mixture. The pink of erbium glass is the same nuclei. Nothing in the color records which channel made a given atom."
    ),
    69: (
        "Thulium-169 is the only stable isotope, and it is mainly a slow-process product of giant stars, unlike several of its rare-earth neighbors. The rapid process contributes a smaller share. "
        "The capture path passes through thulium on the way toward lead."
        "\n\n"
        "Thulium is one of the least abundant rare earths partly because it is odd-numbered and partly because capture does not stall on it. The thulium in a small X-ray source is that giant-star isotope."
    ),
    70: (
        "Ytterbium’s isotopes need both the slow process and the rapid process. Ytterbium-174, 172, and 173 are abundant and mixed. "
        "Ytterbium-168 and ytterbium-170 include a proton-rich contribution and are less common."
        "\n\n"
        "The ytterbium in an alloy or a laser is that blend. It sits just before the last slow-process climb through lutetium and hafnium into the lead peak."
    ),
    71: (
        "Lutetium-175 is almost all of natural lutetium, and it is mainly a slow-process product. Lutetium-176 is a few percent, with a half-life near 37 billion years, and it is a thermometer. "
        "In a giant star, the temperature decides how much lutetium-176 survives instead of capturing another neutron."
        "\n\n"
        "Lutetium-176 decays to hafnium-176. The pair dates rocks and diagnoses the stars that ran the slow process. The lutetium in a catalyst is mostly the stable 175, with that clock isotope inside it."
    ),
    72: (
        "Hafnium is mixed. The slow process and the rapid process both feed it, and hafnium-176 has an extra source: the decay of lutetium-176. "
        "That is why the lutetium-hafnium pair dates rocks and also traces the slow process through the Galaxy."
        "\n\n"
        "Hafnium-174 is proton-rich and rare. The hafnium that must be separated from zirconium for reactor cladding is the ordinary mix, the two neutron-capture channels plus that slow radioactive trickle from lutetium."
    ),
    73: (
        "Tantalum-181 is almost all of the element, and it is mainly a slow-process product of giant stars. "
        "Tantalum-180 is a trace. The atom found in nature is a long-lived excited state, the rarest primordial isotope, and the ground state is short-lived. Neutrino reactions, or the gamma process, are the accounts offered for that trace."
        "\n\n"
        "The tantalum in a capacitor is the common isotope, the giant-star product. The rare isomer rides in the same metal at a very small fraction and does not change the bulk origin."
    ),
    74: (
        "Tungsten is a mix of the slow and rapid processes. Tungsten-182, 183, 184, and 186 are all significant. Tungsten-180 is proton-rich and rare. "
        "Tungsten-182 has a further chapter: hafnium-182, with a half-life near 9 million years, was alive in the early solar system and decayed to tungsten-182."
        "\n\n"
        "The excess of that daughter in some meteorites times how quickly the first planetary bodies formed. The tungsten in a filament is the neutron-capture blend. The extinct-radioactivity signal is readable only in isotope ratios of the oldest samples."
    ),
    75: (
        "Rhenium-187 is most of natural rhenium, and it is mainly a rapid-process product. It decays to osmium-187 with a half-life near 41 billion years. "
        "Rhenium-185 takes a slow-process share. The pair is the rhenium-osmium clock, used on iron meteorites and on the age of the Galaxy’s heavy elements."
        "\n\n"
        "The rhenium in a superalloy is this mostly rapid-process metal, still slowly becoming osmium. The decay is irrelevant in a workshop and useful, over billions of years, for dating."
    ),
    76: (
        "Osmium’s isotopes split among the slow process, the rapid process, and the decay of rhenium. Osmium-187 is enlarged by that decay, which is how the clock is read. "
        "Osmium-186 is mainly slow-process. Osmium-188, 189, 190, and 192 carry rapid-process material. Osmium-184 is proton-rich and rare."
        "\n\n"
        "The osmium in a hard alloy is that blend. Part of the osmium-187 in an old metal was still rhenium when the solar system formed."
    ),
    77: (
        "Iridium-191 and iridium-193 are both mainly rapid-process products. The slow process adds little, because the capture path does not pile up here. "
        "Iridium belongs with platinum and gold among the metals the rapid process is asked to explain."
        "\n\n"
        "Iridium is scarce in the crust and richer in some meteorites, which is why an iridium-rich layer marks the asteroid impact at the end of the Cretaceous. The nuclei were made in neutron-rich blasts. The layer records a delivery, long after the making."
    ),
    78: (
        "Platinum is mainly a rapid-process metal. Platinum-194, 195, and 196, the abundant isotopes, are built when neutron captures run faster than beta decay. The slow process adds a minority. Platinum-190 is proton-rich and rare."
        "\n\n"
        "Merging neutron stars are the leading site of that rapid capture. The platinum in a crucible was made in blasts of that kind, or in whatever rarer supernovae also manage the rapid process, and was inherited by the solar cloud."
    ),
    79: (
        "Gold-197, the only stable isotope, is a rapid-process nucleus. The slow process in giant stars does not reach it in any useful amount, and fusion in stellar cores stops at the iron peak, far below. "
        "The captures have to be rapid, in a neutron-rich blast."
        "\n\n"
        "Merging neutron stars are the leading site. The glow after some of those mergers fits the heavy rapid-process elements. The gold already in the Earth came from events of that kind before the Sun formed. Geology later gathered it into quartz veins. A merger watched today did not mint that gold."
    ),
    80: (
        "Mercury’s isotopes are a blend of the slow process and the rapid process, close to the lead peak where slow capture is about to end. Mercury-196 is proton-rich and rare. "
        "The common isotopes, 202, 200, 199, and 198, are mixed."
        "\n\n"
        "The mercury distilled from cinnabar is that blend. Giant stars and neutron-rich blasts both contribute, and the liquid metal does not record which atom came from which channel."
    ),
    81: (
        "Thallium-205 and thallium-203 lie just before the lead peak. Both take a large share from the slow process, which is funneling material toward lead-208, and both take a rapid-process share. "
        "Thallium-205 can also receive the decay of lead-205, a long-lived radioactive nucleus."
        "\n\n"
        "Thallium is odd-numbered and scarce. The thallium once used in infrared optics is this end-of-the-line neutron-capture mix."
    ),
    82: (
        "Lead is where the slow process ends. Lead-208 has 82 protons and 126 neutrons, both closed shells, and nuclei that reach it by slow capture tend to stop. Giant stars pile lead up. "
        "That primordial lead includes smaller slow-process shares of lead-206 and lead-207, plus a rapid-process contribution."
        "\n\n"
        "On Earth a second source dominates many ores. Uranium-238 decays to lead-206, uranium-235 to lead-207, and thorium-232 to lead-208. The isotope ratios in a galena record the age of the ore as well as the stars. A piece of lead is part stellar ash and part the daughter of those radioactive metals."
    ),
    83: (
        "Bismuth-209 is the heaviest nucleus that survives on a cosmic timescale, and only barely: its half-life is about 2 × 10^19 years, far longer than the age of the Universe. It is the last stop of the slow process. "
        "Capture beyond it makes polonium, which alpha-decays, and the chain falls back toward lead. Giant stars therefore pile material at bismuth as well as at lead."
        "\n\n"
        "A rapid-process share exists and is smaller. The bismuth in an alloy is mostly that terminal slow-process nucleus. The decay is real, and no laboratory lasts long enough to watch a sample of it."
    ),
    84: (
        "Polonium has no isotope that lasts. In a star, the slow process steps through polonium and the polonium alpha-decays, which is part of why the capture chain terminates near lead and bismuth. "
        "The rapid process makes polonium too, and it decays onward or, in an extreme blast, fissions."
        "\n\n"
        "On Earth the only polonium is what uranium and thorium decay chains produce now, especially polonium-210, and it disappears on a scale of months. There is no primordial polonium in a mineral. The atoms are daughters, constantly replenished, of uranium and thorium the rapid process made long ago."
    ),
    85: (
        "Astatine is only a brief step. Every isotope lives for hours or less. Neutron-capture paths may pass through astatine, and the nucleus decays before a star can mix it into space in any stored form. "
        "Uranium and thorium chains also produce it, for seconds, inside minerals that contain those parents."
        "\n\n"
        "There is no astatine ore and no primordial stock. Atoms made in accelerators, and atoms flickering inside uranium minerals, are the inventory. The universe does not accumulate this element."
    ),
    86: (
        "Radon is a decay-chain gas. Radon-222 comes from radium-226, itself a daughter of uranium-238. Radon-220 comes from the thorium chain. "
        "A neutron-capture blast can make a radon nucleus, and that nucleus decays in days or less, so it never joins the gas a new solar system inherits."
        "\n\n"
        "The radon in indoor air is terrestrial and current. It exists because uranium and thorium are still decaying. Its cosmic story is the story of those parent metals."
    ),
    87: (
        "Francium lasts minutes. Francium-223, the longest-lived isotope, is a rare branch of actinium-227 in the uranium-235 chain. "
        "A neutron-rich blast can assemble a francium nucleus, and it beta-decays before any star can deliver it as francium."
        "\n\n"
        "There is no mineral and no primordial stock. At any moment the crust holds grams of francium, made and destroyed continuously. The original nuclei, as a stock from before the Earth, do not exist."
    ),
    88: (
        "Radium does not survive on its own from the stars. Radium-226, with a half-life near 1,600 years, is produced continually by the decay of uranium-238. Radium-228 comes from thorium-232. "
        "Any radium the rapid process made directly was gone long before the solar system formed."
        "\n\n"
        "The radium separated from pitchblende was young in geologic terms, even though its uranium parent was made in neutron-rich blasts billions of years earlier. As long as the uranium lasts, the radium is replenished. The element’s cosmic origin is the origin of uranium."
    ),
    89: (
        "Actinium-227, with a half-life near 22 years, belongs to the uranium-235 decay chain. Uranium minerals produce it continuously. None of it survives from the formation of the Earth as actinium. "
        "The rapid process that made the uranium is the original event."
        "\n\n"
        "Other actinium isotopes are shorter-lived. Blasts can make them, and they decay. Actinium in a laboratory was milked from a uranium or radium parent, or made in a reactor. It is not a primordial metal."
    ),
    90: (
        "Thorium is a rapid-process element. Thorium-232, the isotope found in nature in bulk, has a half-life near 14 billion years, so a useful fraction of what the Galaxy made is still here. "
        "The slow process ends around lead and bismuth and does not reach thorium."
        "\n\n"
        "Merging neutron stars are the leading site of the rapid process, and some rare supernovae are still discussed. Thorium and uranium together make a clock, because they are made together and decay at different rates. The thorium in a gas mantle is that survivor."
    ),
    91: (
        "Protactinium-231, with a half-life near 32,000 years, belongs to the uranium-235 decay chain. It stays scarce in uranium ores because the parent is scarce and the daughter does not accumulate over geologic time. "
        "No protactinium remains from the birth of the solar system as protactinium."
        "\n\n"
        "The rapid process can make protactinium during a blast. Those nuclei decay. The protactinium that has been isolated grew, in the mineral, from uranium, or was made later in a reactor."
    ),
    92: (
        "Uranium is a rapid-process element. Uranium-238, with a half-life near 4.5 billion years, and uranium-235, with a half-life near 700 million years, were both present when the solar system formed. "
        "The shorter life of uranium-235 is why it is only about 0.7 percent of natural uranium now, and a larger fraction when the Earth was young."
        "\n\n"
        "The slow process cannot build them. The captures have to be rapid, and merging neutron stars are the leading site. Some of the material fissioned before it could reach uranium. What reached uranium and survived is the uranium of pitchblende."
    ),
    93: (
        "The same rapid captures that make uranium can make neptunium. Every neptunium isotope then decays. Neptunium-237, the longest-lived, has a half-life near 2 million years, short beside the 4.6 billion years since the solar system formed. No primordial neptunium remains."
        "\n\n"
        "Traces in uranium ore are made in place, by neutrons from spontaneous fission and from alpha particles on light nuclei. Neptunium in a laboratory was made by adding neutrons to uranium. The cosmic path leaves daughters, not a stock of neptunium."
    ),
    94: (
        "Plutonium is a rapid-process product that almost survives. Plutonium-244 has a half-life near 80 million years, too short for a useful stock from the birth of the solar system to remain, and long enough that plutonium-244 was alive then. "
        "Meteorites record its decay. Traces attributed to more recent cosmic events have been reported in deep-sea sediments."
        "\n\n"
        "The plutonium handled as a fuel was not mined from that fossil. Reactors make it by neutron capture on uranium-238, followed by two beta decays. The universe’s rapid process makes plutonium. The metal in a stockpile was made on Earth."
    ),
    95: (
        "Americium lies further along the rapid-process path, and every isotope is too short-lived to inherit. Americium-243, the longest-lived, lasts a few thousand years. A neutron-star merger can assemble such a nucleus during the blast. It decays, or fissions, long before a planet forms."
        "\n\n"
        "The americium in a smoke detector was made in a reactor, by neutron capture on plutonium. That is a human copy of a capture chain. It is not a recovery of primordial americium, because none remains."
    ),
    96: (
        "Curium sits on the same rapid-process path. Curium-247 has a half-life near 16 million years, long enough that models ask whether a trace was present in the early solar system, and far too short for any to remain now. The other isotopes are shorter-lived."
        "\n\n"
        "Laboratory curium was made by helium nuclei on plutonium, or by neutron capture in a reactor. A merger may make curium nuclei for a while. They do not become a planetary inventory."
    ),
    97: (
        "Berkelium can be assembled only in the most neutron-rich blasts, and fission and beta decay remove it quickly. The longest-lived isotope, berkelium-247, lasts about a thousand years. Nothing like a mineral stock can survive from the formation of the solar system."
        "\n\n"
        "The berkelium used as a target for heavier elements was made in a reactor. The cosmic rapid process is the imagined original channel, and it leaves uranium, thorium, and their daughters, not berkelium."
    ),
    98: (
        "Californium is a possible brief product of the rapid process, on the neutron-rich side, before fission recycling breaks the heaviest nuclei apart. No isotope lives long enough to remain from the birth of the solar system. Californium-251, the longest-lived, lasts about nine hundred years."
        "\n\n"
        "The californium in a neutron source was made by intense neutron capture in a reactor, starting from plutonium or curium. That pile of neutrons is a terrestrial stand-in for a much wilder cosmic one, and the product does not outlive the experiment by geological ages."
    ),
    99: (
        "Einsteinium is what a furious neutron burst builds if the burst continues past californium. The Ivy Mike thermonuclear test did that on Earth in 1952 and left einsteinium in the debris. A neutron-star merger is the cosmic event asked to do something similar, for a moment."
        "\n\n"
        "Einsteinium-252, the longest-lived isotope, lasts about a year. No primordial atoms remain, and none are expected in a planet. The element’s original formation, if it happens in nature, is a transient step inside the rapid process, followed at once by decay."
    ),
    100: (
        "Fermium is the next step of that same neutron burst. It was found with einsteinium in the debris of Ivy Mike, which showed that a dense neutron flux can climb this far before the nuclei decay. The astrophysical rapid process is believed to climb through this region and then to fission."
        "\n\n"
        "The longest-lived fermium isotope lasts about a hundred days. There is no cosmic reservoir to inherit. Atoms that have been studied were made in reactors and accelerators, by the same idea of adding many neutrons before beta decay can catch up."
    ),
    101: (
        "Mendelevium is past the point where even a reactor’s neutron flux is the practical route. The known isotopes are made by helium or heavier ions on einsteinium and neighboring targets, and they live for minutes to a couple of months. "
        "A rapid-process blast might assemble such a nucleus. Fission and decay would remove it inside the event."
        "\n\n"
        "No mendelevium survives to be part of a planet. The original cosmic question has a narrow answer: only a neutron-rich blast could build it, and that blast would not leave it behind."
    ),
    102: (
        "The rapid process may pass a few trajectories through nobelium’s proton number while a blast is neutron-rich. Fission cycling is expected to break most of those nuclei before they can decay back to a long-lived ash."
        "\n\n"
        "Every nobelium isotope that has been made lives minutes, or less. There is no primordial nobelium and no plausible hidden ore. The atoms in experiments were fused in accelerators."
    ),
    103: (
        "Lawrencium closes the actinide row. A cosmic rapid process that reaches the actinides is climbing, on the neutron-rich side, toward fission, not toward a stable lawrencium that a later solar system could inherit. The known isotopes live minutes at most."
        "\n\n"
        "The element’s formation in the laboratory is a heavy-ion fusion, boron on californium. That is a different reaction from the neutron captures of a merger. Nature’s neutron-rich blasts are not known to stock this nucleus."
    ),
    104: (
        "Rutherfordium is a transactinide. The astrophysical rapid process is not expected to leave it. As the blast builds neutron-rich nuclei near mass 250 and above, fission recycles them into lighter fragments, and the survivors that later decay toward stability settle around the lead-to-uranium region, not at proton number 104."
        "\n\n"
        "The known isotopes live seconds. Every atom that has been identified was made by fusing heavy ions in an accelerator. A predicted island of longer-lived superheavy nuclei remains a nuclear-structure idea. It is not a place where rutherfordium has been found waiting in nature."
    ),
    105: (
        "Neutron-star mergers, and any supernovae that run the rapid process, are asked to make gold, uranium, and the rare earths. They are not asked to stockpile dubnium. Fission interrupts the climb before proton number 105 can accumulate."
        "\n\n"
        "The isotopes last seconds. The atoms used for the few chemical separations were fusion products, caught one at a time. If a cosmic blast ever made a dubnium nucleus, it did not last long enough to become part of a rock."
    ),
    106: (
        "Seaborgium would require a nucleus with 106 protons to survive the blast that assembled it. In the rapid process, fission is expected to cut the chain off before that proton number can accumulate and then decay into a long-lived seaborgium."
        "\n\n"
        "Laboratory atoms are made by fusing oxygen with californium, or chromium with lead, and they are identified by their decay chains. Those half-lives are seconds. There is no original cosmic reservoir of the element."
    ),
    107: (
        "Bohrium is in the same class. The rapid process builds neutron-rich matter and then fission and beta decay rearrange it. The rearrangement is not thought to deposit a surviving population at proton number 107."
        "\n\n"
        "The atoms made at Darmstadt came from chromium ions on bismuth, and they vanished in milliseconds to seconds. Their formation was a cold fusion of two heavy nuclei, a reaction stars do not run. The universe’s neutron captures do not leave bohrium behind."
    ),
    108: (
        "Hassium is the group-8 superheavy. Fission recycling in a neutron-rich blast returns matter to lighter nuclei. It does not fill an island of hassium that the solar system could inherit."
        "\n\n"
        "A few hassium atoms have lived long enough, seconds, for a chemical experiment on a tetroxide. They were made by iron on lead. That laboratory fusion is the only formation channel that has actually produced the element."
    ),
    109: (
        "Meitnerium has no isotope known to live more than seconds. Nothing in the rapid-process yields of gold, lead, or uranium requires a stop at 109 protons, and fission makes such a stop unlikely."
        "\n\n"
        "The first atom was one decay chain from iron on bismuth. Later atoms were made the same way. If the universe forms meitnerium at all, it is as a fleeting nucleus inside a blast, not as a material that ever gathers."
    ),
    110: (
        "Darmstadtium lies beyond the region where the rapid process is known to leave survivors. Calculations that follow a merger’s ejecta produce the familiar heavy elements and a fission cycle. They do not produce a reservoir of element 110."
        "\n\n"
        "The isotopes live from milliseconds to about a second. Each one was fused from nickel and lead. That is the formation history the atoms actually have. A cosmic original, in the sense of a stock older than the Earth, is not expected."
    ),
    111: (
        "Roentgenium is in the same predicted gap. The island of stability, if it is inhabited anywhere, is usually drawn toward more neutrons than the isotopes accelerators have reached, and even that island is a calculation. No natural roentgenium has been observed."
        "\n\n"
        "The known atoms last milliseconds and were made from nickel on bismuth. Neutron capture in a merger is the only cosmic process energetic enough to be discussed, and fission is expected to win before element 111 can accumulate."
    ),
    112: (
        "Copernicium would be a survivor only if a very neutron-rich nucleus with 112 protons could finish its decays without fissioning. Current rapid-process models do not leave such a survivor in the mix that later becomes stars and planets."
        "\n\n"
        "The atoms that have been made came from zinc on lead, lived for seconds at most, and were identified by alpha-decay chains. Their formation is an accelerator result. It is not a chapter of the history of the solar cloud."
    ),
    113: (
        "Nihonium is heavier still, and the same fission limit applies. The rapid process is the only astrophysical channel anyone seriously considers for nuclei this heavy, and it is expected to recycle them."
        "\n\n"
        "The atoms made at RIKEN came from zinc on bismuth, a cold-fusion reaction with a tiny yield, and decayed in milliseconds. A second route, the decay of element 115, is also a laboratory chain. No original natural stock is known or expected."
    ),
    114: (
        "Flerovium is sometimes mentioned in guesses about a shore of longer half-lives, because some of its isotopes last seconds rather than milliseconds. Seconds are not a cosmic stock. The rapid process would still have to produce a more neutron-rich parent and have it survive fission."
        "\n\n"
        "The atoms in hand were made with calcium-48 on plutonium. Calcium-48 is a rare nucleus on Earth and is used as a beam. Stars do not fire it at a plutonium target. The element’s real formation channel is that experiment."
    ),
    115: (
        "Moscovium has no path into a planet. Fission in the rapid process is expected to fragment nuclei before 115 protons can be a decay product that lingers. The known isotopes live for tenths of a second."
        "\n\n"
        "They were made by calcium-48 on americium. That fusion is a human arrangement of two heavy nuclei. The universe’s way of building heavy nuclei, neutron capture, is not known to leave moscovium behind."
    ),
    116: (
        "Livermorium is subject to the same limit. Even proton number can make some isotopes slightly longer-lived than their odd neighbors, and the longer life is still milliseconds. Nothing accumulates."
        "\n\n"
        "The atoms were produced from calcium-48 on curium and identified by their decay chains. A neutron-star merger is the cosmic event that builds the heaviest surviving elements, uranium and thorium among them. Livermorium is beyond that surviving set."
    ),
    117: (
        "Tennessine would have to be assembled and then survive both fission and a very short lifetime. No isotope known lives long enough to be a mineral, and the rapid process is not expected to populate proton number 117 in the ejecta that mixes into the Galaxy."
        "\n\n"
        "The atoms that have been counted were made from calcium-48 on berkelium-249, a target that itself had to be manufactured in a reactor before it decayed. Both the target and the product are laboratory nuclei. There is no original cosmic tennessine."
    ),
    118: (
        "Oganesson is the heaviest element yet made, and it has no cosmic reservoir. The rapid process, the only astrophysical candidate for nuclei this large, is expected to end in fission recycling well before a nucleus with 118 protons can decay into something a solar system inherits."
        "\n\n"
        "The atoms reported from Dubna came from calcium-48 on californium and existed as single decay chains. Their half-lives are under a millisecond. The element was formed in an accelerator. The Universe’s ordinary channels, Big Bang fusion, stellar burning, and neutron capture, do not leave it."
    ),
}

assert set(COSMIC_ORIGIN) == set(range(1, 119)), sorted(set(range(1, 119)) - set(COSMIC_ORIGIN))
