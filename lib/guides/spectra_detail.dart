import 'property_guide.dart';
import 'spectra_essays_01_30.dart';
import 'spectra_essays_31_60.dart';
import 'spectra_essays_61_90.dart';
import 'spectra_essays_91_118.dart';

export 'spectra_primer.dart';

/// Teaching article for one element's spectrum.
///
/// The shared primer is its own page. This essay is the part that
/// changes when the selected element changes.
class ElementSpectrumEssay {
  const ElementSpectrumEssay({
    required this.z,
    required this.lede,
    required this.sections,
  });

  final int z;
  final String lede;
  final List<GuideSection> sections;
}

ElementSpectrumEssay spectrumEssay(
  int z,
  String lede,
  List<GuideSection> sections,
) {
  return ElementSpectrumEssay(z: z, lede: lede, sections: sections);
}

GuideSection spec(String heading, String body) => GuideSection(heading, body);

abstract final class ElementSpectra {
  static final byZ = <int, ElementSpectrumEssay>{
    for (final essay in [
      ...spectraEssays01,
      ...spectraEssays31,
      ...spectraEssays61,
      ...spectraEssays91,
    ])
      essay.z: essay,
  };

  static ElementSpectrumEssay? lookup(int z) => byZ[z];
}
