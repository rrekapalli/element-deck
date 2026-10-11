import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/catalog.dart';
import '../models/orbital_force.dart';
import '../models/periodic_layout.dart';
import '../providers/selection_controller.dart';
import '../providers/settings_controller.dart';
import '../theme/app_theme.dart';
import '../theme/element_spectrum.dart';
import '../widgets/electron_force_graph.dart';
import '../widgets/element_header.dart';

enum _DossierTab { details, history, data }

class DetailsRoom extends StatefulWidget {
  const DetailsRoom({super.key});

  @override
  State<DetailsRoom> createState() => _DetailsRoomState();
}

class _DetailsRoomState extends State<DetailsRoom> {
  _DossierTab _tab = _DossierTab.details;
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _selectTab(_DossierTab tab) {
    setState(() => _tab = tab);
    if (_scroll.hasClients) _scroll.jumpTo(0);
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
      child: ListView(
        controller: _scroll,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          _DossierTabs(tab: _tab, onChanged: _selectTab),
          const SizedBox(height: 8),
          Text(_caption(_tab), style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          ...switch (_tab) {
            _DossierTab.details => _details(context, e, settings),
            _DossierTab.history => _history(context, e),
            _DossierTab.data => _data(context, e, settings),
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
    return [
      Text(e.summary.intermediate),
      const SizedBox(height: 12),
      _ShellDiagram(
        element: e,
        reducedMotion: settings.reducedMotion,
        energyUnit: settings.energy,
      ),
      if (e.applications.isNotEmpty) ...[
        const SizedBox(height: 12),
        Text('Uses', style: Theme.of(context).textTheme.titleMedium),
        for (final a in e.applications)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(a.title),
            subtitle: Text(a.body),
          ),
      ],
      if (e.reaction != null) ...[
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () => _showReaction(context, e),
          child: const Text('Simulate Reaction'),
        ),
      ],
    ];
  }

  List<Widget> _history(BuildContext context, ElementRecord e) {
    final narrative = e.history.trim().isNotEmpty
        ? e.history.trim()
        : (e.discovery?.text ??
              'History for this element is not in the pack yet.');
    final paragraphs = narrative
        .split(RegExp(r'\n\s*\n'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty);
    return [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'History of ${e.name}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              for (final p in paragraphs) ...[
                Text(p),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
      if (e.discovery != null) ...[
        const SizedBox(height: 12),
        _Discovery(e.discovery!),
      ],
    ];
  }

  List<Widget> _data(
    BuildContext context,
    ElementRecord e,
    SettingsController settings,
  ) {
    final p = e.properties;
    return [
      _DataCard(
        title: 'Identity',
        rows: [
          _Row('Atomic number', '${e.z}'),
          _Row('Symbol', e.symbol),
          _Row('Name', e.name),
          _Row('Protons', '${e.z}'),
          _Row('Electrons', '${e.z}'),
          _Row('Atomic weight', '${_mass(e.atomicWeight)} u'),
          _Row('Weight basis', _weightKind(e.weightKind)),
          _Row('Category', e.categoryLabel),
          if (e.tags.isNotEmpty) _Row('Tags', e.tags.join(', ')),
          _Row('Block', '${e.block}-block'),
          _Row('Period', '${e.period}'),
          _Row('Group', e.group?.toString() ?? 'f-block row'),
          _Row('Standard state', e.standardState),
          _Row('Dataset', e.sourceId),
        ],
      ),
      const SizedBox(height: 12),
      _DataCard(
        title: 'Electrons',
        rows: [
          _Row(
            'Configuration',
            ElectronCloud.expandedConfiguration(e.electronConfigFull),
          ),
          if (e.electronConfig !=
              ElectronCloud.expandedConfiguration(e.electronConfigFull))
            _Row('Shorthand', e.electronConfig),
          _Row('Shells', _shells(e.shellCounts)),
          _Row(
            'Oxidation states',
            e.oxidationStates.isEmpty
                ? 'Not reported'
                : e.oxidationStates.map(_ox).join(', '),
          ),
          _Row(
            'Primary oxidation',
            e.primaryOxidation == null
                ? 'Not reported'
                : _ox(e.primaryOxidation!),
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
          ),
          _Row(
            'Electronegativity',
            p.paulingEn == null
                ? 'Not reported'
                : '${_trim(p.paulingEn!)} Pauling',
          ),
          _Row(
            'First ionization',
            p.ionizationEv == null
                ? 'Not reported'
                : settings.energyValue(p.ionizationEv!),
          ),
          _Row(
            'Melting point',
            p.meltingK == null ? 'Not reported' : settings.temp(p.meltingK!),
          ),
          _Row(
            'Boiling point',
            p.boilingK == null ? 'Not reported' : settings.temp(p.boilingK!),
          ),
          _Row(
            'Density',
            p.density == null ? 'Not reported' : _density(p.density!),
          ),
          _Row('Crystal lattice', e.lattice ?? 'Not reported'),
        ],
      ),
      const SizedBox(height: 12),
      _Isotopes(element: e),
      const SizedBox(height: 12),
      _Spectra(element: e, settings: settings),
    ];
  }

  void _showReaction(BuildContext context, ElementRecord e) {
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
              Text(r.blurbs.intermediate),
            ],
          ),
        );
      },
    );
  }
}

