import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../guides/property_guide.dart';
import '../models/catalog.dart';
import '../models/orbital_force.dart';
import '../models/periodic_layout.dart';
import '../providers/selection_controller.dart';
import '../providers/settings_controller.dart';
import '../theme/app_theme.dart';
import '../theme/element_spectrum.dart';
import '../widgets/electron_force_graph.dart';
import '../widgets/element_header.dart';
import '../widgets/property_label.dart';

class DetailsRoom extends StatefulWidget {
  const DetailsRoom({super.key});

  @override
  State<DetailsRoom> createState() => _DetailsRoomState();
}

class _DetailsRoomState extends State<DetailsRoom>
    with SingleTickerProviderStateMixin {
  static const _labels = ['Details', 'Data', 'History', 'Uses'];

  late final TabController _tabs;
  final _scroll = ScrollController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _labels.length, vsync: this);
    _tabs.addListener(_onTab);
  }

  void _onTab() {
    if (_tabs.index == _index) return;
    setState(() => _index = _tabs.index);
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  @override
  void dispose() {
    _tabs.removeListener(_onTab);
    _tabs.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sel = context.watch<SelectionController>();
    final settings = context.watch<SettingsController>();
    final e = sel.current;
    if (e == null) {
      final id = PeriodicLayout.element(sel.currentZ);
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          const SizedBox(height: 24),
          Text(
            id == null ? 'Element ${sel.currentZ}' : '${id.z}  ${id.name}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (id != null)
            Text(id.symbol, style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 12),
          const Text('In the full pack'),
          const Text('This element is not in the on-device catalog.'),
        ],
      );
    }
    return ElementDossier(
      element: e,
      pinned: TabBar(
        controller: _tabs,
        dividerColor: Colors.transparent,
        tabs: [for (final label in _labels) Tab(text: label)],
      ),
      child: ListView(
        controller: _scroll,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          ...switch (_index) {
            0 => _details(context, e, settings),
            1 => _data(context, e, settings),
            2 => _history(context, e),
            _ => _uses(context, e),
          },
        ],
      ),
    );
  }

  List<Widget> _details(
    BuildContext context,
    ElementRecord e,
    SettingsController settings,
  ) {
    final reading = _reading(e.summaryFor(settings.depth));
    final prose = Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.45);
    return [
      Text(reading.lede, style: prose),
      const SizedBox(height: 12),
      _ShellDiagram(
        element: e,
        reducedMotion: settings.reducedMotion,
        energyUnit: settings.energy,
        depth: settings.depth,
      ),
      for (final paragraph in reading.body) ...[
        const SizedBox(height: 12),
        Text(paragraph, style: prose),
      ],
      if (e.reaction != null) ...[
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () => _showReaction(context, e, settings.depth),
          child: const Text('Simulate Reaction'),
        ),
      ],
    ];
  }

  List<Widget> _history(BuildContext context, ElementRecord e) {
    final narrative = e.history.trim().isNotEmpty
        ? e.history.trim()
        : 'History for this element is not in the pack yet.';
    final found = e.howDiscovered.trim().isNotEmpty
        ? e.howDiscovered.trim()
        : (e.discovery?.text ?? '');
    final origin = e.cosmicOrigin.trim();
    return [
      _NarrativeCard(title: 'History of ${e.name}', body: narrative),
      if (e.discovery != null || found.isNotEmpty) ...[
        const SizedBox(height: 12),
        _HowDiscovered(element: e, body: found),
      ],
      if (origin.isNotEmpty) ...[
        const SizedBox(height: 12),
        _NarrativeCard(title: 'Formed in the Universe', body: origin),
      ],
      const SizedBox(height: 20),
      Text('Trivia', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 4),
      Text(
        'Short stories from the history of this element.',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface
              .withValues(alpha: 0.65),
          height: 1.35,
        ),
      ),
      const SizedBox(height: 10),
      ..._trivia(context, e),
    ];
  }

  List<Widget> _uses(BuildContext context, ElementRecord e) {
    if (e.applications.isEmpty) {
      return const [Text('Uses for this element are not in the pack yet.')];
    }
    final muted = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.65);
    return [
      Text(
        'Ways people use ${e.name}.',
        style: Theme.of(context).textTheme.bodySmall
            ?.copyWith(color: muted, height: 1.35),
      ),
      const SizedBox(height: 12),
      for (final use in e.applications) ...[
        _UseCard(use: use),
        const SizedBox(height: 12),
      ],
    ];
  }

  List<Widget> _trivia(BuildContext context, ElementRecord e) {
    if (e.trivia.isEmpty) {
      return const [Text('Trivia for this element is not in the pack yet.')];
    }
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return [
      for (final story in e.trivia)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => _TriviaStoryPage(element: e, story: story),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(story.title, style: titleStyle),
                    const SizedBox(height: 6),
                    Text(story.summary),
                  ],
                ),
              ),
            ),
          ),
        ),
    ];
  }

  List<Widget> _data(
    BuildContext context,
    ElementRecord e,
    SettingsController settings,
  ) {
    final p = e.properties;
    final muted = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.65);
    return [
      Text(
        'Compiled values for this element. Units follow App Config. '
        'Tap a label to open its reference article.',
        style: Theme.of(context).textTheme.bodySmall
            ?.copyWith(color: muted, height: 1.35),
      ),
      const SizedBox(height: 12),
      _DataCard(
        title: 'Identity',
        rows: [
          _Row('Atomic number', '${e.z}', GuideId.atomicNumber),
          _Row('Symbol', e.symbol, GuideId.symbol),
          _Row('Name', e.name, GuideId.name),
          _Row('Protons', '${e.z}', GuideId.protons),
          _Row('Electrons', '${e.z}', GuideId.electrons),
          _Row(
            'Atomic weight',
            '${_mass(e.atomicWeight)} u',
            GuideId.atomicWeight,
          ),
          _Row('Weight basis', _weightKind(e.weightKind), GuideId.weightBasis),
          _Row('Category', e.categoryLabel, GuideId.category),
          if (e.tags.isNotEmpty) _Row('Tags', e.tags.join(', '), GuideId.tags),
          _Row('Block', '${e.block}-block', GuideId.block),
          _Row('Period', '${e.period}', GuideId.period),
          _Row('Group', e.group?.toString() ?? 'f-block row', GuideId.group),
          _Row('Standard state', e.standardState, GuideId.standardState),
          _Row('Dataset', e.sourceId, GuideId.dataset),
        ],
      ),
      const SizedBox(height: 12),
      _DataCard(
        title: 'Electrons',
        rows: [
          _Row(
            'Configuration',
            ElectronCloud.expandedConfiguration(e.electronConfigFull),
            GuideId.configuration,
          ),
          if (e.electronConfig !=
              ElectronCloud.expandedConfiguration(e.electronConfigFull))
            _Row('Shorthand', e.electronConfig, GuideId.shorthand),
          _Row('Shells', _shells(e.shellCounts), GuideId.shells),
          _Row(
            'Oxidation states',
            e.oxidationStates.isEmpty
                ? 'Not reported'
                : e.oxidationStates.map(_ox).join(', '),
            GuideId.oxidationStates,
          ),
          _Row(
            'Primary oxidation',
            e.primaryOxidation == null
                ? 'Not reported'
                : _ox(e.primaryOxidation!),
            GuideId.primaryOxidation,
          ),
        ],
      ),
      const SizedBox(height: 12),
      _DataCard(
        title: 'Physical properties',
        rows: [
          _Row(
            'Covalent radius',
            p.covalentRadiusPm == null
                ? 'Not reported'
                : settings.lengthValue(p.covalentRadiusPm!),
            GuideId.covalentRadius,
          ),
          _Row(
            'Electronegativity',
            p.paulingEn == null
                ? 'Not reported'
                : '${_trim(p.paulingEn!)} Pauling',
            GuideId.electronegativity,
          ),
          _Row(
            'First ionization',
            p.ionizationEv == null
                ? 'Not reported'
                : settings.energyValue(p.ionizationEv!),
            GuideId.firstIonization,
          ),
          _Row(
            'Melting point',
            p.meltingK == null ? 'Not reported' : settings.temp(p.meltingK!),
            GuideId.meltingPoint,
          ),
          _Row(
            'Boiling point',
            p.boilingK == null ? 'Not reported' : settings.temp(p.boilingK!),
            GuideId.boilingPoint,
          ),
          _Row(
            'Density',
            p.density == null ? 'Not reported' : _density(p.density!),
            GuideId.density,
          ),
          _Row(
            'Crystal lattice',
            e.lattice ?? 'Not reported',
            GuideId.crystalLattice,
          ),
        ],
      ),
      const SizedBox(height: 12),
      _Isotopes(element: e),
      const SizedBox(height: 12),
      _Spectra(element: e, settings: settings),
    ];
  }

  void _showReaction(BuildContext context, ElementRecord e, String depth) {
    final r = e.reaction!;
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Illustration of a known reaction',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '${r.reactants}  →  ${r.products}',
                style: Mono.of(context, size: 16),
              ),
              Text(r.conditions),
              const SizedBox(height: 8),
              Text(r.blurbs.at(depth)),
            ],
          ),
        );
      },
    );
  }
}

