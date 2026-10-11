class PeriodicElement {
  const PeriodicElement({
    required this.z,
    required this.symbol,
    required this.name,
    required this.categoryId,
    required this.halogen,
  });

  final int z;
  final String symbol;
  final String name;
  final String categoryId;
  final bool halogen;

  bool matches({required String query, required String categoryFilter}) {
    if (categoryFilter != 'all') {
      if (categoryFilter == 'halogen') {
        if (!halogen) return false;
      } else if (categoryId != categoryFilter) {
        return false;
      }
    }
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    final asZ = int.tryParse(q);
    if (asZ != null && z == asZ) return true;
    if (symbol.toLowerCase() == q) return true;
    return name.toLowerCase().contains(q);
  }
}

class PeriodicCell {
  const PeriodicCell({required this.z, required this.row, required this.col});

  final int z;
  final int row;
  final int col;
}

class PeriodicLayout {
  PeriodicLayout._();

  static const rows = 10;
  static const cols = 18;
  static const lanthanideRow = 8;
  static const actinideRow = 9;

  static final byZ = {for (final e in elements) e.z: e};

  static PeriodicElement? element(int z) => byZ[z];

  static final cells = _buildCells();

  static List<PeriodicCell> _buildCells() {
    final out = <PeriodicCell>[];
    void at(int z, int period, int group) {
      out.add(PeriodicCell(z: z, row: period - 1, col: group - 1));
    }

    at(1, 1, 1);
    at(2, 1, 18);
    at(3, 2, 1);
    at(4, 2, 2);
    for (var z = 5; z <= 10; z++) {
      at(z, 2, z + 8);
    }
    at(11, 3, 1);
    at(12, 3, 2);
    for (var z = 13; z <= 18; z++) {
      at(z, 3, z);
    }
    for (var z = 19; z <= 36; z++) {
      at(z, 4, z - 18);
    }
    for (var z = 37; z <= 54; z++) {
      at(z, 5, z - 36);
    }
    at(55, 6, 1);
    at(56, 6, 2);
    for (var z = 72; z <= 86; z++) {
      at(z, 6, z - 68);
    }
    at(87, 7, 1);
    at(88, 7, 2);
    for (var z = 104; z <= 118; z++) {
      at(z, 7, z - 100);
    }
    for (var i = 0; i < 15; i++) {
      out.add(PeriodicCell(z: 57 + i, row: lanthanideRow, col: 2 + i));
      out.add(PeriodicCell(z: 89 + i, row: actinideRow, col: 2 + i));
    }
    return out;
  }

