import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../audio/sonify.dart';
import '../models/catalog.dart';
import '../providers/catalog_controller.dart';
import '../providers/selection_controller.dart';
import '../providers/settings_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/element_header.dart';
import 'spectra_details.dart';

class SpectraRoom extends StatefulWidget {
  const SpectraRoom({super.key});

  @override
  State<SpectraRoom> createState() => _SpectraRoomState();
}

class _SpectraRoomState extends State<SpectraRoom>
    with SingleTickerProviderStateMixin {
  static const _labels = ['Spectra', 'Details'];

  String mode = 'emission';
  SpectralLine? selected;
  final sonify = Sonify();
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
          if (_index == 0) ...[
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
              height: 120,
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
                                d.localPosition.dx /
                                    width *
                                    (_visMax - _visMin);
                            setState(() => selected = _nearest(visible, nm));
                          },
                    child: CustomPaint(
                      painter: _StripPainter(
                        lines: visible,
                        selected: selected,
                        emission: mode == 'emission',
                        emptyLabel: lines.isEmpty
                            ? 'No catalogued lines'
                            : 'No lines in 380–780 nm',
                      ),
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
                onChanged: (v) =>
                    setState(() => selected = _nearest(visible, v)),
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
                  minLeadingWidth: 20,
                  horizontalTitleGap: 12,
                  selected: selected?.id == line.id,
                  leading: ExcludeSemantics(
                    child: _SpectralTick(
                      nm: line.nm,
                      bright: selected?.id == line.id,
                      emission: mode == 'emission',
                    ),
                  ),
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
                color: Color(
                  int.parse(e.glow!.color.replaceFirst('#', '0xFF')),
                ),
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
          ] else
            ...spectraDetailChildren(
              context: context,
              element: e,
              packVersion: catalog.pack.version,
            ),
        ],
      ),
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
  _StripPainter({
    required this.lines,
    required this.selected,
    required this.emission,
    required this.emptyLabel,
  });

  final List<SpectralLine> lines;
  final SpectralLine? selected;
  final bool emission;
  final String emptyLabel;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final bounds = Offset.zero & size;
    final clip = RRect.fromRectAndRadius(bounds, const Radius.circular(12));
    canvas.save();
    canvas.clipRRect(clip);
    if (lines.isEmpty) {
      canvas.drawRect(bounds, Paint()..color = const Color(0xFFE8EEF6));
      _axis(canvas, size, const Color(0xFF64748B));
      _centerLabel(canvas, size, emptyLabel, const Color(0xFF3E5674));
    } else if (emission) {
      canvas.drawRect(bounds, Paint()..color = const Color(0xFF0B1220));
      _axis(canvas, size, const Color(0xFF94A3B8));
      _marks(canvas, size, bright: true);
    } else {
      _rainbow(canvas, size);
      _axis(canvas, size, const Color(0xFF0B1B33));
      _marks(canvas, size, bright: false);
    }
    canvas.restore();
    canvas.drawRRect(
      clip,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = const Color(0x660B1B33),
    );
  }

  void _rainbow(Canvas canvas, Size size) {
    const steps = 72;
    for (var i = 0; i < steps; i++) {
      final t = i / steps;
      canvas.drawRect(
        Rect.fromLTWH(t * size.width, 0, size.width / steps + 0.6, size.height),
        Paint()..color = _spectrumAt(t),
      );
    }
  }

  void _marks(Canvas canvas, Size size, {required bool bright}) {
    final ordered = [...lines]..sort((a, b) => a.nm.compareTo(b.nm));
    final labelAll = ordered.length <= 5;
    var lastRight = -100.0;
    for (final line in ordered) {
      final x = (line.nm - _visMin) / (_visMax - _visMin) * size.width;
      final chosen = line.id == selected?.id;
      final ink = _lineColor(line.nm);
      final top = 10.0;
      final bottom = size.height - 22;
      if (bright) {
        canvas.drawLine(
          Offset(x, top),
          Offset(x, bottom),
          Paint()
            ..color = ink.withValues(alpha: 0.45)
            ..strokeWidth = chosen ? 12 : 8
            ..strokeCap = StrokeCap.round,
        );
        canvas.drawLine(
          Offset(x, top),
          Offset(x, bottom),
          Paint()
            ..color = ink
            ..strokeWidth = chosen ? 4 : 2.5
            ..strokeCap = StrokeCap.round,
        );
        canvas.drawLine(
          Offset(x, top),
          Offset(x, bottom),
          Paint()
            ..color = Colors.white
            ..strokeWidth = chosen ? 1.6 : 1
            ..strokeCap = StrokeCap.round,
        );
      } else {
        canvas.drawLine(
          Offset(x, 6),
          Offset(x, size.height - 20),
          Paint()
            ..color = const Color(0xFF0B1220)
            ..strokeWidth = chosen ? 7 : 4
            ..strokeCap = StrokeCap.butt,
        );
      }
      if (!chosen && !labelAll) continue;
      final label = line.nm.toStringAsFixed(0);
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: bright ? Colors.white : const Color(0xFF0B1B33),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final left = (x - tp.width / 2).clamp(4.0, size.width - tp.width - 4);
      if (!chosen && left < lastRight + 4) continue;
      tp.paint(canvas, Offset(left, size.height - 16));
      lastRight = left + tp.width;
    }
  }

  void _axis(Canvas canvas, Size size, Color color) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (final nm in [400, 500, 600, 700]) {
      final x = (nm - _visMin) / (_visMax - _visMin) * size.width;
      canvas.drawLine(Offset(x, 6), Offset(x, 12), paint);
    }
  }

  void _centerLabel(Canvas canvas, Size size, String text, Color color) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 24);
    tp.paint(
      canvas,
      Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2 - 6),
    );
  }

  @override
  bool shouldRepaint(covariant _StripPainter oldDelegate) => true;
}