class _Reading {
  const _Reading(this.lede, this.body);

  final String lede;
  final List<String> body;
}

_Reading _reading(String text) {
  final parts = text
      .split(RegExp(r'\n\s*\n'))
      .map((part) => part.trim())
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.isEmpty) return const _Reading('', []);
  return _Reading(parts.first, parts.skip(1).toList());
}

String _percent(double? abundance) {
  if (abundance == null) return 'abundance not reported';
  final pct = abundance * 100;
  if (pct >= 1) return '${pct.toStringAsFixed(2)}%';
  if (pct >= 0.01) return '${pct.toStringAsFixed(3)}%';
  return '${pct.toStringAsFixed(4)}%';
}

String _ox(int value) {
  if (value > 0) return '+$value';
  if (value < 0) return '−${value.abs()}';
  return '0';
}

String _shellPlain(List<int> counts) {
  const names = [
    'first',
    'second',
    'third',
    'fourth',
    'fifth',
    'sixth',
    'seventh',
  ];
  String shell(int index) => index < names.length ? names[index] : 'next';
  if (counts.length == 1) {
    final n = counts.first;
    final word = n == 1 ? 'electron' : 'electrons';
    return '$n $word in the first shell';
  }
  return [
    for (var i = 0; i < counts.length; i++)
      '${counts[i]} in the ${shell(i)} shell',
  ].join(', ');
}

