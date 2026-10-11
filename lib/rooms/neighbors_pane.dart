import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../models/catalog.dart';
import '../providers/catalog_controller.dart';
import '../providers/selection_controller.dart';
import '../providers/settings_controller.dart';
import '../theme/app_theme.dart';
import '../theme/element_spectrum.dart';

class NeighborsPane extends StatelessWidget {
  const NeighborsPane({super.key, required this.element});

  final ElementRecord element;

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogController>();
    final sel = context.watch<SelectionController>();
    final settings = context.watch<SettingsController>();
    var aZ = sel.compareA;
    var bZ = sel.compareB;
    if (aZ != element.z && bZ != element.z) {
      aZ = element.z;
      bZ = sel.suggestedNeighbor(element.z);
    }
    final a = catalog.pack.byZ(aZ);
    final b = catalog.pack.byZ(bZ);
    if (a == null || b == null) {
      return const Text('Pick two elements that are in this catalog.');
    }
    TrendNote? note;
    for (final n in catalog.pack.trendNotes) {
      if (n.matches(a.z, b.z)) note = n;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Neighbors', style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _Head(element: a, onPick: (z) => sel.setPair(z, b.z))),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('VS'),
            ),
            Expanded(child: _Head(element: b, onPick: (z) => sel.setPair(a.z, z))),
          ],
        ),
        const SizedBox(height: 16),
        Text('Physical & Quantum Metrics', style: Theme.of(context).textTheme.titleMedium),
        _metric(context, 'Atomic radius', a.properties.covalentRadiusPm, b.properties.covalentRadiusPm, (v) => settings.lengthValue(v), biggerMeans: 'larger'),
        _metric(context, 'Pauling electronegativity', a.properties.paulingEn, b.properties.paulingEn, (v) => v.toStringAsFixed(2), biggerMeans: 'higher'),
        _metric(context, '1st ionization energy', a.properties.ionizationEv, b.properties.ionizationEv, settings.energyValue, biggerMeans: 'higher'),
        _metric(context, 'Melting point', a.properties.meltingK, b.properties.meltingK, settings.temp, biggerMeans: 'higher'),
        _metric(context, 'Density', a.properties.density, b.properties.density, (v) => '${v.toStringAsFixed(2)} g/cm³', biggerMeans: 'denser'),
        const SizedBox(height: 12),
        Text('Group trend breakdown', style: Theme.of(context).textTheme.titleMedium),
        Text(
          note?.essayFor(settings.depth) ?? 'No written trend for this pair yet.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        if (note != null)
          Wrap(
            spacing: 8,
            children: [
              for (final z in note.swaps)
                if (catalog.pack.byZ(z) != null)
                  ActionChip(
                    label: Text('Compare with ${catalog.pack.byZ(z)!.symbol}'),
                    onPressed: () => sel.setPair(a.z, z),
                  ),
            ],
          ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () async {
            await sel.saveCurrentComparison();
            await _exportPdf(a, b, note, settings);
          },
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('Export Comparison Dossier (PDF)'),
        ),
      ],
    );
  }

  Widget _metric(
    BuildContext context,
    String label,
    double? left,
    double? right,
    String Function(double) fmt, {
    required String biggerMeans,
  }) {
    String delta() {
      if (left == null || right == null) return 'Not reported';
      final d = ((right - left) / left) * 100;
      final sign = d >= 0 ? '+' : '';
      return '$sign${d.toStringAsFixed(1)}% $biggerMeans';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: Mono.of(context, size: 10)),
          Row(
            children: [
              Expanded(child: Text(left == null ? 'Not reported' : fmt(left))),
              Expanded(child: Text(right == null ? 'Not reported' : fmt(right), textAlign: TextAlign.right)),
            ],
          ),
          Text(delta(), style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Future<void> _exportPdf(
    ElementRecord a,
    ElementRecord b,
    TrendNote? note,
    SettingsController settings,
  ) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Element Deck comparison'),
            pw.Text('${a.symbol} vs ${b.symbol}'),
            pw.SizedBox(height: 12),
            pw.Text(note?.essayFor(settings.depth) ?? 'No written trend for this pair yet.'),
            pw.SizedBox(height: 12),
            pw.Text('Teaching copy. Not a lab measurement. Dataset compiled-v1.4.'),
          ],
        ),
      ),
    );
    await Printing.layoutPdf(onLayout: (_) => doc.save());
  }
}

class _Head extends StatelessWidget {
  const _Head({required this.element, required this.onPick});

  final ElementRecord element;
  final ValueChanged<int> onPick;

  @override
  Widget build(BuildContext context) {
    final catalog = context.read<CatalogController>();
    return Card(
      child: InkWell(
        onTap: () async {
          final z = await showModalBottomSheet<int>(
            context: context,
            builder: (context) {
              return ListView(
                children: [
                  for (final e in catalog.pack.elements)
                    ListTile(
                      title: Text('${e.symbol}  ${e.name}'),
                      onTap: () => Navigator.pop(context, e.z),
                    ),
                ],
              );
            },
          );
          if (z != null) onPick(z);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                element.symbol,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ElementSpectrum.of(element.categoryId),
                    ),
              ),
              Text('${element.z} ${element.name}'),
              Text(element.categoryLabel, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
