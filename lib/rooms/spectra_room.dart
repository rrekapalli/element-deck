import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../audio/sonify.dart';
import '../models/catalog.dart';
import '../providers/catalog_controller.dart';
import '../providers/selection_controller.dart';
import '../providers/settings_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/element_header.dart';

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
    final visible = lines
        .where((l) => l.nm >= _visMin && l.nm <= _visMax)
        .toList();
    selected ??= _preferVisible(lines);
    if (selected != null && !lines.any((l) => l.id == selected!.id)) {
      selected = _preferVisible(lines);
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        ElementHeader(element: e),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              'TARGET EMITTER',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const Spacer(),
            Text(
              'Dataset ${catalog.pack.sciencePins.join(", ")}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
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
                      label: Text('${catalog.pack.byZ(z)!.symbol} #$z'),
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
          height: 96,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                onTapDown: visible.isEmpty
                    ? null
                    : (d) {
                        final width = constraints.maxWidth <= 0
                            ? 1.0
                            : constraints.maxWidth;
                        final nm =
                            _visMin +
                            d.localPosition.dx / width * (_visMax - _visMin);
                        setState(() => selected = _nearest(visible, nm));
                      },
                child: CustomPaint(
                  painter: _StripPainter(visible, selected),
                  child: const SizedBox.expand(),
                ),
              );
            },
          ),
        ),
        if (visible.isNotEmpty)
          Slider(
            min: _visMin,
            max: _visMax,
            value: (selected?.nm ?? 550).clamp(_visMin, _visMax),
            onChanged: (v) => setState(() => selected = _nearest(visible, v)),
          ),
        Text(
          _stripCaption(e, lines, visible),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        if (lines.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Spectral lines',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          for (final line in lines)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              selected: selected?.id == line.id,
              title: Text(
                '${line.nm.toStringAsFixed(2)} nm',
                style: Mono.of(context, size: 14, weight: FontWeight.w700),
              ),
              subtitle: Text(
                [
                  if (line.transition.isNotEmpty) line.transition,
                  line.color,
                  if (line.nm < _visMin || line.nm > _visMax)
                    'outside 380–780 nm',
                ].join(' · '),
              ),
              trailing: Text(
                '${line.eV.toStringAsFixed(2)} eV',
                style: Mono.of(context, size: 12),
              ),
              onTap: () => setState(() => selected = line),
            ),
        ],
        if (selected != null) ...[
          const SizedBox(height: 8),
          Text(
            'Selected λ  ${selected!.nm} nm',
            style: Mono.of(context, size: 14),
          ),
          Text(
            'ν  ${(selected!.frequencyHz / 1e12).toStringAsFixed(2)} THz · ${selected!.color}',
          ),
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
                  : 'Sound is off in App Config',
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
        Text(
          'Isotopes & decay modes',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        for (final iso in e.isotopes)
          ListTile(
            dense: true,
            title: Text(
              '${iso.a}${e.symbol}  ·  ${iso.neutrons(e.z)} n',
              style: Mono.of(context, size: 13),
            ),
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

const _visMin = 380.0;
const _visMax = 780.0;

SpectralLine? _preferVisible(List<SpectralLine> lines) {
  for (final line in lines) {
    if (line.nm >= _visMin && line.nm <= _visMax) return line;
  }
  return lines.isEmpty ? null : lines.first;
}

SpectralLine _nearest(List<SpectralLine> lines, double nm) {
  var best = lines.first;
  var score = double.infinity;
  for (final line in lines) {
    final d = (line.nm - nm).abs();
    if (d < score) {
      score = d;
      best = line;
    }
  }
  return best;
}

String _stripCaption(
  ElementRecord e,
  List<SpectralLine> lines,
  List<SpectralLine> visible,
) {
  if (lines.isEmpty) {
    return 'No spectral lines are stored for ${e.name}.';
  }
  if (visible.isEmpty) {
    return 'Stored lines for ${e.name} are outside the 380–780 nm window.';
  }
  final noun = visible.length == 1 ? 'line' : 'lines';
  return 'Visible window 380–780 nm · ${visible.length} $noun. The scrubber stops on stored lines.';
}

Color _lineColor(double nm) {
  if (nm < 420) return const Color(0xFF7C3AED);
  if (nm < 450) return const Color(0xFF2563EB);
  if (nm < 495) return const Color(0xFF0891B2);
  if (nm < 570) return const Color(0xFF22C55E);
  if (nm < 590) return const Color(0xFFFACC15);
  if (nm < 620) return const Color(0xFFF97316);
  return const Color(0xFFEF4444);
}

class _StripPainter extends CustomPainter {
  _StripPainter(this.lines, this.selected);

  final List<SpectralLine> lines;
  final SpectralLine? selected;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFF0B1220);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );
    if (lines.isEmpty || size.width <= 0) return;
    for (final line in lines) {
      final x = (line.nm - _visMin) / (_visMax - _visMin) * size.width;
      final chosen = line.id == selected?.id;
      final color = _lineColor(line.nm);
      final glow = Paint()
        ..color = color.withValues(alpha: chosen ? 0.55 : 0.28)
        ..strokeWidth = chosen ? 8 : 5
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
      final core = Paint()
        ..color = chosen ? Colors.white : color
        ..strokeWidth = chosen ? 2.5 : 1.8
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(x, 10), Offset(x, size.height - 10), glow);
      canvas.drawLine(Offset(x, 8), Offset(x, size.height - 8), core);
    }
  }

  @override
  bool shouldRepaint(covariant _StripPainter oldDelegate) => true;
}
