import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/catalog.dart';
import '../models/periodic_layout.dart';
import '../providers/catalog_controller.dart';
import '../providers/selection_controller.dart';
import '../providers/settings_controller.dart';
import '../theme/app_theme.dart';
import '../theme/element_spectrum.dart';
import '../widgets/depth_control.dart';
import '../widgets/electron_force_graph.dart';

class DetailsRoom extends StatelessWidget {
  const DetailsRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogController>();
    final sel = context.watch<SelectionController>();
    final settings = context.watch<SettingsController>();
    final e = sel.current;
    if (e == null) {
      final id = PeriodicLayout.element(sel.currentZ);
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          const DepthControl(),
          const SizedBox(height: 24),
          Text(
            id == null ? 'Element ${sel.currentZ}' : '${id.z}  ${id.name}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (id != null)
            Text(id.symbol, style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 12),
          const Text('In the full pack'),
          Text(
            catalog.isPreview
                ? 'This preview includes hydrogen, carbon, neon, silicon, and titanium.'
                : 'Not in the downloaded catalog.',
          ),
        ],
      );
    }
    final accent = ElementSpectrum.of(e.categoryId);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        if (e.isotopes.isNotEmpty)
          Text(
            'Stable isotope · ${e.isotopes.first.a}${e.symbol}  (${(e.isotopes.first.abundance ?? 0) * 100}%)',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        const DepthControl(),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              e.symbol,
              style: Theme.of(context).textTheme.displayMedium
                  ?.copyWith(color: accent, fontWeight: FontWeight.w800),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${e.z}  ${e.name}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    '${e.atomicWeight} u · ${e.weightKind}',
                    style: Mono.of(context, size: 12),
                  ),
                  Text(
                    '${e.categoryLabel} · ${e.block}-block · Period ${e.period} · Grp ${e.group ?? "—"}',
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                sel.bookmarks.contains(e.z)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: () => sel.toggleBookmark(e.z),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ShellDiagram(
          element: e,
          shorthand: settings.configShorthand,
          reducedMotion: settings.reducedMotion,
          energyUnit: settings.energy,
        ),
        const SizedBox(height: 12),
        _Metrics(element: e, settings: settings),
        const SizedBox(height: 12),
        _Phase(element: e, settings: settings),
        if (e.discovery != null) ...[
          const SizedBox(height: 12),
          _Discovery(e.discovery!),
        ],
        if (e.applications.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            'Primary technological applications',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          for (final a in e.applications)
            ListTile(title: Text(a.title), subtitle: Text(a.body)),
        ],
        const SizedBox(height: 12),
        _Curriculum(
          element: e,
          depth: settings.depth,
          onPick: settings.setDepth,
        ),
        if (e.reaction != null) ...[
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => _showReaction(context, e, settings.depth),
            child: const Text('Simulate Reaction'),
          ),
        ],
      ],
    );
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

class _ShellDiagram extends StatelessWidget {
  const _ShellDiagram({
    required this.element,
    required this.shorthand,
    required this.reducedMotion,
    required this.energyUnit,
  });

  final ElementRecord element;
  final bool shorthand;
  final bool reducedMotion;
  final String energyUnit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Column(
          children: [
            ElectronForceGraph(
              atomicNumber: element.z,
              symbol: element.symbol,
              configuration: element.electronConfigFull,
              accent: ElementSpectrum.of(element.categoryId),
              reducedMotion: reducedMotion,
              energyUnit: energyUnit,
            ),
            const SizedBox(height: 8),
            Text(
              element.configFor(shorthand: shorthand),
              style: Mono.of(context, size: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metrics extends StatelessWidget {
  const _Metrics({required this.element, required this.settings});

  final ElementRecord element;
  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    final p = element.properties;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quantum Metrics',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _kv(
                  context,
                  'Configuration',
                  element.configFor(shorthand: settings.configShorthand),
                ),
                _kv(
                  context,
                  'Oxidation',
                  element.oxidationStates
                      .map((e) => e > 0 ? '+$e' : '$e')
                      .join(', '),
                ),
                _kv(
                  context,
                  'Radius',
                  p.covalentRadiusPm == null
                      ? null
                      : settings.lengthValue(p.covalentRadiusPm!),
                ),
                _kv(context, 'Electronegativity', p.paulingEn?.toString()),
                _kv(
                  context,
                  'Ionization',
                  p.ionizationEv == null
                      ? null
                      : settings.energyValue(p.ionizationEv!),
                ),
              ].map((e) => SizedBox(width: 150, child: e)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kv(BuildContext context, String k, String? val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          k.toUpperCase(),
          style: Mono.of(context, size: 9, color: Theme.of(context).hintColor),
        ),
        Text(
          val ?? 'Not reported',
          style: Mono.of(context, size: 14, weight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _Phase extends StatelessWidget {
  const _Phase({required this.element, required this.settings});

  final ElementRecord element;
  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    final p = element.properties;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thermal Phase Profile',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (p.meltingK != null)
              Text('Melting  ${settings.temp(p.meltingK!)}'),
            if (p.boilingK != null)
              Text('Boiling  ${settings.temp(p.boilingK!)}'),
            if (element.lattice != null) Text('Lattice  ${element.lattice}'),
            if (p.density != null) Text('Density  ${p.density} g/cm³'),
          ],
        ),
      ),
    );
  }
}

class _Discovery extends StatelessWidget {
  const _Discovery(this.d);
  final Discovery d;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Discovery genesis ${d.year ?? ""}'),
        subtitle: Text('${d.people}\n${d.text}'),
      ),
    );
  }
}

class _Curriculum extends StatelessWidget {
  const _Curriculum({
    required this.element,
    required this.depth,
    required this.onPick,
  });

  final ElementRecord element;
  final String depth;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Curriculum & Depth Profiles',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            for (final d in ['beginner', 'intermediate', 'advanced'])
              ListTile(
                selected: d == depth,
                title: Text(d[0].toUpperCase() + d.substring(1)),
                subtitle: Text(element.curriculum.at(d)),
                onTap: () => onPick(d),
              ),
          ],
        ),
      ),
    );
  }
}
