import 'classification_guides.dart';
import 'electron_guides.dart';
import 'identity_guides.dart';
import 'nuclear_guides.dart';
import 'physical_guides.dart';
import 'spectra_primer.dart';
import 'spectrum_guides.dart';

/// A teaching article about one property, or about spectra in general.
///
/// The article explains the subject. It is not a measurement of the
/// element that was on screen when the reader opened it.
class PropertyGuide {
  const PropertyGuide({
    required this.id,
    required this.title,
    required this.group,
    required this.lede,
    required this.sections,
    this.closing,
  });

  final String id;
  final String title;

  /// Card the row lives on: Identity, Electrons, and so on.
  final String group;

  /// Opening paragraph, before the headed sections.
  final String lede;

  final List<GuideSection> sections;

  /// Footnote under the article. Data-tab articles use the page default.
  final String? closing;
}

class GuideSection {
  const GuideSection(this.heading, this.body);

  final String heading;

  /// Paragraphs separated by a blank line.
  final String body;

  List<String> get paragraphs => body
      .split(RegExp(r'\n\s*\n'))
      .map((paragraph) => paragraph.trim())
      .where((paragraph) => paragraph.isNotEmpty)
      .toList();
}

/// Stable ids for every labeled row on the Properties tab.
abstract final class GuideId {
  static const atomicNumber = 'atomic-number';
  static const symbol = 'symbol';
  static const name = 'name';
  static const protons = 'protons';
  static const electrons = 'electrons';
  static const atomicWeight = 'atomic-weight';
  static const weightBasis = 'weight-basis';
  static const category = 'category';
  static const tags = 'tags';
  static const block = 'block';
  static const period = 'period';
  static const group = 'group';
  static const standardState = 'standard-state';
  static const dataset = 'dataset';

  static const configuration = 'configuration';
  static const shorthand = 'shorthand';
  static const shells = 'shells';
  static const oxidationStates = 'oxidation-states';
  static const primaryOxidation = 'primary-oxidation';

  static const covalentRadius = 'covalent-radius';
  static const electronegativity = 'electronegativity';
  static const firstIonization = 'first-ionization';
  static const meltingPoint = 'melting-point';
  static const boilingPoint = 'boiling-point';
  static const density = 'density';
  static const crystalLattice = 'crystal-lattice';

  static const massNumber = 'mass-number';
  static const neutrons = 'neutrons';
  static const isotopicMass = 'isotopic-mass';
  static const nuclearSpin = 'nuclear-spin';
  static const stability = 'stability';
  static const abundance = 'abundance';
  static const halfLife = 'half-life';
  static const decay = 'decay';

  static const wavelength = 'wavelength';
  static const photonEnergy = 'photon-energy';
  static const frequency = 'frequency';
  static const transition = 'transition';
  static const discharge = 'discharge';
  static const astrophysics = 'astrophysics';

  /// Shared spectra article, opened from the Spectra Details tab.
  static const spectrum = 'spectra-primer';

  static const all = <String>[
    atomicNumber,
    symbol,
    name,
    protons,
    electrons,
    atomicWeight,
    weightBasis,
    category,
    tags,
    block,
    period,
    group,
    standardState,
    dataset,
    configuration,
    shorthand,
    shells,
    oxidationStates,
    primaryOxidation,
    covalentRadius,
    electronegativity,
    firstIonization,
    meltingPoint,
    boilingPoint,
    density,
    crystalLattice,
    massNumber,
    neutrons,
    isotopicMass,
    nuclearSpin,
    stability,
    abundance,
    halfLife,
    decay,
    wavelength,
    photonEnergy,
    frequency,
    transition,
    discharge,
    astrophysics,
    spectrum,
  ];
}

abstract final class PropertyGuides {
  static const all = <PropertyGuide>[
    ...identityGuides,
    ...classificationGuides,
    ...electronGuides,
    ...physicalGuides,
    ...nuclearGuides,
    ...spectrumGuides,
    spectraPrimer,
  ];

  static final byId = <String, PropertyGuide>{
    for (final guide in all) guide.id: guide,
  };

  static PropertyGuide? lookup(String id) => byId[id];
}
