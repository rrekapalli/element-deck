"""How each element was established: the material, the operation, and the evidence."""

from __future__ import annotations

# Two short paragraphs on the procedure. The naming story lives in history.py.
HOW_DISCOVERED: dict[int, str] = {
    1: (
        "Henry Cavendish collected a gas by pouring acid onto iron, zinc, and tin and catching what bubbled off. "
        "The gas burned. In 1781 he exploded measured amounts of it with air and found that the product was water, and that the gas’s weight accounted for the water’s weight."
        "\n\n"
        "That closed the argument that the gas was a modification of ordinary air. Antoine Lavoisier repeated the combination, named the gas hydrogen, and put it on his list of elements. The discovery was a weighed reaction, not a new mineral."
    ),
    2: (
        "During the solar eclipse of 18 August 1868, Pierre Janssen passed the light of a solar prominence through a spectroscope and saw a yellow line close to, and not identical with, the sodium lines. "
        "Norman Lockyer found the same line in ordinary sunlight and argued it belonged to an element not yet found on Earth."
        "\n\n"
        "William Ramsay closed the search in 1895. He dissolved the uranium mineral cleveite in acid, collected the inert gas that came off, and sparked it. The yellow line matched the solar one. The element had been identified by a wavelength before anyone held a sample."
    ),
    3: (
        "Johan August Arfwedson analyzed petalite from Utö in 1817 and, after removing silica and alumina, was left with a sulfate that was neither sodium nor potassium. "
        "The new alkali gave a different flame and different salts. Berzelius’s laboratory announced it that year."
        "\n\n"
        "Humphry Davy then passed a current through the moistened alkali and obtained a small amount of metal, enough to show that the earth could be reduced the way potash and soda had been. The discovery was the new alkali in the mineral. The metal came second, and in traces."
    ),
    4: (
        "Louis-Nicolas Vauquelin dissolved beryl and emerald in acid, removed the silica, and precipitated a hydroxide that was not alumina. "
        "The salts of the new earth tasted sweet, which is why the first name was glucinium. In 1798 he showed that the earth from both gems was the same."
        "\n\n"
        "The metal waited thirty years. In 1828 Friedrich Wöhler and Antoine Bussy, working separately, heated the chloride with potassium and obtained a gray powder. The discovery of the element was the sweet earth. The isolation was the potassium reduction."
    ),
    5: (
        "Borax and boric acid were already industrial chemicals. In 1808 Joseph Louis Gay-Lussac and Louis Jacques Thénard heated boric oxide with potassium metal and obtained a dark, impure solid. "
        "Humphry Davy, in the same year, electrolyzed moistened boric acid and got a similar material."
        "\n\n"
        "Both products were badly contaminated, and critics said so. The evidence that a new element was present was chemical: the oxide could be reduced to something that was not carbon, silicon, or a known metal, and it regenerated boric acid. Henri Moissan’s later reductions gave a much cleaner sample. The 1808 work is the discovery because both camps produced the same new substance."
    ),
    6: (
        "Charcoal, soot, and diamond were familiar long before anyone treated them as one element. The experiment that tied them together was combustion. "
        "In 1772 Antoine Lavoisier burned a diamond in a closed vessel with a burning glass and collected the same fixed air that burning charcoal produced."
        "\n\n"
        "He weighed the vessel. The gas accounted for the diamond. Graphite later joined them. Carbon was discovered by showing that three very different solids were the same simple substance, because each of them became carbon dioxide and nothing else."
    ),
    7: (
        "Daniel Rutherford let a mouse breathe in a closed volume of air, then absorbed the fixed air with alkali. "
        "What remained would not support a flame or another animal. He called it noxious air and published the experiment in 1772. Cavendish and Scheele reached a similar residue by other routes."
        "\n\n"
        "The residue was still mixed with the argon that no one yet knew about, so the gas was not pure nitrogen. It was pure enough to show that most of the air was a distinct substance, neither oxygen nor carbon dioxide. Jean-Antoine Chaptal named it. The discovery was what was left when the active part of air had been removed."
    ),
    8: (
        "Joseph Priestley focused sunlight on mercuric oxide, which he called mercurius calcinatus per se, and collected a gas in which a candle burned violently and a mouse lived longer than in ordinary air. "
        "He published this in 1774. Carl Wilhelm Scheele had prepared the same gas from several oxides and from nitre, probably earlier, and his book appeared in 1777."
        "\n\n"
        "Priestley interpreted the gas as air with its phlogiston removed. Lavoisier reversed the explanation: the gas was an element, and metals gained it when they calcined. The laboratory fact was the same in both camps. Heating a red powder, or treating an oxide with acid, released a gas that was a large fraction of the air and the supporter of combustion."
    ),
    9: (
        "Fluorspar and hydrofluoric acid were known, and the acid attacked glass and poisoned the chemists who worked with it. "
        "Several attempts to isolate the element inside it ended in injury. Henri Moissan succeeded on 26 June 1886 by electrolyzing a solution of potassium hydrogen fluoride in anhydrous hydrogen fluoride, in a platinum-iridium cell cooled below zero."
        "\n\n"
        "A yellow-green gas appeared at the anode and set silicon and carbon on fire. That violence was the evidence. Nothing else known would do it, and the gas could not be decomposed further. The discovery was an electrolysis cold enough, and a cell resistant enough, that the product survived long enough to be seen."
    ),
    10: (
        "William Ramsay and Morris Travers liquefied air and distilled it in fractions. "
        "After argon had been removed, a light fraction sparked in a discharge tube with a crimson glow that matched no known gas. They collected it in 1898 and named it from the newness of the line."
        "\n\n"
        "The amount in air is small, about 18 parts per million, which is why the gas waited until liquid air could be taken apart carefully. The discovery was a boiling point and a spectrum. There was no mineral and no chemical reaction, only a fraction that glowed a color argon did not."
    ),
    11: (
        "Humphry Davy had isolated potassium from molten potash with a voltaic pile. A few days later, in October 1807, he applied the same current to molten caustic soda. "
        "Globules of metal appeared at the cathode, burned in air, and skated on water the way potassium did, with a different flame."
        "\n\n"
        "Soda and salt were ancient. The element was the metal inside them, and it had never been seen because any chemical reducing agent strong enough to free it was not yet in use. The current was the tool. The violent reaction with water was the proof that the globules were a new alkali metal and not a by-product of the potash experiment."
    ),
    12: (
        "Joseph Black had already shown that magnesia alba was not lime. Humphry Davy tried to electrolyze the earth directly and got little. "
        "In 1808 he mixed moistened magnesia with mercuric oxide, passed the current, and distilled the mercury out of the amalgam that formed. A small amount of metal remained."
        "\n\n"
        "Antoine Bussy prepared it in quantity in 1831 by heating magnesium chloride with potassium. The discovery of the metal is Davy’s amalgam. The discovery of the earth is Black’s distinction of magnesia from lime, without which the electrolysis would have been a repetition of the calcium experiment."
    ),
    13: (
        "Hans Christian Ørsted heated aluminium chloride with potassium amalgam in 1825 and, after distilling off the mercury, found a lump of metal that resembled tin. "
        "Friedrich Wöhler repeated the reduction with potassium metal in 1827 and obtained a powder he could melt into a purer button."
        "\n\n"
        "Alum itself was ancient, and the oxide alumina was already distinguished from silica and from other earths. The discovery of the element was the reduction of the chloride. The samples were small and impure. Henri Sainte-Claire Deville’s later process, and then the Hall–Héroult electrolysis, made the metal in bulk. They did not discover it."
    ),
    14: (
        "Jöns Jacob Berzelius heated potassium metal with potassium fluorosilicate in 1824, washed the mass with water until the soluble salts were gone, and was left with a brown amorphous powder. "
        "The powder burned to silica. Gay-Lussac and Thénard had seen a similar impure material earlier and had not established it."
        "\n\n"
        "Silica, as flint and quartz, was ancient. The element was the powder that could be burned back to silica and that was not carbon. Berzelius’s washing step is what made the claim convincing: the potassium and the fluoride were gone, and the residue was still there."
    ),
    15: (
        "In 1669 Hennig Brand evaporated a large volume of urine to a paste, mixed the residue with sand, and heated it hard in a retort. "
        "A waxy substance distilled over, glowed in the dark, and caught fire in air. He had been looking for a way to make gold."
        "\n\n"
        "The glow and the fire were the evidence that the distillate was not a known wax or a salt. It was the first element isolated by a recorded laboratory procedure, and the procedure was a distillation. Later chemists made the same substance from bones and from phosphate rock, which showed that the urine had been a source of phosphate, not a unique one."
    ),
    16: (
        "Sulfur was gathered from volcanic ground and from the roasting of sulfide ores long before it had a place in a list of elements. "
        "Alchemists burned it, sublimed it, and combined it with metals. What they could not do was split it into simpler bodies."
        "\n\n"
        "Antoine Lavoisier put it among the elements in 1789 for that reason: it survived every attempt at decomposition and entered into compounds of definite weight. The discovery, for an ancient substance, was the decision that brimstone was already simple."
    ),
    17: (
        "Carl Wilhelm Scheele warmed hydrochloric acid with pyrolusite, manganese dioxide, and collected a dense greenish gas. "
        "It bleached litmus and attacked metals. He published the preparation in 1774 and took the gas to be muriatic acid with oxygen stuck to it, which was the going theory."
        "\n\n"
        "Humphry Davy tested that theory in 1810. He could get no oxygen out of the gas, charcoal would not reduce it, and its compounds with phosphorus and with metals behaved as if the gas itself were the simple body. The laboratory preparation is Scheele’s. The recognition that the green gas was an element, and not a compound of oxygen, is Davy’s."
    ),
    18: (
        "Lord Rayleigh weighed nitrogen prepared from ammonia and nitrogen left after oxygen was removed from air. "
        "The atmospheric gas was heavier, by about half a percent, more than his errors allowed. William Ramsay removed oxygen with hot copper and then nitrogen with hot magnesium, and a residual gas remained, about one percent of the air."
        "\n\n"
        "The residue had no chemical reactions they could find, and its spectrum was new. They announced it in 1894. The discovery was a discrepancy in a density, followed by a subtraction: take out everything that could be taken out, and weigh what refused to leave."
    ),
    19: (
        "In October 1807 Humphry Davy touched the poles of a voltaic pile to a piece of moist potash, which the current melted. "
        "Metallic globules formed at the negative pole, burst into flame in air, and decomposed water. He had been trying to decompose the fixed alkalis, which Lavoisier had suspected were compounds and which nobody had split."
        "\n\n"
        "Potash itself was the ash of plants, an old industrial alkali. The element was the metal that appeared only when the current was strong enough to tear it out of the melt. Sodium followed within days on the same apparatus. The method, not a new ore, was the discovery."
    ),
    20: (
        "Lime was an ancient product of burned limestone. Humphry Davy failed to electrolyze it directly. "
        "In 1808, with a suggestion from Berzelius, he mixed moist lime with mercuric oxide, electrolyzed the paste, and distilled the mercury away from the amalgam. A silver-white metal remained, in small amount."
        "\n\n"
        "The metal burned back to lime. That cycle was the proof: the earth had been reduced, and the product regenerated the earth. Calcium was discovered as a metal only after the alkaline earths were accepted as oxides waiting for a strong enough reduction, which the pile and the mercury cathode provided."
    ),
    21: (
        "Lars Fredrik Nilson was separating the rare earths of euxenite and gadolinite. "
        "In 1879 a fraction of the ytterbia gave an oxide whose atomic weight and salts matched none of the known earths. The spectrum showed lines that belonged to the fraction and not to ytterbium."
        "\n\n"
        "Per Teodor Cleve examined the same earth and pointed out that its properties were the ones Mendeleev had published for ekaboron, the gap under boron. The discovery was a fractional crystallization that refused to stay a single earth, confirmed by a spectrum and by a predicted atomic weight. The metal itself was isolated later."
    ),
    22: (
        "William Gregor, in Cornwall, separated the black sand menachanite from the stream with a magnet, dissolved it in acid, and removed the iron. "
        "A white oxide remained. In 1791 he reported that the oxide was not a known earth. He did not obtain the metal."
        "\n\n"
        "Martin Heinrich Klaproth independently found the same oxide in Hungarian rutile in 1795 and gave the element its name. A ductile metal came only in 1910, when Matthew Hunter heated the chloride with sodium in a sealed bomb. The discovery was the white oxide that survived after the iron had been taken out of a magnetic sand."
    ),
    23: (
        "Andrés Manuel del Río, in Mexico City, worked on a brown lead ore from Zimapán. "
        "In 1801 he extracted a substance whose salts were red in acid and whose behavior was not that of chromium, which he knew. He named it erythronium. A later opinion from Paris, that the ore was only chromate, led him to withdraw."
        "\n\n"
        "Nils Gabriel Sefström found the same element in 1830 while examining the brittleness of iron from the Taberg mine. He dissolved the iron, separated a new acid, and showed it was neither chromic nor uranic. Friedrich Wöhler then connected Sefström’s acid with del Río’s ore. The discovery was made twice, by wet analysis of a lead ore and of an iron, and the first finder was talked out of it."
    ),
    24: (
        "The mineral was crocoite, lead chromate, from the Berezov mine in Siberia. Louis-Nicolas Vauquelin boiled the powdered ore with potassium carbonate. "
        "Lead carbonate dropped out, and a yellow solution remained. Acid turned the solution orange. Evaporating and treating the residue gave a new acid."
        "\n\n"
        "He heated that oxide with charcoal in a crucible and obtained a gray metal. The colored salts were the clue that the acid was not molybdic acid or a known one. The metal that burned back to the green oxide was the proof. The whole discovery is one sequence: dissolve the red ore, remove the lead, and reduce what is left."
    ),
    25: (
        "Carl Wilhelm Scheele treated pyrolusite with acid and recognized that the black ore was the oxide of a new metal, not an ore of iron or of the magnet. "
        "Johan Gottlieb Gahn, in 1774, ground the oxide with charcoal and oil, heated the paste hard, and found a button of metal in the crucible."
        "\n\n"
        "The button was brittle and gray, and it regenerated the black oxide when burned. Scheele supplied the identification of the earth. Gahn supplied the reduction. Pyrolusite had been a glassmaker’s reagent for years. The discovery was showing that the reagent was the ore of a metal nobody had isolated."
    ),
    26: (
        "Iron was worked before any chemical notion of an element existed. Meteoritic iron could be hammered as it was found. Bog ore and then common oxides were smelted with charcoal, which both heated the charge and reduced it."
        "\n\n"
        "There is no discoverer and no year. What later counted as the demonstration that iron is an element was the failure of every attempt to decompose the metal, and Lavoisier’s placement of it among the simple bodies. The practical discovery is the smelt: an ore, a fire, and charcoal, giving a metal that could be forged."
    ),
    27: (
        "Certain ores colored glass blue and gave off arsenical fumes when heated, which is why miners distrusted them. "
        "Georg Brandt, at the Swedish Board of Mines, took the blue pigment smalt, dissolved it, and in 1735 obtained a regulus that was not copper, iron, bismuth, or arsenic."
        "\n\n"
        "He showed that the blue of the glass followed this metal and disappeared when the metal was removed. That is the discovery: a controlled separation, and a color that tracked the new metal rather than a known one. It is the first metal with a recorded laboratory claim of that kind."
    ),
    28: (
        "Axel Fredrik Cronstedt took the ore the German miners called Kupfernickel, devil’s copper, because it looked like a copper ore and yielded none. "
        "In 1751 he dissolved it, precipitated the arsenic, and was left with a green solution from which he reduced a white metal. The metal was magnetic, hard, and not copper, cobalt, or iron."
        "\n\n"
        "The green salts were the signature he could follow through the separations. The discovery was the refusal of the ore to be the metal it resembled, followed by a reduction of what the separations had concentrated."
    ),
    29: (
        "Native copper can be picked out of rock and hammered cold, and that is how the oldest copper objects were made. "
        "Smelting came later: heat a carbonate or sulfide ore with charcoal and the metal runs. The alloy with tin is bronze, harder than either metal, and that discovery is prehistoric and was made more than once."
        "\n\n"
        "No person is credited. The element was recognized as simple because the metal survived cupellation and could be dissolved and precipitated back as the same red metal. Cyprus gave the Latin name. The original finding was a native metal in the ground."
    ),
    30: (
        "Zinc boils out of a hot ore, so an ordinary open smelt loses it as smoke. At Zawar in Rajasthan, medieval furnaces condensed that vapor on purpose, in a retort, and collected the metal. "
        "European craftsmen meanwhile made brass by heating copper with zinc ore, without ever holding a lump of zinc."
        "\n\n"
        "Andreas Sigismund Marggraf made the European isolation explicit in 1746. He heated calamine, a zinc carbonate, with charcoal in a closed vessel and scraped the metal off the cooler wall. The discovery, as a published demonstration, is that condensation. The metal had already been made wherever someone thought to cool the smoke."
    ),
    31: (
        "Paul-Émile Lecoq de Boisbaudran dissolved a zinc blende from the Pyrenees and placed the solution in the spark of a spectrometer. "
        "In 1875 he saw a pair of violet lines that belonged to no known element. He concentrated the hydroxide, dissolved it in potassium hydroxide, and electrolyzed it. Metal deposited on the platinum cathode."
        "\n\n"
        "The first bead was small. It melted in a warm hand, and its density and spectrum matched the lines that had started the search. Mendeleev’s predicted eka-aluminium sat close to the measured properties. The discovery tool was the spectroscope. The confirmation was a current that plated out a metal with those lines."
    ),
    32: (
        "Clemens Winkler received the new silver mineral argyrodite from the Himmelsfürst mine at Freiberg and analyzed it in 1886. "
        "Silver and sulfur did not add up to 100 percent. About 7 percent was missing. He precipitated a sulfide from the missing fraction, converted it to an oxide, and reduced the oxide to a gray metal."
        "\n\n"
        "The metal’s atomic weight and the density of its oxide landed on Mendeleev’s ekasilicon. The discovery was a bad analysis that refused to balance, followed by a reduction of the residue. The spectroscope was not required. The balance was."
    ),
    33: (
        "The yellow and red sulfides, orpiment and realgar, were ancient pigments. Heating them with a reducing agent drives off the sulfur and leaves a brittle gray solid that sublimes. "
        "Albertus Magnus, in the thirteenth century, is the writer usually credited with describing that reduction, using soap as the reducing agent."
        "\n\n"
        "The metal was still easy to confuse with antimony. What established arsenic as its own element was the repetition of the reduction on different ores, always giving the same sublimate, with the same poisonous oxide and the same refusal to split further. The discovery is a roast and a sublimation, done on a pigment."
    ),
    34: (
        "Jöns Jacob Berzelius was following an impurity in the sulfuric acid made at Gripsholm from Falun pyrite. "
        "In 1817 the red mud in the lead chambers, which he first took for tellurium, gave a precipitate that smelled of radish when burned and showed a spectrum and a chemistry tellurium did not have."
        "\n\n"
        "He reduced the oxide with potassium and obtained a gray form, and he also prepared the red form. The discovery is that mud. The acid plant had concentrated a trace out of the pyrite, and the smell, the color, and the failure to match tellurium were the evidence."
    ),
    35: (
        "Antoine Jérôme Balard worked with the bitter liquor left after salt had been crystallized from Montpellier seawater. "
        "In 1826 he passed chlorine into it. The liquor turned orange. He extracted the color into ether, treated the extract with potash, and regenerated a dense red liquid by acid and manganese dioxide."
        "\n\n"
        "Justus von Liebig had set a similar liquid aside as iodine chloride. Balard’s regeneration showed a substance that was driven out by chlorine, the way iodine and chlorine displace each other, and that was liquid at room temperature. The discovery was a displacement reaction in a waste brine."
    ),
    36: (
        "After Ramsay and Travers had boiled the lighter noble gases out of liquid air, a small residue remained. "
        "In 1898 a discharge through that residue showed a bright yellow-green line and a pale violet glow that were not argon’s. They measured a new density and a new spectrum on a few cubic centimeters of gas."
        "\n\n"
        "The method was fractional distillation pushed one step further than neon. Krypton hides in the least volatile fraction. The discovery is a line in a discharge tube and a density that did not match any gas already named."
    ),
    37: (
        "Robert Bunsen and Gustav Kirchhoff examined the mineral lepidolite with the spectroscope they had just built. "
        "In 1861 two dark red lines appeared that were not potassium’s and not lithium’s. Bunsen then processed about 150 kilograms of the mineral, precipitating the chloroplatinates and crystallizing them again and again until the new alkali was concentrated."
        "\n\n"
        "The spectrum found the element when the sample was still a mixture. The crystallization produced a salt pure enough to name and to put back into the flame, where the same red lines returned. The metal was prepared soon after by reduction. The discovery instrument was the prism."
    ),
    38: (
        "Adair Crawford compared a mineral from the lead mines at Strontian with witherite, the barium carbonate. "
        "In 1790 the chloride from the Strontian mineral was more soluble, and the earth was lighter, than barium’s. Thomas Charles Hope confirmed a distinct earth and showed that its salts burned crimson, not the green of barium."
        "\n\n"
        "Humphry Davy isolated the metal in 1808 by the mercury-cathode electrolysis he was using on the other alkaline earths, then distilled off the mercury. The discovery of the earth was a solubility and a flame color. The discovery of the metal was the current."
    ),
    39: (
        "Johan Gadolin dissolved a black mineral from the Ytterby quarry, later called gadolinite, in acid. "
        "In 1794, after removing silica and beryllia, he precipitated an earth that was not lime, not magnesia, and not the other earths then known. He reported it as a new earth, yttria."
        "\n\n"
        "The earth was a mixture, which the next century spent peeling apart, but the first separation was real: a fraction with its own reactions and its own weight. The metal was isolated much later by reduction of the chloride. Yttrium was discovered as an earth that would not match the list."
    ),
    40: (
        "Martin Heinrich Klaproth fused powdered zircon from Ceylon with alkali, dissolved the cake, and removed the silica. "
        "In 1789 an earth remained that was not alumina and not the rare earths he knew. He could not reduce it to a metal."
        "\n\n"
        "Jöns Jacob Berzelius isolated an impure metal in 1824 by heating the potassium fluoride salt with potassium, the same pattern he used for silicon. A ductile metal came only with the iodide process in the twentieth century. The discovery is the earth that survived after silica had been taken out of the gem."
    ),
    41: (
        "Charles Hatchett examined a heavy black mineral in the British Museum, sent from Connecticut and catalogued as an iron ore. "
        "In 1801 he fused it with carbonate, dissolved it, and precipitated an oxide that was neither iron, nor tungsten, nor any earth he could name. He called the element columbium and did not isolate a metal."
        "\n\n"
        "The oxide was later tangled with tantalum, because the two metals travel together and resist the same acids. Heinrich Rose separated the chemistries in 1844. The original discovery is Hatchett’s precipitation: one museum specimen, one fusion, and an oxide that matched nothing on the shelf."
    ),
    42: (
        "Molybdenite looks like graphite and was used as a pencil ore. Carl Wilhelm Scheele treated it with nitric acid in 1778. "
        "Unlike graphite, it gave off sulfuric fumes and left a white acidic solid. The white solid was not lead oxide and not tungstic acid."
        "\n\n"
        "Peter Jacob Hjelm heated that acid with charcoal and linseed oil in 1781 and obtained a dark metal. The discovery has two steps that could not be skipped: Scheele showed the greasy mineral was a sulfide of a new acid, and Hjelm reduced the acid. Graphite does neither."
    ),
    43: (
        "Emilio Segrè and Carlo Perrier received a molybdenum plate that had been bombarded with deuterons in the Berkeley cyclotron. "
        "In 1937, in Palermo, they dissolved the plate and followed the radioactivity through a sequence of precipitations. The activity tracked the chemistry expected for the missing element under manganese, the homolog of rhenium, and it was not any known element."
        "\n\n"
        "No stable isotope exists, which is why the element had never appeared in an ore analysis. Earlier claims from minerals did not hold. The discovery was a radioactive tracer in a dissolved cyclotron target, behaving as element 43 should and as nothing else did."
    ),
    44: (
        "Karl Ernst Claus worked through the insoluble residues of Ural platinum ore after osmium and iridium had been argued over. "
        "In 1844, at Kazan, he fused the residues, dissolved them, and obtained a metal whose salts and spectrum were not those of iridium, rhodium, or osmium. He prepared the metal in a coherent sample."
        "\n\n"
        "The discovery is that last fraction. Platinum residues were a mixture of six metals, and each discovery was whatever refused to follow the precipitation of the one before it. Ruthenium was the one that remained when the others had been named."
    ),
    45: (
        "William Hyde Wollaston dissolved crude platinum in aqua regia, precipitated the platinum as the ammonium salt, and was left with a rose-red solution. "
        "In 1803 he reduced that solution and obtained a metal. Its salts stayed red, which no platinum salt did, and the metal was harder and less dense than platinum."
        "\n\n"
        "The discovery is a color that survived the precipitation of platinum. The same solution also yielded palladium. Two elements came out of one liquor because Wollaston did not stop when the platinum was gone."
    ),
    46: (
        "From the same platinum solution, Wollaston precipitated a yellow cyanide in 1803. "
        "He ignited the precipitate and obtained a white metal, lighter than platinum and attackable by nitric acid, which platinum is not. He first sold samples anonymously as a new silver, inviting chemists to tell him what it was, and published the isolation in 1805."
        "\n\n"
        "The cyanide precipitation is the method. It pulled one metal out of a solution that still contained others. The anonymous sale was a provocation. The evidence was the metal’s density, its solubility in nitric acid, and its refusal to be platinum or silver."
    ),
    47: (
        "Silver occurs native, and the sulfide ores yield the metal when roasted and reduced, or when lead is used to collect it and then oxidized away in a cupel. "
        "Those operations are ancient. The metal that remains in the cupel is silver because lead oxide soaks into the hearth and silver does not."
        "\n\n"
        "There is no modern discoverer. The element was established by the invariance of that bead: dissolve it, precipitate the chloride, reduce the chloride, and the same white metal returns. The original finding was a metal in the ore that cupellation could not remove."
    ),
    48: (
        "Friedrich Stromeyer, inspecting apothecaries, found zinc carbonate that turned yellow when heated instead of staying white. "
        "In 1817 he dissolved the carbonate, precipitated the zinc, and was left with an oxide that reduced with charcoal to a bluish metal, softer and more volatile than zinc. The metal and its sulfide were yellow where zinc’s are white."
        "\n\n"
        "Karl Hermann and J. C. H. Roloff found the same impurity in zinc oxide the same year. The discovery is a color that should not have been there, followed by a reduction of the fraction zinc sulfate would not keep."
    ),
    49: (
        "Ferdinand Reich and Hieronymus Theodor Richter were looking for thallium in zinc ores from Freiberg. "
        "Reich, who was colorblind, asked Richter to watch the spectroscope. In 1863 a bright indigo line appeared that was not thallium’s green and not any mapped line. They concentrated the chloride and reduced the oxide with charcoal."
        "\n\n"
        "A small ingot showed the same indigo line in the spark. The discovery is that line, found while hunting a different element, and a reduction that produced a metal whose spark put the line back."
    ),
    50: (
        "Tin was smelted from cassiterite in antiquity. The oxide is reduced by charcoal at a temperature a simple furnace reaches, and the metal runs and can be cast. "
        "Alloyed with copper it makes bronze, and that use is older than any written chemistry."
        "\n\n"
        "No discoverer is assigned. The element was recognized as distinct from lead and silver because the metal was softer than copper, harder than lead, and gave its own oxide. The original discovery is a reduction of a heavy sand, done wherever the sand and the fuel occurred together."
    ),
    51: (
        "Stibnite, the black sulfide, was ground as a cosmetic and was reduced to metal early. Heat the sulfide, or roast it and reduce the oxide with charcoal, and a brittle silvery metal runs out. "
        "That metal was known to medieval metallurgists and was often confused with lead and with bismuth."
        "\n\n"
        "The distinction was practical. Antimony is brittle, forms a characteristic sulfide, and alloys with lead in a way lead does not mimic. By the time elements were listed, antimony was already a metal on the shelf. The discovery was a reduction of a cosmetic ore."
    ),
    52: (
        "Franz-Joseph Müller von Reichenstein, working on gold ores from Zlatna in Transylvania, obtained in 1782 a metal he could not identify as antimony, bismuth, or any metal the ore was supposed to contain. "
        "He sent material to Torbern Bergman, who died before the question was settled. The substance sat unresolved for years."
        "\n\n"
        "Martin Heinrich Klaproth repeated the analysis in 1798, isolated the same metal, and named it. The procedure was a wet analysis of a gold ore: dissolve, precipitate, and compare the product with every metal that might have been expected. The discovery is the product that survived that comparison."
    ),
    53: (
        "Bernard Courtois was extracting sodium carbonate from the ash of seaweed, for saltpeter manufacture. "
        "In 1811 he added too much sulfuric acid to the liquor. A violet vapor rose and condensed as dark crystals on the cool parts of the vessel. The crystals sublimed without melting into a liquid first."
        "\n\n"
        "He handed the observation to Charles Bernard Desormes and Nicolas Clément. Joseph Louis Gay-Lussac and Humphry Davy, independently, showed in 1813 that the crystals were an element analogous to chlorine. The discovery itself was an accident of an excess of acid on a kelp liquor, and a vapor with a color nobody had recorded."
    ),
    54: (
        "Ramsay and Travers distilled the krypton fraction of liquid air still further. "
        "In July 1898 a heavier residue, sparked under low pressure, gave a blue glow and a spectrum of lines that belonged neither to krypton nor to argon. The density was higher than krypton’s."
        "\n\n"
        "The amount was minute. The method was the same fractional distillation, pushed to the last drops. Xenon was discovered because the residue of a residue still had a spectrum of its own."
    ),
    55: (
        "Bunsen and Kirchhoff evaporated tens of tonnes of mineral water from Dürkheim and examined the residue in the spectroscope. "
        "In 1860 two blue lines appeared, close together, that no known alkali produced. They concentrated the new alkali by fractional crystallization of the chloroplatinate, the same tedious separation later used for rubidium."
        "\n\n"
        "The metal was not isolated until 1882, when Carl Setterberg electrolyzed the molten cyanide. The discovery in 1860 was the pair of blue lines and a salt that put those lines back into the flame. The water had held a trace. The prism found it."
    ),
    56: (
        "A dense mineral, Bologna stone, was already famous for glowing after it had been heated with charcoal. Carl Wilhelm Scheele showed in the 1770s that the earth in it was not lime. "
        "The sulfate was insoluble, the earth was heavy, and the salts burned green."
        "\n\n"
        "Humphry Davy isolated the metal in 1808 by electrolyzing the moistened earth with a mercury cathode and distilling off the mercury. The metal regenerated the earth when it burned. Baryta was discovered by distinguishing a heavy earth from lime. The metal was discovered by the current."
    ),
    57: (
        "Carl Gustaf Mosander suspected that ceria was not a single earth. In 1839 he heated cerium nitrate gently, so that only part of it decomposed, and leached the mass with dilute nitric acid. "
        "The soluble portion held an earth that was not cerium. Its sulfate and its atomic weight differed."
        "\n\n"
        "He announced it, briefly withdrew the claim, and then confirmed it. The method is a partial decomposition: the new earth dissolved under conditions that left ceria behind. Lanthanum was hidden inside a sample chemists had been calling pure."
    ),
    58: (
        "Wilhelm Hisinger and Jöns Jacob Berzelius analyzed the heavy mineral cerite from Bastnäs, and Martin Heinrich Klaproth analyzed it independently, in 1803. "
        "After removing silica and iron, an earth remained that was not yttria and not any earth then listed. Both laboratories found it."
        "\n\n"
        "The earth later proved to contain lanthanum and didymium as well, so the 1803 oxide was a mixture whose major constituent was real. The discovery is that analysis of cerite. The metal was prepared decades later by reduction."
    ),
    59: (
        "Mosander’s didymium was accepted as one element until Carl Auer von Welsbach split it. "
        "In 1885 he fractionally crystallized the double ammonium nitrate hundreds of times. Two fractions separated: one gave green salts, the other rose-pink salts, and their absorption spectra were different."
        "\n\n"
        "The green fraction was praseodymium. The evidence was the spectrum that changed as the crystallization proceeded, and the failure of either fraction to produce the other’s bands. No new mineral was involved. The discovery was a separation pushed far past the point where the sample had looked pure."
    ),
    60: (
        "The rose-pink fraction of the same crystallization was neodymium. "
        "Von Welsbach obtained it alongside praseodymium in 1885, from didymium that had been extracted from cerite. The absorption bands of the pink salts were not the bands of the green ones, and further crystallization did not split the pink fraction again."
        "\n\n"
        "The method was identical to the praseodymium separation because the two elements were the two products of one experiment. Neodymium was discovered when didymium, recrystallized often enough, stopped being a single spectrum."
    ),
    61: (
        "Jacob Marinsky, Lawrence Glendenin, and Charles Coryell took fission products from uranium fuel at Oak Ridge and passed them through an ion-exchange column, eluting with citrate. "
        "In 1945 a radioactive fraction came off between neodymium and samarium, the gap where element 61 had been predicted and where earlier mineral claims had failed."
        "\n\n"
        "The fraction’s radiation and its elution position identified it. There was no weighable sample. Promethium was discovered as a band on a column and a decay, because every isotope is radioactive and no ore retains it."
    ),
    62: (
        "Paul-Émile Lecoq de Boisbaudran was recording the absorption spectra of didymium fractions from the mineral samarskite. "
        "In 1879 extra bands remained after the known didymium bands were accounted for. He separated an earth, by fractional precipitation and crystallization, that carried those bands and left the didymium bands behind."
        "\n\n"
        "The earth came from the same mineral family as the other rare earths, and the only reason it had been missed was that its spectrum was buried in theirs. Samarium was discovered by a spectrum that fractional separation could peel off."
    ),
    63: (
        "Eugène-Anatole Demarçay fractionated samarium magnesium nitrate, crystallizing it repeatedly and watching the spark spectrum of each crop. "
        "Between 1896 and 1901 a set of lines grew stronger in the head fractions while the samarium lines weakened. He concentrated an earth that showed those lines almost alone."
        "\n\n"
        "The lines were the discovery. The crystallization was the separation. Europium sits in samarium ores in small amount, and only a spectrum made the enrichment visible before the earth was pure enough to weigh as its own oxide."
    ),
    64: (
        "Jean Charles Galissard de Marignac examined fractions from yttria and from samarskite with a spectroscope. "
        "In 1880 he found lines that matched neither samarium nor the earths already named. He separated an oxide that carried them. Lecoq de Boisbaudran confirmed the spectrum."
        "\n\n"
        "The separation was the usual one: fractional precipitation of the oxalates and crystallization of the double salts, repeated until the lines were stable. Gadolinium was discovered as a spectrum that survived that repetition."
    ),
    65: (
        "Carl Gustaf Mosander, in 1843, dissolved yttria and precipitated it in fractions with dilute ammonia. "
        "The first and last precipitates were not the same earth. One fraction was pink, one was yellow, and what remained was a third. He named two new earths, terbia and erbia."
        "\n\n"
        "Later chemists swapped and split those fractions, and the name terbium settled on one of the products only after holmium, erbium, and the others had been peeled away. The original discovery was the fractional precipitation: yttria was not one earth, and the yellow fraction was the start of terbium."
    ),
    66: (
        "Paul-Émile Lecoq de Boisbaudran started from holmium oxide that still showed foreign lines. "
        "In 1886 he precipitated it fractionally, again and again, until a set of absorption bands could be followed into one fraction and out of the holmium. He named the earth for the difficulty."
        "\n\n"
        "There was no new mineral and no single decisive crystal. The discovery was the persistence of the fractionation. Dysprosium appeared when the holmium spectrum finally shed a set of bands that refused to leave."
    ),
    67: (
        "Marc Delafontaine, Jacques-Louis Soret, and Per Teodor Cleve, working separately, found a new set of absorption bands in erbia in 1878. "
        "Soret saw the bands. Cleve separated an earth that carried them and was neither erbium nor thulium. The earth formed its own salts, and the bands stayed with those salts."
        "\n\n"
        "The discovery is the band spectrum of a fraction. A pure metal was not the point, and a pure earth took longer than the first observation. Holmium was established when the bands and the earth traveled together through a separation."
    ),
    68: (
        "Erbium began as one of Mosander’s 1843 fractions of yttria, the pink one. "
        "The fraction was not pure. Over the next forty years holmium, thulium, and ytterbium were removed from it, each time by fractional crystallization or precipitation, each time taking some bands away and leaving the pink."
        "\n\n"
        "The name stayed with what remained. Erbium was discovered as a colored fraction of an earth that had been thought simple, and it was purified by the same kind of repetition that discovered its neighbors."
    ),
    69: (
        "After holmium had been taken out of erbia, Per Teodor Cleve continued the crystallization. "
        "In 1879 a small fraction remained whose spectrum was neither holmium nor erbium. The oxide was pale, the amount was tiny, and the bands were its own."
        "\n\n"
        "Thulium was the last of the major fractions Cleve sorted from that earth. The method added nothing new in kind. It was fractional crystallization carried past the point where most chemists would have stopped, on a sample that was almost gone."
    ),
    70: (
        "Jean Charles Galissard de Marignac, in 1878, crystallized crude erbia as the nitrate and found that the mother liquor held a colorless earth. "
        "Its atomic weight and its spectrum differed from erbium’s. The pink had stayed in the crystals. The colorless earth had stayed in the solution."
        "\n\n"
        "That earth still contained lutetium, which Urbain and von Welsbach separated in 1907. Marignac’s discovery was real even so: a colorless oxide where erbium’s is pink, obtained by leaving the pink salt to crystallize and examining what did not."
    ),
    71: (
        "Georges Urbain crystallized ytterbium nitrate many times and watched the spark spectrum. "
        "In 1907 the mother liquors enriched a set of lines that ytterbium did not have, and the atomic weight of the enriched oxide rose. Carl Auer von Welsbach and Charles James arrived at the same separation independently."
        "\n\n"
        "The evidence was a spectrum that grew stronger as the crystallization rejected ytterbium, plus a density and an atomic weight that moved with the lines. Lutetium was the last rare earth separated by this classical method. There was nothing left in the liquor that still split."
    ),
    72: (
        "Henry Moseley’s X-ray work had given each atomic number a predictable wavelength. Element 72, still missing, had to sit under zirconium if Bohr’s arrangement was right, and its K lines could be calculated before anyone had seen them. "
        "Dirk Coster and George de Hevesy dissolved Norwegian zircon in Copenhagen and concentrated the fraction that was not zirconium."
        "\n\n"
        "In 1923 the X-ray plate showed the predicted lines. Optical spectra had failed because zirconium and the new element are almost inseparable by chemistry and their arc lines are a forest. The discovery instrument was the X-ray tube. The sample was an ordinary zircon, which had contained the element all along."
    ),
    73: (
        "Anders Gustaf Ekeberg analyzed yttrotantalite from Ytterby and a heavy mineral from Kimito in Finland. "
        "In 1802 he obtained an oxide that would not dissolve in the acids that dissolved the look-alike columbium earth, even when he fused the sample and tried again. He took the insolubility as the property that defined a new metal."
        "\n\n"
        "William Hyde Wollaston later argued the two oxides were the same, and the argument lasted decades. Heinrich Rose and then Jean Charles Galissard de Marignac separated them, Marignac by the different solubilities of the potassium double fluorides. The original discovery was an oxide that refused the acids. The confirmation was a fluoride crystallization that finally divided the two metals."
    ),
    74: (
        "Carl Wilhelm Scheele digested the mineral then called tungsten, calcium tungstate, with acid in 1781 and obtained a new acidic oxide, distinct from molybdic acid. "
        "He did not reduce it. In 1783 Juan José and Fausto Elhuyar dissolved wolframite, precipitated the same acid, mixed it with charcoal, and heated it. A hard, dense metal remained."
        "\n\n"
        "The metal regenerated the acid when it was oxidized, and the acid was the one Scheele had described. The discovery of the element as a metal is the charcoal reduction. The discovery of its acid is Scheele’s digestion of the heavy stone."
    ),
    75: (
        "Walter Noddack, Ida Tacke, and Otto Berg concentrated large masses of molybdenite, columbite, and platinum residues, looking for the two gaps under manganese. "
        "In 1925 their X-ray plates showed lines at the wavelengths predicted for element 75. They pursued the fraction chemically until a weighable oxide and then a metal could be prepared."
        "\n\n"
        "Their claim for element 43 did not survive. The claim for 75 did, because the lines repeated in different ores and the chemistry could be carried far enough to yield a sample. Rhenium was discovered by an X-ray wavelength in a concentrate, and confirmed by isolating the oxide. It was the last stable element found."
    ),
    76: (
        "Smithson Tennant dissolved crude platinum in aqua regia. A black powder remained. "
        "In 1803 he fused that powder with alkali, acidified, and distilled a volatile oxide with a penetrating smell. The oxide contained a new metal. Reducing it gave a dense, hard bead."
        "\n\n"
        "The volatility was the separation. No other metal in the residue distilled so readily as that oxide. Osmium was discovered by driving it out of the undissolved scrap of platinum ore and condensing the vapor."
    ),
    77: (
        "After the volatile oxide had been distilled from the platinum residue, Tennant was left with a metal that still would not dissolve and that gave salts of several colors: red, green, and black. "
        "In 1803 he showed that this metal was not osmium and not platinum. Its density was extraordinary, and its spectrum of salt colors was its own."
        "\n\n"
        "Iridium was discovered in the same black powder as osmium, by staying behind when osmium left. The two announcements came together because they were the two products of one residue."
    ),
    78: (
        "Grains of a white metal turned up in the gold sands of the Chocó, in New Granada. They would not melt in a goldsmith’s fire and would not behave as silver. "
        "Antonio de Ulloa described them in 1735. Charles Wood brought samples to England, and William Brownrigg and William Watson showed in the 1750s that the grains dissolved in aqua regia and precipitated as a metal distinct from gold and from silver."
        "\n\n"
        "The original finding was a grain that survived the operations used to part gold. The demonstration that the grain was a single new metal, and not an alloy, was the European dissolution and precipitation. Platinum was discovered as an inconvenience in a gold washing, then established with aqua regia."
    ),
    79: (
        "Gold occurs native, and the oldest method is mechanical: wash a sand, and the heavy yellow grains remain. "
        "Cupellation and parting with acid came later. Gold stays in the cupel when lead is oxidized away, and it stays undissolved when silver is removed with nitric acid."
        "\n\n"
        "There is no discoverer. The element was established by that refusal to change. Heat it, dissolve its alloys, and the yellow metal returns with the same weight. The original discovery was a heavy yellow grain in a river."
    ),
    80: (
        "Cinnabar, the red sulfide, releases mercury when it is roasted. The sulfur leaves as a gas, and the metal vapor condenses on a cool surface as a liquid. "
        "That distillation was practiced in the ancient world, at Almaden and elsewhere, and the liquid metal was collected in flasks."
        "\n\n"
        "No modern discoverer is assigned. The element was recognized as simple because the liquid could be boiled, condensed, and recovered unchanged, and because cinnabar always gave the same liquid. Mercury was discovered by a roast and a condensation."
    ),
    81: (
        "William Crookes was examining the residue of a sulfuric-acid works with a spectroscope, looking for tellurium. "
        "In 1861 a bright green line appeared that was not tellurium and not sulfur. He followed the line through precipitations of the mud. Claude-Auguste Lamy isolated a larger quantity the next year and melted a button of metal, which showed the same green line in the spark."
        "\n\n"
        "The discovery is the line in the chamber mud. The metal followed, once enough residue had been worked to plate and melt. Thallium was found the way rubidium and caesium were found, by a prism, in a waste that industry had concentrated."
    ),
    82: (
        "Galena, the sulfide, was roasted to the oxide and reduced with charcoal in antiquity, and the metal was also recovered by heating the sulfide with iron. "
        "The metal is soft, dense, and low-melting, and it can be cast in molds. Roman pipes and weights are the scale of that knowledge."
        "\n\n"
        "There is no discoverer. Lead was classed as an element because the metal could be oxidized and reduced in a cycle that always returned the same substance, and because it parted from silver in the cupel as the part that was absorbed, not the part that remained. The original discovery was a smelt of a common sulfide."
    ),
    83: (
        "Bismuth turned up in the ores of the Erzgebirge and was cast as a brittle, low-melting metal that miners knew from lead and from tin by experience. "
        "The written distinction is Claude François Geoffroy’s, in 1753. He compared the metal’s density, its fracture, its oxide, and its behavior on the cupel with lead and with tin, and the properties matched neither."
        "\n\n"
        "The discovery, as a demonstration, was that comparison. The metal had already been on the bench. Geoffroy’s experiments took it off the list of impure leads."
    ),
    84: (
        "Marie and Pierre Curie measured the radioactivity of pitchblende and found it several times higher than the uranium content allowed. "
        "In 1898 they dissolved the ore and separated it by the analytical groups. The extra activity followed the bismuth fraction, and it could be enriched further by fractional precipitation and by sublimation, which bismuth’s own activity, having none, could not imitate."
        "\n\n"
        "The detector was an electrometer, not a balance. They never had a visible piece of the new element in that first year. Polonium was discovered as an activity that refused to stay proportional to any known element in the ore and that clung to the bismuth group while exceeding bismuth."
    ),
    85: (
        "Dale Corson, Kenneth MacKenzie, and Emilio Segrè bombarded bismuth with alpha particles in the Berkeley cyclotron in 1940. "
        "The target became radioactive with a half-life of hours. They dissolved it and the activity followed the chemistry of a halogen: it could be extracted and coprecipitated with iodine, and it distilled the way a heavy halogen should."
        "\n\n"
        "No weighable amount was produced. The chemical behavior plus the radiation identified element 85, the gap under iodine, which had been sought in minerals and missed because every isotope is short-lived. Astatine was discovered as a radioactive tracer that behaved as iodine’s heavier neighbor."
    ),
    86: (
        "Friedrich Ernst Dorn collected the gas that bled out of a radium preparation in 1900 and found that the gas itself was radioactive. "
        "Ernest Rutherford and Frederick Soddy studied the similar emanation from thorium. The gases could be condensed with liquid air, transferred from vessel to vessel, and they decayed with characteristic half-lives while the parent salt grew a fresh supply."
        "\n\n"
        "Diffusion rates suggested a heavy monatomic gas. The discovery was the transfer: the activity moved as a gas, condensed as a gas, and came back when the radium decayed, so it was a daughter element and not a dust of the parent."
    ),
    87: (
        "Marguerite Perey followed the decay products of actinium-227 at the Curie Institute. "
        "In 1939 a small fraction of the activity coprecipitated with caesium perchlorate, the way an alkali metal does, and that fraction decayed with a half-life of about 22 minutes. It grew back in from purified actinium, so it was a daughter, not a contamination."
        "\n\n"
        "The chemistry excluded every known alkali, and the half-life excluded the other daughters. Francium was discovered by a precipitation that alkalis undergo and by a clock that started when actinium decayed. It was the last element found in a natural decay series."
    ),
    88: (
        "After polonium had been traced into the bismuth fraction of pitchblende, Marie and Pierre Curie found a second excess of activity in the barium fraction. "
        "In late 1898 they fractionally crystallized barium chloride. The least soluble crops grew more radioactive with each crystallization, and the atomic weight of the salt crept upward. Eugène Demarçay photographed a new spectral line in the enriched sample."
        "\n\n"
        "The work consumed tonnes of Joachimsthal residues to yield a tenth of a gram of radium chloride by 1902. The discovery in 1898 was the crystallization: radioactivity and a spectral line concentrating together, in the crystals, away from barium."
    ),
    89: (
        "André-Louis Debierne examined the rare-earth fraction of pitchblende after uranium, polonium, and radium had been removed. "
        "In 1899 a radioactivity remained that precipitated with ammonia and followed lanthanum, and that was not radium and not thorium. Friedrich Oskar Giesel found the same activity independently."
        "\n\n"
        "The chemistry was awkward because actinium and lanthanum are hard to part, so early samples were dilute. The evidence was an activity that survived every removal of the known radioactive elements and that stayed with the rare-earth precipitate. Actinium was discovered as what was left in that precipitate."
    ),
    90: (
        "A Norwegian mineral, later called thorite, was sent to Jöns Jacob Berzelius. "
        "In 1828 he decomposed it, removed silica and the known earths, and was left with an earth whose sulfate and whose atomic weight were new. He reduced the fluoride with potassium and obtained an impure gray metal."
        "\n\n"
        "Radioactivity was not part of the discovery. That was shown seventy years later, by Marie Curie and by Gerhard Schmidt, independently. Thorium was discovered the way zirconium was: an earth that remained after the mineral had been taken apart, and a potassium reduction of its fluoride."
    ),
    91: (
        "Kasimir Fajans and Oswald Göhring, in 1913, found a short-lived activity in the uranium series, lasting about a minute, and followed it through precipitations. "
        "Otto Hahn and Lise Meitner looked for a longer-lived parent of actinium. In 1917 they processed pitchblende residues with tantalum as a carrier, then separated an alpha activity that was not tantalum and that decayed with a half-life of tens of thousands of years. Frederick Soddy and John Cranston found it independently."
        "\n\n"
        "The detector was a counter, not a spectrum. The chemistry used a carrier because the amount of the element was invisible. Protactinium was discovered as an alpha activity that could be parted from its carrier and that sat in the decay series where a parent of actinium had to sit."
    ),
    92: (
        "Martin Heinrich Klaproth dissolved pitchblende in acid and precipitated a yellow compound with alkali. "
        "In 1789 the yellow oxide matched no known earth. He heated it with charcoal and took the black product to be the metal. It was an oxide still."
        "\n\n"
        "Eugène-Melchior Péligot prepared uranium tetrachloride in 1841 and reduced it with potassium. The result was a metal with a different weight from Klaproth’s black powder, and the stoichiometry showed that Klaproth had been handling the dioxide. Uranium was discovered as the yellow oxide. The metal was discovered when the chloride was reduced, half a century later. Radioactivity, found by Henri Becquerel in 1896, came later still."
    ),
    93: (
        "Edwin McMillan irradiated a thin layer of uranium oxide with neutrons from the Berkeley cyclotron in 1940. "
        "A 2.3-day radioactivity recoiled out of the layer onto a catcher sheet, so it was a decay product and not the uranium itself. Philip Abelson joined him for the chemistry. The activity did not follow rhenium, which is where the periodic table of the time had placed element 93. It could be oxidized and reduced through states of its own."
        "\n\n"
        "The recoil separated the atoms from the target. The chemistry showed they were not an isotope of a known element. Neptunium was discovered as a daughter that jumped out of the uranium and then refused the chemical slot everyone had reserved for it."
    ),
    94: (
        "Glenn Seaborg, Edwin McMillan, Joseph Kennedy, and Arthur Wahl bombarded uranium with deuterons in the 60-inch cyclotron in late 1940. "
        "They dissolved the target and coprecipitated the new radioactivity with rare-earth fluorides. When they oxidized the solution, the activity stayed dissolved under conditions where a rare earth would have precipitated again. That change of behavior isolated it from every element in the target."
        "\n\n"
        "The amounts were invisible. Alpha particles were the signal. The discovery is the oxidation cycle: a species that precipitated like a rare earth and, once oxidized, did not. Plutonium’s chemistry, not a visible bead, was the evidence."
    ),
    95: (
        "Glenn Seaborg, Ralph James, Leon Morgan, and Albert Ghiorso irradiated plutonium with neutrons in a reactor in 1944. "
        "The target was dissolved, and the actinide fraction was separated by a cycle of oxidations and by ion exchange. A new alpha activity eluted in the position expected for element 95, beyond plutonium, and it grew in as a daughter of a short-lived parent."
        "\n\n"
        "There was no weighable product. The discovery was an elution band and a decay, in a sample of plutonium that had captured neutrons. The column put the new element in a place on the chart. The radiation showed the place was occupied."
    ),
    96: (
        "Seaborg, James, and Ghiorso bombarded plutonium-239 with helium ions in the Berkeley cyclotron in 1944. "
        "The product was separated with the rare-earth fraction and identified by its alpha radiation and by its behavior on an ion-exchange resin. It eluted just ahead of americium, as element 96 should if the actinides were a real series."
        "\n\n"
        "The target and the product were both radioactive, so the separation had to be done quickly and behind shielding, on an invisible quantity. Curium was discovered as an elution position and an alpha energy, from a helium-ion bombardment."
    ),
    97: (
        "Stanley Thompson, Albert Ghiorso, and Glenn Seaborg bombarded a target of americium-241 with helium ions in 1949. "
        "The recoiling atoms were collected, dissolved, and run down an ion-exchange column with a citrate eluant. A few thousand atoms appeared in the elution position predicted for element 97, with a characteristic alpha decay."
        "\n\n"
        "The prediction of the elution order was part of the evidence. The actinide series behaves like the lanthanide series on a resin, so an empty slot in the order could be recognized. Berkelium was discovered as a handful of atoms in that slot."
    ),
    98: (
        "Thompson, Kenneth Street, Ghiorso, and Seaborg repeated the helium-ion experiment on a curium target in 1950. "
        "The catcher foil was dissolved, and the ion-exchange column showed an activity in the next predicted position, element 98, with its own alpha energy and half-life."
        "\n\n"
        "The method differed from berkelium’s only in the target. That was enough, because the elution order and the decay had to both move together to the next place. Californium was discovered as the next band on the same kind of column."
    ),
    99: (
        "The Ivy Mike thermonuclear test of 1952 threw a burst of neutrons onto uranium in the device. "
        "Filter papers flown through the cloud were brought to Berkeley, dissolved, and put through ion-exchange columns. Albert Ghiorso and coworkers found an alpha activity past californium, in the place calculated for element 99, with a half-life of about twenty days."
        "\n\n"
        "The neutrons had built the nucleus up many mass units before it could beta-decay back down to 99 protons. Einsteinium was discovered in fallout, by a column and a counter. The same element was later made in a reactor, which confirmed the elution and the decay."
    ),
    100: (
        "The same Mike debris held one more band. "
        "On the ion-exchange column, past the einsteinium, Ghiorso’s group found a weaker activity with a shorter half-life, in the position calculated for element 100. It was identified in 1952 and kept secret with the rest of the thermonuclear results until 1955."
        "\n\n"
        "Fermium was discovered by going one elution further on the same papers. The neutron burst had climbed one element higher than einsteinium. A reactor could not yet do that. The bomb debris could, and the column could tell the two apart."
    ),
    101: (
        "A target of a few billion atoms of einsteinium was plated on a gold foil and struck with helium ions in the Berkeley cyclotron in 1955. "
        "The product atoms recoiled out of the target onto a second, clean gold foil. That foil was dissolved, and the solution was run through an ion-exchange column. Seventeen atoms eluted in the position of element 101 and were counted by their decays."
        "\n\n"
        "The recoil foil is what made the experiment possible. It left the huge target behind and carried only the atoms that had been knocked forward. Mendelevium was discovered by counting those atoms, one decay at a time."
    ),
    102: (
        "A Stockholm group claimed element 102 in 1957, and the claim did not hold. Groups at Berkeley and at Dubna then made isotopes of the element through the 1960s by heavy-ion bombardment of actinide targets. "
        "The Dubna work of 1966 is the claim later accepted. Two experiments that year, uranium bombarded with neon and americium bombarded with nitrogen, made nobelium-254. It was identified by the alpha decay of its known fermium daughter."
        "\n\n"
        "The method that settled it was a genetic chain: the new activity decayed into a nucleus whose chemistry and whose radiation were already familiar. A spontaneous-fission signal alone had been too easy to misassign. Nobelium was discovered when a daughter could be named."
    ),
    103: (
        "Albert Ghiorso and coworkers bombarded a californium target with boron ions in 1961. "
        "The fused atoms recoiled onto a catcher, and their alpha particles were recorded. The energies and the half-life fit element 103, and a later chemical separation showed the atoms eluting at the end of the actinide series. Dubna reported isotopes of the element soon after."
        "\n\n"
        "Lawrencium was discovered as a recoil and an alpha energy, from a boron beam on a target that itself had been manufactured. The chemistry confirmed the place in the actinide row. The amount was atoms."
    ),
    104: (
        "A Dubna group reported element 104 in 1964 from neon ions on plutonium, identifying it by spontaneous fission. A Berkeley group in 1969 bombarded californium with carbon ions and reported a chain of alpha decays leading to a known nobelium isotope. "
        "Fission by itself could not say which nucleus had split. A chain that ended on a known nucleus could."
        "\n\n"
        "The method that became standard is the second one. A heavy-ion beam fuses with a target, the recoil is caught, and detectors record the energies and the times of the alpha particles until the chain reaches an isotope already in the books. Rutherfordium’s discovery was argued until that kind of chain was clear. Chemistry on a few atoms, later, showed group-4 behavior and supported the identification."
    ),
    105: (
        "Around 1970 both Dubna and Berkeley produced element 105, by different heavy-ion reactions, and both relied on decay chains rather than on a visible product. "
        "The atoms lived seconds. In the experiments that included chemistry, the atoms were swept as a gas or in solution through a separation that compared them with niobium and tantalum."
        "\n\n"
        "The discovery evidence is nuclear: alpha energies, half-lives, and a connection to known daughters. The chemical separations, done on a handful of atoms in the time the atoms allowed, were the supporting argument that the proton number was 105 and not a mistake in the chain."
    ),
    106: (
        "In 1974 a Berkeley group led by Albert Ghiorso fused oxygen with californium, and a Dubna group led by Yuri Oganessian fused chromium with lead. "
        "The Berkeley chain, alpha decays stepping down to a known isotope, was the evidence later affirmed. The atoms were identified in flight and on a detector, not in a bottle."
        "\n\n"
        "Seaborgium was discovered by that chain. The cross section was tiny. Hours of beam produced a few events, and each event was a sequence of recorded energies. A sequence that matches a predicted path is the discovery. A single flash is not."
    ),
    107: (
        "At the GSI laboratory in Darmstadt, Gottfried Münzenberg, Peter Armbruster, and coworkers fired chromium-54 at bismuth-209 in 1981. "
        "The fused nucleus recoils slowly. A velocity filter swept the fast beam aside and let the slow recoil through, and the atom stopped in a silicon detector that recorded where it landed and when it decayed."
        "\n\n"
        "The detector then saw a chain of alpha particles from that same position, with energies and intervals that ended on known nuclei. Bohrium was discovered as one correlated chain. The filter was the part that made a single atom observable in a flood of beam."
    ),
    108: (
        "The same Darmstadt group, in 1984, fused iron-58 with lead-208. "
        "The velocity filter again separated the recoil, and the position-sensitive detector recorded a chain of alpha decays whose times and energies connected to nuclei already identified."
        "\n\n"
        "Hassium was discovered by that correlation. Chemistry came much later: in 2001 a few atoms were oxidized and shown to form a volatile oxide, as osmium does. The discovery itself did not wait for the chemistry. The chain was the evidence."
    ),
    109: (
        "On 29 August 1982 the Darmstadt group fused iron-58 with bismuth-209 and observed a single atom of element 109. "
        "The recoil stopped in the detector, and the alphas that followed came from that spot, in a sequence that reached known nuclei. One atom was the entire evidence of the first report."
        "\n\n"
        "Later runs produced a few more chains of the same kind. Meitnerium was discovered by the spatial correlation inside the detector: decays at one point, in the right order, after a recoil of the right velocity had arrived there. No chemical test has been added since. The chain is still the whole identification."
    ),
    110: (
        "In November 1994 the Darmstadt group fused nickel-62 with lead-208. "
        "The velocity filter delivered the recoils to a silicon detector, and chains of alpha particles were recorded at the implantation sites. A second isotope followed within days, from nickel-64 on the same lead."
        "\n\n"
        "Two isotopes, with chains that agreed with each other and with the known region they decayed into, were the discovery. Darmstadtium was not seen as a product that accumulated. It was seen as correlated events. Milliseconds to seconds later, each atom was gone."
    ),
    111: (
        "Days after the darmstadtium run, the same group switched the target from lead to bismuth and the beam to nickel-64. "
        "In December 1994 the detector recorded chains assigned to element 111. The odd proton number changed the pattern of the decays, and the chains still ended in known territory."
        "\n\n"
        "Roentgenium was discovered by that change of target and beam, on an apparatus already tuned, and by chains that matched the new arithmetic. The method was unchanged: filter, implant, and read the alphas from one pixel."
    ),
    112: (
        "In 1996 the Darmstadt group fused zinc-70 with lead-208. "
        "The recoil separator and the silicon detector recorded a decay chain for element 112. Independent confirmations followed, including an experiment at RIKEN that saw the same kind of chain."
        "\n\n"
        "Copernicium was discovered when a chain from that fusion was confirmed by a second laboratory. A single unconfirmed sequence is a candidate. A repeated sequence, with the same energies, is an element. This was the last element found by the cold-fusion route of nickel and zinc on lead and bismuth."
    ),
    113: (
        "A team at RIKEN, led by Kosuke Morita, fused zinc-70 with bismuth-209 starting in 2004. "
        "Their gas-filled recoil separator sent the products into a detector, and they recorded a chain that passed through element 111 and onward into known nuclei. Further chains over the next several years reproduced it. A Dubna collaboration saw the same element as a daughter of element 115."
        "\n\n"
        "Nihonium was discovered by a cold-fusion chain that was patient. The cross section was so small that the beam ran for months per event. The confirmation was a second chain, and a third, with the same steps. The daughter seen in the element-115 work tied the two laboratories’ nuclei together."
    ),
    114: (
        "In 1998 a Dubna–Livermore collaboration fired calcium-48, a rare neutron-rich projectile, at a plutonium target. "
        "A gas-filled separator carried the recoils to a detector, and the decays that followed were assigned to element 114. Later experiments mapped several isotopes and connected their chains to nuclei Dubna and Darmstadt had both seen."
        "\n\n"
        "Flerovium was discovered by that calcium beam. Calcium-48 fuses more willingly with actinide targets than the nickel and zinc beams do, which is why the cross sections were large enough to work with. The evidence was still a chain of alphas and a spontaneous fission at the end, correlated in one detector pixel."
    ),
    115: (
        "In 2003 the Dubna–Livermore group fused calcium-48 with americium-243. "
        "The chains decayed through element 113 on the way down, which linked them to the RIKEN nihonium chains, and the timings and energies repeated across several atoms."
        "\n\n"
        "Moscovium was discovered as those repeated chains. The americium target supplied 95 protons, the calcium supplied 20, and the compound nucleus lost a few neutrons. The arithmetic was simple. The proof was the sequence of decays, seen more than once, ending where the chart was already known."
    ),
    116: (
        "The Dubna–Livermore collaboration reported element 116 in 2000 from calcium-48 on curium. "
        "The separator and detector were the ones used for flerovium. The chains were shorter-lived, and they stepped through element 114, which gave the new nucleus a daughter already on the board."
        "\n\n"
        "Livermorium was discovered by that connection. A chain that passes through an element just established is easier to trust than a chain that ends in fission with no named daughter. Curium plus calcium-48 was the reaction. The pixel and the clock were the method."
    ),
    117: (
        "Element 117 required a target of berkelium-249, which Oak Ridge made in a reactor and shipped to Dubna before it decayed. "
        "In 2010 the Dubna–Livermore–Oak Ridge collaboration bombarded that target with calcium-48. The separator delivered recoils whose decay chains included a new step, element 117, and then passed through element 115 and downward."
        "\n\n"
        "Tennessine was discovered by those chains, and by a second campaign that produced more of them. The target’s own half-life was part of the experiment: wait too long, and the berkelium is gone. The evidence was the same kind of correlated decays used for the neighboring superheavies, on a target that had to be manufactured first."
    ),
    118: (
        "A 1999 claim of element 118 from Berkeley was withdrawn. In 2006 the Dubna–Livermore group fused calcium-48 with californium-249 and reported a decay chain of a single atom, ending in a spontaneous fission after a sequence of alphas. "
        "Further atoms, in later runs, gave chains with the same structure."
        "\n\n"
        "Oganesson was discovered by the repetition of that chain. One atom opened the case. The later atoms closed it. The half-lives are under a millisecond, so there is no chemistry and no second method. A recoil separator, a pixelated detector, and a beam of calcium-48 on a californium target are the whole of the discovery."
    ),
}

assert set(HOW_DISCOVERED) == set(range(1, 119)), sorted(set(range(1, 119)) - set(HOW_DISCOVERED))