String _caption(_DossierTab tab) {
  return switch (tab) {
    _DossierTab.details =>
      'What it is, how the electrons sit, and where you meet it.',
    _DossierTab.history =>
      'Who found it, how it was named, and how it entered science.',
    _DossierTab.data =>
      'Compiled scientific values for this element. Units follow App Config.',
  };
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

class _DossierTabs extends StatelessWidget {
  const _DossierTabs({required this.tab, required this.onChanged});

  final _DossierTab tab;
  final ValueChanged<_DossierTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const tabs = _DossierTab.values;
    const labels = ['Details', 'History', 'Data'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(
              child: InkWell(
                onTap: () => onChanged(tabs[i]),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: tab == tabs[i]
                        ? scheme.primary.withValues(alpha: 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    labels[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: tab == tabs[i]
                          ? scheme.primary
                          : scheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
            ),
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
  });

  final ElementRecord element;
  final bool reducedMotion;
  final String energyUnit;

  @override
  Widget build(BuildContext context) {
    final full = ElectronCloud.expandedConfiguration(
      element.electronConfigFull,
    );
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
            ),
            const SizedBox(height: 16),
            Text(
              'Configuration',
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              full,
              style: Mono.of(context, size: 14, weight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row {
  const _Row(this.label, this.value);
  final String label;
  final String value;
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
    final muted = Theme.of(context).colorScheme.onSurface
        .withValues(alpha: 0.65);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(row.label, style: TextStyle(color: muted)),
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
                _fact(context, 'Mass number', '${iso.a}'),
                _fact(context, 'Neutrons', '${iso.neutrons(element.z)}'),
                _fact(context, 'Mass', '${_mass(iso.mass)} u'),
                _fact(
                  context,
                  'Spin',
                  iso.spin.isEmpty ? 'Not reported' : iso.spin,
                ),
                _fact(context, 'Stability', iso.stability),
                _fact(
                  context,
                  'Abundance',
                  iso.abundance == null
                      ? 'Not reported'
                      : _percent(iso.abundance),
                ),
                if (iso.halfLife != null)
                  _fact(context, 'Half-life', iso.halfLife!),
                if (iso.decay != null) _fact(context, 'Decay', iso.decay!),
              ],
          ],
        ),
      ),
    );
  }

  Widget _fact(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label)),
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
                Text('Wavelength  ${_trim(line.nm)} nm'),
                Text('Energy  ${settings.energyValue(line.eV)}'),
                Text('Frequency  ${_hz(line.frequencyHz)}'),
                if (line.transition.isNotEmpty) Text(line.transition),
                if (line.color.isNotEmpty)
                  Text('${line.spectrum} · ${line.color}'),
                const SizedBox(height: 10),
              ],
            if (element.glow != null) ...[
              Text('Discharge', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(element.glow!.text),
              if (element.glow!.kv != null) Text(element.glow!.kv!),
              const SizedBox(height: 8),
            ],
            if (element.astro != null) ...[
              Text(
                'Astrophysics',
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

  String _hz(double hz) {
    if (hz >= 1e12) return '${(hz / 1e12).toStringAsFixed(2)} THz';
    if (hz >= 1e9) return '${(hz / 1e9).toStringAsFixed(2)} GHz';
    return '${hz.toStringAsExponential(2)} Hz';
  }
}

class _Discovery extends StatelessWidget {
  const _Discovery(this.d);
  final Discovery d;

  @override
  Widget build(BuildContext context) {
    final year = d.year?.toString() ?? 'Antiquity';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Discovery', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              year,
              style: Mono.of(context, size: 16, weight: FontWeight.w700),
            ),
            if (d.people.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(d.people),
            ],
            if (d.text.isNotEmpty) ...[const SizedBox(height: 8), Text(d.text)],
          ],
        ),
      ),
    );
  }
}
