class CatalogPack {
  CatalogPack({
    required this.id,
    required this.version,
    required this.sciencePins,
    required this.elements,
    required this.trendNotes,
  });

  final String id;
  final String version;
  final List<String> sciencePins;
  final List<ElementRecord> elements;
  final List<TrendNote> trendNotes;

  factory CatalogPack.fromJson(Map<String, dynamic> json) {
    return CatalogPack(
      id: json['id'] as String,
      version: json['version'] as String,
      sciencePins: (json['sciencePins'] as List<dynamic>).cast<String>(),
      elements: (json['elements'] as List<dynamic>)
          .map((e) => ElementRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      trendNotes: (json['trendNotes'] as List<dynamic>? ?? [])
          .map((e) => TrendNote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  ElementRecord? byZ(int z) {
    for (final e in elements) {
      if (e.z == z) return e;
    }
    return null;
  }

  ElementRecord? bySymbol(String symbol) {
    final s = symbol.toLowerCase();
    for (final e in elements) {
      if (e.symbol.toLowerCase() == s) return e;
    }
    return null;
  }
}

class ElementRecord {
  ElementRecord({
    required this.z,
    required this.symbol,
    required this.name,
    required this.atomicWeight,
    required this.weightKind,
    required this.categoryId,
    required this.categoryLabel,
    required this.tags,
    required this.block,
    required this.period,
    required this.group,
    required this.standardState,
    required this.electronConfig,
    required this.electronConfigFull,
    required this.shellCounts,
    required this.oxidationStates,
    required this.primaryOxidation,
    required this.lattice,
    required this.sourceId,
    required this.summary,
    required this.history,
    required this.trivia,
    required this.curriculum,
    required this.properties,
    required this.discovery,
    required this.applications,
    required this.spectralLines,
    required this.isotopes,
    required this.glow,
    required this.astro,
    required this.reaction,
  });

  final int z;
  final String symbol;
  final String name;
  final double atomicWeight;
  final String weightKind;
  final String categoryId;
  final String categoryLabel;
  final List<String> tags;
  final String block;
  final int period;
  final int? group;
  final String standardState;
  final String electronConfig;
  final String electronConfigFull;
  final List<int> shellCounts;
  final List<int> oxidationStates;
  final int? primaryOxidation;
  final String? lattice;
  final String sourceId;
  final DepthText summary;
  final String history;
  final List<TriviaStory> trivia;
  final DepthText curriculum;
  final ElementProperties properties;
  final Discovery? discovery;
  final List<ApplicationNote> applications;
  final List<SpectralLine> spectralLines;
  final List<IsotopeRecord> isotopes;
  final GlowNote? glow;
  final String? astro;
  final ReactionIllustration? reaction;

  bool get isHalogen => tags.contains('halogen');

  String summaryFor(String depth) => summary.at(depth);

  String configFor({required bool shorthand}) {
    return shorthand ? electronConfig : electronConfigFull;
  }

  factory ElementRecord.fromJson(Map<String, dynamic> json) {
    return ElementRecord(
      z: json['z'] as int,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      atomicWeight: (json['atomicWeight'] as num).toDouble(),
      weightKind: json['weightKind'] as String? ?? 'standard',
      categoryId: json['categoryId'] as String,
      categoryLabel: json['categoryLabel'] as String,
      tags: (json['tags'] as List<dynamic>? ?? []).cast<String>(),
      block: json['block'] as String,
      period: json['period'] as int,
      group: json['group'] as int?,
      standardState: json['standardState'] as String,
      electronConfig: json['electronConfig'] as String,
      electronConfigFull: json['electronConfigFull'] as String,
      shellCounts: (json['shellCounts'] as List<dynamic>).cast<int>(),
      oxidationStates: (json['oxidationStates'] as List<dynamic>? ?? [])
          .map((e) => e as int)
          .toList(),
      primaryOxidation: json['primaryOxidation'] as int?,
      lattice: json['lattice'] as String?,
      sourceId: json['sourceId'] as String? ?? 'compiled-v1',
      summary: DepthText.fromJson(json['summary'] as Map<String, dynamic>),
      history: json['history'] as String? ?? '',
      trivia: (json['trivia'] as List<dynamic>? ?? [])
          .map((e) => TriviaStory.fromJson(e as Map<String, dynamic>))
          .toList(),
      curriculum: DepthText.fromJson(
        json['curriculum'] as Map<String, dynamic>,
      ),
      properties: ElementProperties.fromJson(
        json['properties'] as Map<String, dynamic>? ?? {},
      ),
      discovery: json['discovery'] == null
          ? null
          : Discovery.fromJson(json['discovery'] as Map<String, dynamic>),
      applications: (json['applications'] as List<dynamic>? ?? [])
          .map((e) => ApplicationNote.fromJson(e as Map<String, dynamic>))
          .toList(),
      spectralLines: (json['spectralLines'] as List<dynamic>? ?? [])
          .map((e) => SpectralLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      isotopes: (json['isotopes'] as List<dynamic>? ?? [])
          .map((e) => IsotopeRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      glow: json['glow'] == null
          ? null
          : GlowNote.fromJson(json['glow'] as Map<String, dynamic>),
      astro: json['astro'] as String?,
      reaction: json['reaction'] == null
          ? null
          : ReactionIllustration.fromJson(
              json['reaction'] as Map<String, dynamic>,
            ),
    );
  }
}

class TriviaStory {
  TriviaStory({
    required this.title,
    required this.summary,
    required this.story,
  });

  final String title;
  final String summary;
  final String story;

  factory TriviaStory.fromJson(Map<String, dynamic> json) {
    return TriviaStory(
      title: json['title'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      story: json['story'] as String? ?? '',
    );
  }
}

class DepthText {
  DepthText({
    required this.beginner,
    required this.intermediate,
    required this.advanced,
  });

  final String beginner;
  final String intermediate;
  final String advanced;

  String at(String depth) {
    return switch (depth) {
      'beginner' => beginner,
      'advanced' => advanced,
      _ => intermediate,
    };
  }

  factory DepthText.fromJson(Map<String, dynamic> json) {
    return DepthText(
      beginner: json['beginner'] as String? ?? '',
      intermediate: json['intermediate'] as String? ?? '',
      advanced: json['advanced'] as String? ?? '',
    );
  }
}

class ElementProperties {
  ElementProperties({
    this.covalentRadiusPm,
    this.paulingEn,
    this.ionizationEv,
    this.meltingK,
    this.boilingK,
    this.density,
  });

  final double? covalentRadiusPm;
  final double? paulingEn;
  final double? ionizationEv;
  final double? meltingK;
  final double? boilingK;
  final double? density;

  factory ElementProperties.fromJson(Map<String, dynamic> json) {
    double? n(String k) {
      final v = json[k];
      if (v is num) return v.toDouble();
      return null;
    }

    return ElementProperties(
      covalentRadiusPm: n('covalentRadiusPm'),
      paulingEn: n('paulingEn'),
      ionizationEv: n('ionizationEv'),
      meltingK: n('meltingK'),
      boilingK: n('boilingK'),
      density: n('density'),
    );
  }
}

class Discovery {
  Discovery({this.year, required this.people, required this.text});

  final int? year;
  final String people;
  final String text;

  factory Discovery.fromJson(Map<String, dynamic> json) {
    return Discovery(
      year: json['year'] as int?,
      people: json['people'] as String? ?? '',
      text: json['text'] as String? ?? '',
    );
  }
}

class ApplicationNote {
  ApplicationNote({required this.title, required this.body});

  final String title;
  final String body;

  factory ApplicationNote.fromJson(Map<String, dynamic> json) {
    return ApplicationNote(
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

class SpectralLine {
  SpectralLine({
    required this.id,
    required this.nm,
    required this.eV,
    required this.frequencyHz,
    required this.transition,
    required this.color,
    required this.spectrum,
  });

  final String id;
  final double nm;
  final double eV;
  final double frequencyHz;
  final String transition;
  final String color;
  final String spectrum;

  double get audibleHz => frequencyHz / 1e12;

  factory SpectralLine.fromJson(Map<String, dynamic> json) {
    return SpectralLine(
      id: json['id'] as String,
      nm: (json['nm'] as num).toDouble(),
      eV: (json['eV'] as num).toDouble(),
      frequencyHz: (json['frequencyHz'] as num).toDouble(),
      transition: json['transition'] as String? ?? '',
      color: json['color'] as String? ?? '',
      spectrum: json['spectrum'] as String? ?? 'emission',
    );
  }
}

class IsotopeRecord {
  IsotopeRecord({
    required this.a,
    required this.mass,
    required this.spin,
    required this.stability,
    this.abundance,
    this.halfLife,
    this.decay,
    this.note,
  });

  final int a;
  final double mass;
  final String spin;
  final String stability;
  final double? abundance;
  final String? halfLife;
  final String? decay;
  final String? note;

  int neutrons(int z) => a - z;

  factory IsotopeRecord.fromJson(Map<String, dynamic> json) {
    return IsotopeRecord(
      a: json['a'] as int,
      mass: (json['mass'] as num).toDouble(),
      spin: json['spin'] as String? ?? '',
      stability: json['stability'] as String,
      abundance: (json['abundance'] as num?)?.toDouble(),
      halfLife: json['halfLife'] as String?,
      decay: json['decay'] as String?,
      note: json['note'] as String?,
    );
  }
}

class GlowNote {
  GlowNote({required this.color, required this.text, this.kv});

  final String color;
  final String text;
  final String? kv;

  factory GlowNote.fromJson(Map<String, dynamic> json) {
    return GlowNote(
      color: json['color'] as String,
      text: json['text'] as String,
      kv: json['kv'] as String?,
    );
  }
}

class ReactionIllustration {
  ReactionIllustration({
    required this.reactants,
    required this.products,
    required this.conditions,
    required this.blurbs,
  });

  final String reactants;
  final String products;
  final String conditions;
  final DepthText blurbs;

  factory ReactionIllustration.fromJson(Map<String, dynamic> json) {
    return ReactionIllustration(
      reactants: json['reactants'] as String,
      products: json['products'] as String,
      conditions: json['conditions'] as String,
      blurbs: DepthText(
        beginner: json['beginner'] as String? ?? '',
        intermediate: json['intermediate'] as String? ?? '',
        advanced: json['advanced'] as String? ?? '',
      ),
    );
  }
}

class TrendNote {
  TrendNote({
    required this.zA,
    required this.zB,
    required this.label,
    required this.essay,
    required this.swaps,
  });

  final int zA;
  final int zB;
  final String label;
  final String essay;
  final List<int> swaps;

  bool matches(int a, int b) => (zA == a && zB == b) || (zA == b && zB == a);

  factory TrendNote.fromJson(Map<String, dynamic> json) {
    return TrendNote(
      zA: json['zA'] as int,
      zB: json['zB'] as int,
      label: json['label'] as String,
      essay: json['essay'] as String,
      swaps: (json['swaps'] as List<dynamic>? ?? []).cast<int>(),
    );
  }
}
