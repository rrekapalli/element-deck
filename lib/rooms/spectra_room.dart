import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../audio/sonify.dart';
import '../models/catalog.dart';
import '../providers/catalog_controller.dart';
import '../providers/selection_controller.dart';
import '../providers/settings_controller.dart';
import '../theme/app_theme.dart';

class SpectraRoom extends StatefulWidget {
  const SpectraRoom({super.key});

  @override
  State<SpectraRoom> createState() => _SpectraRoomState();
}

class _SpectraRoomState extends State<SpectraRoom> {
  String mode = 'emission';
  SpectralLine? selected;
  final sonify = Sonify();

  @override
  void dispose() {
    sonify.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogController>();
    final sel = context.watch<SelectionController>();
    final settings = context.watch<SettingsController>();
    final e = sel.current ?? catalog.pack.elements.first;
    final lines = e.spectralLines
        .where((l) => l.spectrum == 'both' || l.spectrum == mode)
        .toList();
    selected ??= lines.isEmpty ? null : lines.first;
    if (selected != null && !lines.any((l) => l.id == selected!.id)) {
      selected = lines.isEmpty ? null : lines.first;
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        Row(
          children: [
            Text('TARGET EMITTER', style: Theme.of(context).textTheme.labelSmall),
            const Spacer(),
            Text('Dataset ${catalog.pack.sciencePins.join(", ")}',
                style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final z in {e.z, ...sel.recents}.take(8))
                if (catalog.pack.byZ(z) != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      selected: z == e.z,
                      label: Text(
                        '${catalog.pack.byZ(z)!.symbol} #$z',
                      ),
                      onSelected: (_) => sel.select(z),
                    ),
                  ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'emission', label: Text('Emission')),
            ButtonSegment(value: 'absorption', label: Text('Absorption')),
          ],
          selected: {mode},
          onSelectionChanged: (s) => setState(() => mode = s.first),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 88,
          child: CustomPaint(
            painter: _StripPainter(lines, selected),
            child: GestureDetector(
              onTapDown: (d) {
                if (lines.isEmpty) return;
                final box = context.findRenderObject() as RenderBox?;
                if (box == null) return;
              },
            ),
          ),
        ),
        Slider(
          min: 380,
          max: 750,
          value: (selected?.nm ?? 500).clamp(380, 750),
          onChanged: lines.isEmpty
              ? null
              : (v) {
                  SpectralLine nearest = lines.first;
                  var best = 1e9;
                  for (final l in lines) {
                    final d = (l.nm - v).abs();
                    if (d < best) {
                      best = d;
                      nearest = l;
                    }
                  }
                  setState(() => selected = nearest);
                },
        ),
        Text('Wavelength scrubber · stops only on stored lines',
            style: Theme.of(context).textTheme.bodySmall),
        if (selected != null) ...[
          const SizedBox(height: 8),
          Text('Selected λ  ${selected!.nm} nm', style: Mono.of(context, size: 14)),
          Text('ν  ${(selected!.frequencyHz / 1e12).toStringAsFixed(2)} THz · ${selected!.color}'),
          Text('E  ${selected!.eV} eV'),
          if (settings.depth == 'advanced')
            Text(selected!.transition, style: Mono.of(context, size: 12)),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: settings.sonification
                ? () => sonify.playHz(selected!.audibleHz)
                : null,
            icon: const Icon(Icons.volume_up),
            label: Text(
              settings.sonification
                  ? (settings.depth == 'beginner'
                      ? 'Play the color as a tone'
                      : 'Listen to spectral frequency (${(selected!.frequencyHz / 1e12).toStringAsFixed(2)} THz sonified)')
                  : 'Sound is off in App settings',
            ),
          ),
        ],
        if (e.glow != null) ...[
          const SizedBox(height: 16),
          Card(
            color: Color(int.parse(e.glow!.color.replaceFirst('#', '0xFF'))),
            child: ListTile(
              title: const Text('Characteristic Glow'),
              subtitle: Text(e.glow!.text),
              trailing: Text(e.glow!.kv ?? ''),
            ),
          ),
        ],
        if (e.astro != null) ...[
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.travel_explore),
            title: const Text('Astrophysical match'),
            subtitle: Text(e.astro!),
          ),
        ],
        const SizedBox(height: 12),
        Text('Isotopes & decay modes', style: Theme.of(context).textTheme.titleMedium),
        for (final iso in e.isotopes)
          ListTile(
            dense: true,
            title: Text('${iso.a}${e.symbol}  ·  ${iso.neutrons(e.z)} n',
                style: Mono.of(context, size: 13)),
            subtitle: Text(
              [
                'mass ${iso.mass} u',
                if (iso.spin.isNotEmpty) 'spin ${iso.spin}',
                if (iso.abundance != null)
                  '${(iso.abundance! * 100).toStringAsFixed(2)}%',
                if (iso.halfLife != null) 't½ ${iso.halfLife}',
                iso.stability,
                iso.note ?? '',
              ].join(' · '),
            ),
          ),
        const SizedBox(height: 12),
        Text(
          'Pack ${catalog.pack.version} · noble-gas tile color is not the neon discharge glow.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _StripPainter extends CustomPainter {
  _StripPainter(this.lines, this.selected);

  final List<SpectralLine> lines;
  final SpectralLine? selected;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..shader = const LinearGradient(colors: [
      Color(0xFF4C1D95),
      Color(0xFF1D4ED8),
      Color(0xFF059669),
      Color(0xFFFBBF24),
      Color(0xFFEF4444),
    ]).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );
    for (final l in lines) {
      if (l.nm < 380 || l.nm > 750) continue;
      final x = (l.nm - 380) / (750 - 380) * size.width;
      final p = Paint()
        ..color = l.id == selected?.id ? Colors.white : Colors.white70
        ..strokeWidth = l.id == selected?.id ? 3 : 1.5;
      canvas.drawLine(Offset(x, 8), Offset(x, size.height - 8), p);
    }
  }

  @override
  bool shouldRepaint(covariant _StripPainter oldDelegate) => true;
}