String _shells(List<int> counts) {
  const labels = ['K', 'L', 'M', 'N', 'O', 'P', 'Q'];
  return [
    for (var i = 0; i < counts.length; i++)
      '${i < labels.length ? labels[i] : 'n=${i + 1}'} ${counts[i]}',
  ].join(' · ');
}

String _weightKind(String kind) {
  return switch (kind) {
    'standard' => 'Standard atomic weight',
    'representative-isotope' => 'Representative isotope',
    _ => kind,
  };
}

String _mass(double value) {
  final text = value.toStringAsFixed(4);
  return text.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
}

String _trim(double value) {
  final text = value.toStringAsFixed(3);
  return text.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
}

String _density(double value) {
  if (value < 0.01) return '${value.toStringAsExponential(2)} g/cm³';
  return '${_trim(value)} g/cm³';
}

class _TriviaStoryPage extends StatelessWidget {
  const _TriviaStoryPage({required this.element, required this.story});

  final ElementRecord element;
  final TriviaStory story;

  @override
  Widget build(BuildContext context) {
    final paragraphs = story.story
        .split(RegExp(r'\n\s*\n'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty);
    return Scaffold(
      appBar: AppBar(title: Text(story.title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          Text(
            '${element.z}  ${element.name}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16),
          for (final paragraph in paragraphs) ...[
            Text(paragraph),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _ShellDiagram extends StatelessWidget {
  const _ShellDiagram({
    required this.element,
    required this.reducedMotion,
    required this.energyUnit,
    required this.depth,
  });

  final ElementRecord element;
  final bool reducedMotion;
  final String energyUnit;
  final String depth;

  @override
  Widget build(BuildContext context) {
    final beginner = depth == 'beginner';
    final full = ElectronCloud.expandedConfiguration(
      element.electronConfigFull,
    );
    final value = beginner
        ? _shellPlain(element.shellCounts)
        : (depth == 'advanced' ? full : element.electronConfig);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElectronForceGraph(
              atomicNumber: element.z,
              symbol: element.symbol,
              configuration: element.electronConfigFull,
              accent: ElementSpectrum.of(element.categoryId),
              reducedMotion: reducedMotion,
              energyUnit: energyUnit,
              depth: depth,
            ),
            const SizedBox(height: 16),
            Text(
              beginner ? 'Electrons' : 'Configuration',
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: beginner
                  ? Theme.of(context).textTheme.bodyMedium
                  : Mono.of(context, size: 14, weight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _UseCard extends StatelessWidget {
  const _UseCard({required this.use});

  final ApplicationNote use;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.65);
    final image = use.image;
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (image != null && image.isNotEmpty)
            Image.asset(
              image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(use.title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(use.body, style: const TextStyle(height: 1.4)),
                if (use.credit != null && use.credit!.trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    use.credit!,
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: muted),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Row {
  const _Row(this.label, this.value, this.guideId);
  final String label;
  final String value;
  final String guideId;
}

class _DataCard extends StatelessWidget {
  const _DataCard({required this.title, required this.rows});

  final String title;
  final List<_Row> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            for (final row in rows) _line(context, row),
          ],
        ),
      ),
    );
  }

  Widget _line(BuildContext context, _Row row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: PropertyLabel(label: row.label, guideId: row.guideId),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 6,
            child: Text(
              row.value,
              textAlign: TextAlign.end,
              style: Mono.of(context, size: 13, weight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _Isotopes extends StatelessWidget {
  const _Isotopes({required this.element});

  final ElementRecord element;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Isotopes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            if (element.isotopes.isEmpty)
              const Text('Not reported')
            else
              for (final iso in element.isotopes) ...[
                const Divider(height: 16),
                Text(
                  '${iso.a}${element.symbol}${iso.note == null || iso.note!.isEmpty ? '' : ' · ${iso.note}'}',
                  style: Mono.of(context, size: 14, weight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                _fact(context, 'Mass number', '${iso.a}', GuideId.massNumber),
                _fact(
                  context,
                  'Neutrons',
                  '${iso.neutrons(element.z)}',
                  GuideId.neutrons,
                ),
                _fact(
                  context,
                  'Mass',
                  '${_mass(iso.mass)} u',
                  GuideId.isotopicMass,
                ),
                _fact(
                  context,
                  'Spin',
                  iso.spin.isEmpty ? 'Not reported' : iso.spin,
                  GuideId.nuclearSpin,
                ),
                _fact(context, 'Stability', iso.stability, GuideId.stability),
                _fact(
                  context,
                  'Abundance',
                  iso.abundance == null
                      ? 'Not reported'
                      : _percent(iso.abundance),
                  GuideId.abundance,
                ),
                if (iso.halfLife != null)
                  _fact(context, 'Half-life', iso.halfLife!, GuideId.halfLife),
                if (iso.decay != null)
                  _fact(context, 'Decay', iso.decay!, GuideId.decay),
              ],
          ],
        ),
      ),
    );
  }

  Widget _fact(
    BuildContext context,
    String label,
    String value,
    String guideId,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PropertyLabel(
              label: label,
              guideId: guideId,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: Mono.of(context, size: 13, weight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _Spectra extends StatelessWidget {
  const _Spectra({required this.element, required this.settings});

  final ElementRecord element;
  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Spectrum', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (element.spectralLines.isEmpty)
              const Text('No spectral lines are stored for this element.')
            else
              for (final line in element.spectralLines) ...[
                Text(
                  line.id,
                  style: Mono.of(context, size: 14, weight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                _lineFact(
                  context,
                  'Wavelength',
                  '${_trim(line.nm)} nm',
                  GuideId.wavelength,
                ),
                _lineFact(
                  context,
                  'Energy',
                  settings.energyValue(line.eV),
                  GuideId.photonEnergy,
                ),
                _lineFact(
                  context,
                  'Frequency',
                  _hz(line.frequencyHz),
                  GuideId.frequency,
                ),
                if (line.transition.isNotEmpty)
                  _lineFact(
                    context,
                    'Transition',
                    line.transition,
                    GuideId.transition,
                  ),
                if (line.color.isNotEmpty)
                  Text('${line.spectrum} · ${line.color}'),
                const SizedBox(height: 10),
              ],
            if (element.glow != null) ...[
              PropertyLabel(
                label: 'Discharge',
                guideId: GuideId.discharge,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(element.glow!.text),
              if (element.glow!.kv != null) Text(element.glow!.kv!),
              const SizedBox(height: 8),
            ],
            if (element.astro != null) ...[
              PropertyLabel(
                label: 'Astrophysics',
                guideId: GuideId.astrophysics,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(element.astro!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _lineFact(
    BuildContext context,
    String label,
    String value,
    String guideId,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: PropertyLabel(label: label, guideId: guideId),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Mono.of(context, size: 13, weight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  String _hz(double hz) {
    if (hz >= 1e12) return '${(hz / 1e12).toStringAsFixed(2)} THz';
    if (hz >= 1e9) return '${(hz / 1e9).toStringAsFixed(2)} GHz';
    return '${hz.toStringAsExponential(2)} Hz';
  }
}

class _NarrativeCard extends StatelessWidget {
  const _NarrativeCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final paragraphs = body
        .split(RegExp(r'\n\s*\n'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final paragraph in paragraphs) ...[
              Text(paragraph),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _HowDiscovered extends StatelessWidget {
  const _HowDiscovered({required this.element, required this.body});

  final ElementRecord element;
  final String body;

  @override
  Widget build(BuildContext context) {
    final discovery = element.discovery;
    final year = discovery == null
        ? null
        : (discovery.year?.toString() ?? 'Antiquity');
    final paragraphs = body
        .split(RegExp(r'\n\s*\n'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How ${element.name} was discovered',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (year != null) ...[
              const SizedBox(height: 8),
              Text(
                year,
                style: Mono.of(context, size: 16, weight: FontWeight.w700),
              ),
            ],
            if (discovery != null && discovery.people.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(discovery.people),
            ],
            if (paragraphs.isNotEmpty) const SizedBox(height: 8),
            for (final paragraph in paragraphs) ...[
              Text(paragraph),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