  static const elements = [
    PeriodicElement(z: 1, symbol: 'H', name: 'Hydrogen', categoryId: 'reactive-nonmetal', halogen: false),
    PeriodicElement(z: 2, symbol: 'He', name: 'Helium', categoryId: 'noble-gas', halogen: false),
    PeriodicElement(z: 3, symbol: 'Li', name: 'Lithium', categoryId: 'alkali-metal', halogen: false),
    PeriodicElement(z: 4, symbol: 'Be', name: 'Beryllium', categoryId: 'alkaline-earth', halogen: false),
    PeriodicElement(z: 5, symbol: 'B', name: 'Boron', categoryId: 'metalloid', halogen: false),
    PeriodicElement(z: 6, symbol: 'C', name: 'Carbon', categoryId: 'reactive-nonmetal', halogen: false),
    PeriodicElement(z: 7, symbol: 'N', name: 'Nitrogen', categoryId: 'reactive-nonmetal', halogen: false),
    PeriodicElement(z: 8, symbol: 'O', name: 'Oxygen', categoryId: 'reactive-nonmetal', halogen: false),
    PeriodicElement(z: 9, symbol: 'F', name: 'Fluorine', categoryId: 'reactive-nonmetal', halogen: true),
    PeriodicElement(z: 10, symbol: 'Ne', name: 'Neon', categoryId: 'noble-gas', halogen: false),
    PeriodicElement(z: 11, symbol: 'Na', name: 'Sodium', categoryId: 'alkali-metal', halogen: false),
    PeriodicElement(z: 12, symbol: 'Mg', name: 'Magnesium', categoryId: 'alkaline-earth', halogen: false),
    PeriodicElement(z: 13, symbol: 'Al', name: 'Aluminium', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 14, symbol: 'Si', name: 'Silicon', categoryId: 'metalloid', halogen: false),
    PeriodicElement(z: 15, symbol: 'P', name: 'Phosphorus', categoryId: 'reactive-nonmetal', halogen: false),
    PeriodicElement(z: 16, symbol: 'S', name: 'Sulfur', categoryId: 'reactive-nonmetal', halogen: false),
    PeriodicElement(z: 17, symbol: 'Cl', name: 'Chlorine', categoryId: 'reactive-nonmetal', halogen: true),
    PeriodicElement(z: 18, symbol: 'Ar', name: 'Argon', categoryId: 'noble-gas', halogen: false),
    PeriodicElement(z: 19, symbol: 'K', name: 'Potassium', categoryId: 'alkali-metal', halogen: false),
    PeriodicElement(z: 20, symbol: 'Ca', name: 'Calcium', categoryId: 'alkaline-earth', halogen: false),
    PeriodicElement(z: 21, symbol: 'Sc', name: 'Scandium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 22, symbol: 'Ti', name: 'Titanium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 23, symbol: 'V', name: 'Vanadium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 24, symbol: 'Cr', name: 'Chromium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 25, symbol: 'Mn', name: 'Manganese', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 26, symbol: 'Fe', name: 'Iron', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 27, symbol: 'Co', name: 'Cobalt', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 28, symbol: 'Ni', name: 'Nickel', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 29, symbol: 'Cu', name: 'Copper', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 30, symbol: 'Zn', name: 'Zinc', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 31, symbol: 'Ga', name: 'Gallium', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 32, symbol: 'Ge', name: 'Germanium', categoryId: 'metalloid', halogen: false),
    PeriodicElement(z: 33, symbol: 'As', name: 'Arsenic', categoryId: 'metalloid', halogen: false),
    PeriodicElement(z: 34, symbol: 'Se', name: 'Selenium', categoryId: 'reactive-nonmetal', halogen: false),
    PeriodicElement(z: 35, symbol: 'Br', name: 'Bromine', categoryId: 'reactive-nonmetal', halogen: true),
    PeriodicElement(z: 36, symbol: 'Kr', name: 'Krypton', categoryId: 'noble-gas', halogen: false),
    PeriodicElement(z: 37, symbol: 'Rb', name: 'Rubidium', categoryId: 'alkali-metal', halogen: false),
    PeriodicElement(z: 38, symbol: 'Sr', name: 'Strontium', categoryId: 'alkaline-earth', halogen: false),
    PeriodicElement(z: 39, symbol: 'Y', name: 'Yttrium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 40, symbol: 'Zr', name: 'Zirconium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 41, symbol: 'Nb', name: 'Niobium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 42, symbol: 'Mo', name: 'Molybdenum', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 43, symbol: 'Tc', name: 'Technetium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 44, symbol: 'Ru', name: 'Ruthenium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 45, symbol: 'Rh', name: 'Rhodium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 46, symbol: 'Pd', name: 'Palladium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 47, symbol: 'Ag', name: 'Silver', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 48, symbol: 'Cd', name: 'Cadmium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 49, symbol: 'In', name: 'Indium', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 50, symbol: 'Sn', name: 'Tin', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 51, symbol: 'Sb', name: 'Antimony', categoryId: 'metalloid', halogen: false),
    PeriodicElement(z: 52, symbol: 'Te', name: 'Tellurium', categoryId: 'metalloid', halogen: false),
    PeriodicElement(z: 53, symbol: 'I', name: 'Iodine', categoryId: 'reactive-nonmetal', halogen: true),
    PeriodicElement(z: 54, symbol: 'Xe', name: 'Xenon', categoryId: 'noble-gas', halogen: false),
    PeriodicElement(z: 55, symbol: 'Cs', name: 'Caesium', categoryId: 'alkali-metal', halogen: false),
    PeriodicElement(z: 56, symbol: 'Ba', name: 'Barium', categoryId: 'alkaline-earth', halogen: false),
    PeriodicElement(z: 57, symbol: 'La', name: 'Lanthanum', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 58, symbol: 'Ce', name: 'Cerium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 59, symbol: 'Pr', name: 'Praseodymium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 60, symbol: 'Nd', name: 'Neodymium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 61, symbol: 'Pm', name: 'Promethium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 62, symbol: 'Sm', name: 'Samarium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 63, symbol: 'Eu', name: 'Europium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 64, symbol: 'Gd', name: 'Gadolinium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 65, symbol: 'Tb', name: 'Terbium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 66, symbol: 'Dy', name: 'Dysprosium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 67, symbol: 'Ho', name: 'Holmium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 68, symbol: 'Er', name: 'Erbium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 69, symbol: 'Tm', name: 'Thulium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 70, symbol: 'Yb', name: 'Ytterbium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 71, symbol: 'Lu', name: 'Lutetium', categoryId: 'lanthanide', halogen: false),
    PeriodicElement(z: 72, symbol: 'Hf', name: 'Hafnium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 73, symbol: 'Ta', name: 'Tantalum', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 74, symbol: 'W', name: 'Tungsten', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 75, symbol: 'Re', name: 'Rhenium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 76, symbol: 'Os', name: 'Osmium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 77, symbol: 'Ir', name: 'Iridium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 78, symbol: 'Pt', name: 'Platinum', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 79, symbol: 'Au', name: 'Gold', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 80, symbol: 'Hg', name: 'Mercury', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 81, symbol: 'Tl', name: 'Thallium', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 82, symbol: 'Pb', name: 'Lead', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 83, symbol: 'Bi', name: 'Bismuth', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 84, symbol: 'Po', name: 'Polonium', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 85, symbol: 'At', name: 'Astatine', categoryId: 'reactive-nonmetal', halogen: true),
    PeriodicElement(z: 86, symbol: 'Rn', name: 'Radon', categoryId: 'noble-gas', halogen: false),
    PeriodicElement(z: 87, symbol: 'Fr', name: 'Francium', categoryId: 'alkali-metal', halogen: false),
    PeriodicElement(z: 88, symbol: 'Ra', name: 'Radium', categoryId: 'alkaline-earth', halogen: false),
    PeriodicElement(z: 89, symbol: 'Ac', name: 'Actinium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 90, symbol: 'Th', name: 'Thorium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 91, symbol: 'Pa', name: 'Protactinium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 92, symbol: 'U', name: 'Uranium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 93, symbol: 'Np', name: 'Neptunium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 94, symbol: 'Pu', name: 'Plutonium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 95, symbol: 'Am', name: 'Americium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 96, symbol: 'Cm', name: 'Curium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 97, symbol: 'Bk', name: 'Berkelium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 98, symbol: 'Cf', name: 'Californium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 99, symbol: 'Es', name: 'Einsteinium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 100, symbol: 'Fm', name: 'Fermium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 101, symbol: 'Md', name: 'Mendelevium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 102, symbol: 'No', name: 'Nobelium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 103, symbol: 'Lr', name: 'Lawrencium', categoryId: 'actinide', halogen: false),
    PeriodicElement(z: 104, symbol: 'Rf', name: 'Rutherfordium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 105, symbol: 'Db', name: 'Dubnium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 106, symbol: 'Sg', name: 'Seaborgium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 107, symbol: 'Bh', name: 'Bohrium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 108, symbol: 'Hs', name: 'Hassium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 109, symbol: 'Mt', name: 'Meitnerium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 110, symbol: 'Ds', name: 'Darmstadtium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 111, symbol: 'Rg', name: 'Roentgenium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 112, symbol: 'Cn', name: 'Copernicium', categoryId: 'transition-metal', halogen: false),
    PeriodicElement(z: 113, symbol: 'Nh', name: 'Nihonium', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 114, symbol: 'Fl', name: 'Flerovium', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 115, symbol: 'Mc', name: 'Moscovium', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 116, symbol: 'Lv', name: 'Livermorium', categoryId: 'post-transition', halogen: false),
    PeriodicElement(z: 117, symbol: 'Ts', name: 'Tennessine', categoryId: 'reactive-nonmetal', halogen: true),
    PeriodicElement(z: 118, symbol: 'Og', name: 'Oganesson', categoryId: 'noble-gas', halogen: false),
  ];
}