/// A short sample of the same vertical mark drawn on the spectrum strip.
class _SpectralTick extends StatelessWidget {
  const _SpectralTick({
    required this.nm,
    required this.bright,
    required this.emission,
  });

  final double nm;
  final bool bright;
  final bool emission;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 34,
      child: CustomPaint(
        painter: _SpectralTickPainter(
          nm: nm,
          bright: bright,
          emission: emission,
        ),
      ),
    );
  }
}

class _SpectralTickPainter extends CustomPainter {
  _SpectralTickPainter({
    required this.nm,
    required this.bright,
    required this.emission,
  });

  final double nm;
  final bool bright;
  final bool emission;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final plate = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(5),
    );
    final visible = nm >= _visMin && nm <= _visMax;
    canvas.save();
    canvas.clipRRect(plate);
    if (emission || !visible) {
      canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFF0B1220));
      _emission(canvas, size, visible: visible);
    } else {
      _rainbow(canvas, size);
      final x = size.width / 2;
      canvas.drawLine(
        Offset(x, 3),
        Offset(x, size.height - 3),
        Paint()
          ..color = const Color(0xFF0B1220)
          ..strokeWidth = bright ? 4.5 : 3,
      );
    }
    canvas.restore();
    canvas.drawRRect(
      plate,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = bright ? 1.4 : 1
        ..color = bright
            ? _lineColor(nm).withValues(alpha: visible ? 0.9 : 0.45)
            : const Color(0x55FFFFFF),
    );
  }

  void _emission(Canvas canvas, Size size, {required bool visible}) {
    final ink = _lineColor(nm);
    final x = size.width / 2;
    final top = 5.0;
    final bottom = size.height - 5;
    final strength = visible ? 1.0 : 0.62;
    canvas.drawLine(
      Offset(x, top),
      Offset(x, bottom),
      Paint()
        ..color = ink.withValues(alpha: 0.42 * strength)
        ..strokeWidth = bright ? 10 : 7
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      Offset(x, top),
      Offset(x, bottom),
      Paint()
        ..color = ink.withValues(alpha: strength)
        ..strokeWidth = bright ? 3.2 : 2.2
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      Offset(x, top),
      Offset(x, bottom),
      Paint()
        ..color = Colors.white.withValues(alpha: visible ? 0.92 : 0.4)
        ..strokeWidth = bright ? 1.15 : 0.8
        ..strokeCap = StrokeCap.round,
    );
  }

  void _rainbow(Canvas canvas, Size size) {
    const steps = 16;
    for (var i = 0; i < steps; i++) {
      final t = i / steps;
      canvas.drawRect(
        Rect.fromLTWH(t * size.width, 0, size.width / steps + 0.6, size.height),
        Paint()..color = _spectrumAt(t),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SpectralTickPainter old) =>
      old.nm != nm || old.bright != bright || old.emission != emission;
}

Color _spectrumAt(double t) {
  const stops = <double>[0, 0.13, 0.27, 0.4, 0.52, 0.64, 0.78, 1];
  const colors = <Color>[
    Color(0xFF5B21B6),
    Color(0xFF1D4ED8),
    Color(0xFF0284C7),
    Color(0xFF16A34A),
    Color(0xFFFACC15),
    Color(0xFFF97316),
    Color(0xFFDC2626),
    Color(0xFF7F1D1D),
  ];
  for (var i = 0; i < stops.length - 1; i++) {
    final a = stops[i];
    final b = stops[i + 1];
    if (t <= b) {
      final span = b - a;
      final u = span == 0 ? 0.0 : ((t - a) / span).clamp(0.0, 1.0);
      return Color.lerp(colors[i], colors[i + 1], u)!;
    }
  }
  return colors.last;
}
