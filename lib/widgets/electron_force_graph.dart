import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/orbital_force.dart';

String _diagramCaption(String depth) {
  return switch (depth) {
    'beginner' =>
      'Each ring is a shell of electrons. The center is the nucleus. '
          'Drag an electron and it is pulled back. '
          'A dotted circle is an empty seat.',
    'advanced' =>
      'Each ring is a subshell. A line joins the two electrons in one orbital. '
          'A dotted circle is an empty seat. '
          'Pull is the Slater binding energy, and ring radius follows 1/sqrt(E).',
    _ =>
      'Each ring is a subshell. A line joins the two electrons in one orbital. '
          'A dotted circle is an empty seat.',
  };
}

/// Force-directed electron configuration.
///
/// Orbit lines sit at the radius implied by each subshell's binding energy.
/// Dragging an electron shows the pull: core electrons spring back harder.
class ElectronForceGraph extends StatefulWidget {
  const ElectronForceGraph({
    super.key,
    required this.atomicNumber,
    required this.symbol,
    required this.configuration,
    required this.accent,
    required this.reducedMotion,
    required this.energyUnit,
    this.depth = 'advanced',
  });

  final int atomicNumber;
  final String symbol;
  final String configuration;
  final Color accent;
  final bool reducedMotion;

  /// `eV` or `kJ/mol`, matching App settings.
  final String energyUnit;

  /// `beginner`, `intermediate`, or `advanced`. Beginner hides subshell labels.
  final String depth;

  @override
  State<ElectronForceGraph> createState() => _ElectronForceGraphState();
}

class _ElectronForceGraphState extends State<ElectronForceGraph>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  ElectronSim? _sim;
  bool _seeded = false;
  bool _cruise = false;
  double _alpha = 1;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _swapCloud(seedFresh: true);
  }

  @override
  void didUpdateWidget(ElectronForceGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    final identityChanged =
        oldWidget.atomicNumber != widget.atomicNumber ||
        oldWidget.configuration != widget.configuration;
    if (identityChanged) {
      _swapCloud(seedFresh: true);
      return;
    }
    if (oldWidget.reducedMotion != widget.reducedMotion) {
      if (widget.reducedMotion) {
        _ticker.stop();
        _sim?.settle();
        _cruise = true;
      } else {
        _cruise = true;
        _alpha = 0.35;
        if (!_ticker.isActive) _ticker.start();
      }
      _generation++;
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _swapCloud({required bool seedFresh}) {
    final cloud = ElectronCloud.fromConfiguration(
      z: widget.atomicNumber,
      configuration: widget.configuration,
    );
    _sim = cloud == null ? null : (ElectronSim(cloud)..prepare());
    _seeded = false;
    _cruise = false;
    _alpha = 1;
    if (!seedFresh) return;
    if (widget.reducedMotion) {
      _ticker.stop();
    }
  }

  void _ensure(Size size) {
    final sim = _sim;
    if (sim == null) return;
    sim.layout(size.width, size.height);
    if (_seeded || size.width <= 0 || size.height <= 0) return;
    _seeded = true;
    sim.seed(jitter: !widget.reducedMotion);
    if (widget.reducedMotion) {
      sim.settle();
      _cruise = true;
      _ticker.stop();
    } else if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  void _onTick(Duration elapsed) {
    final sim = _sim;
    if (!mounted || sim == null || !_seeded) return;
    if (!_cruise) {
      _alpha *= 0.985;
      if (_alpha <= 0.08) {
        _alpha = 0.35;
        _cruise = true;
      }
    }
    final substeps = _cruise ? 1 : 2;
    for (var i = 0; i < substeps; i++) {
      sim.step(alpha: _cruise ? 0.4 : _alpha, cruise: _cruise);
    }
    setState(() => _generation++);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 320.0;
        final canvas = width.clamp(240.0, 400.0);
        _ensure(Size(width, canvas));
        final sim = _sim;
        final theme = Theme.of(context);
        return Column(
          children: [
            SizedBox(
              height: canvas,
              width: width,
              child: sim == null
                  ? Center(
                      child: Text(
                        'No configuration to draw',
                        style: theme.textTheme.bodyMedium,
                      ),
                    )
                  : _stage(context, sim, Size(width, canvas)),
            ),
            if (sim != null) ...[
              if (widget.depth != 'beginner') ...[
                const SizedBox(height: 8),
                _EnergyLegend(
                  sim: sim,
                  unit: widget.energyUnit,
                  color: theme.hintColor,
                ),
              ],
              const SizedBox(height: 6),
              Text(
                _diagramCaption(widget.depth),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _stage(BuildContext context, ElectronSim sim, Size size) {
    final theme = Theme.of(context);
    return Semantics(
      label:
          'Electron configuration diagram for ${widget.symbol}. '
          '${sim.electrons.length} electrons. '
          'Binding energy sets how strongly each electron is pulled toward the nucleus.',
      child: RepaintBoundary(
        child: RawGestureDetector(
          behavior: HitTestBehavior.opaque,
          gestures: <Type, GestureRecognizerFactory>{
            _ElectronDragRecognizer:
                GestureRecognizerFactoryWithHandlers<_ElectronDragRecognizer>(
                  () => _ElectronDragRecognizer(
                    accepts: (local) => _hit(sim, size, local),
                  ),
                  (_ElectronDragRecognizer recognizer) {
                    recognizer.onStart = (local) => _grab(sim, size, local);
                    recognizer.onUpdate = (local) => _drag(sim, size, local);
                    recognizer.onEnd = () => _release(sim);
                  },
                ),
          },
          child: ClipRect(
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: _ElectronPainter(
                    sim: sim,
                    accent: widget.accent,
                    labelColor: theme.colorScheme.onSurface.withValues(
                      alpha: 0.82,
                    ),
                    haloColor: theme.colorScheme.surface,
                    drawLinks: true,
                    labelRings:
                        widget.depth != 'beginner' && sim.rings.length <= 7,
                    generation: _generation,
                  ),
                ),
                Center(
                  child: IgnorePointer(
                    child: Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.accent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        widget.symbol,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _hit(ElectronSim sim, Size size, Offset local) {
    return sim.hit(local.dx - size.width / 2, local.dy - size.height / 2) >= 0;
  }

  void _grab(ElectronSim sim, Size size, Offset local) {
    final x = local.dx - size.width / 2;
    final y = local.dy - size.height / 2;
    final index = sim.hit(x, y);
    if (index >= 0) sim.grab(index, x, y);
  }

  void _drag(ElectronSim sim, Size size, Offset local) {
    sim.dragTo(local.dx - size.width / 2, local.dy - size.height / 2);
    if (widget.reducedMotion || !_ticker.isActive) {
      setState(() => _generation++);
    }
  }

  void _release(ElectronSim sim) {
    sim.release();
    if (widget.reducedMotion) {
      sim.settle();
      setState(() => _generation++);
    }
  }
}

String formatBindingEnergy(double eV, String unit) {
  if (unit == 'kJ/mol') {
    final v = eV * 96.485;
    final digits = v >= 100 ? 0 : 1;
    return '${v.toStringAsFixed(digits)} kJ/mol';
  }
  final digits = eV >= 100 ? 0 : (eV >= 10 ? 1 : 2);
  return '${eV.toStringAsFixed(digits)} eV';
}

class _EnergyLegend extends StatelessWidget {
  const _EnergyLegend({
    required this.sim,
    required this.unit,
    required this.color,
  });

  final ElectronSim sim;
  final String unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = theme.colorScheme.outline.withValues(alpha: 0.4);
    final headerBg = theme.colorScheme.surfaceContainerHighest.withValues(
      alpha: 0.7,
    );
    final rings = sim.rings;
    final labelStyle = TextStyle(
      fontFamily: 'JetBrains Mono',
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: theme.colorScheme.onSurface,
    );
    final valueStyle = TextStyle(
      fontFamily: 'JetBrains Mono',
      fontSize: 11,
      color: color,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < rings.length; i++) ...[
                        if (i > 0) Container(width: 1, color: border),
                        _EnergyCell(
                          label: rings[i].label,
                          value: formatBindingEnergy(rings[i].bindingEv, unit),
                          labelStyle: labelStyle,
                          valueStyle: valueStyle,
                          headerColor: headerBg,
                          dividerColor: border,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EnergyCell extends StatelessWidget {
  const _EnergyCell({
    required this.label,
    required this.value,
    required this.labelStyle,
    required this.valueStyle,
    required this.headerColor,
    required this.dividerColor,
  });

  final String label;
  final String value;
  final TextStyle labelStyle;
  final TextStyle valueStyle;
  final Color headerColor;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 84),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ColoredBox(
              color: headerColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: labelStyle,
                ),
              ),
            ),
            Container(height: 1, color: dividerColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: valueStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ElectronPainter extends CustomPainter {
  _ElectronPainter({
    required this.sim,
    required this.accent,
    required this.labelColor,
    required this.haloColor,
    required this.drawLinks,
    required this.labelRings,
    required this.generation,
  });

  final ElectronSim sim;
  final Color accent;
  final Color labelColor;
  final Color haloColor;
  final bool drawLinks;
  final bool labelRings;
  final int generation;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rings = sim.rings;
    if (rings.isEmpty) return;
    final outer = rings.last.radius;

    for (final ring in rings) {
      final t = outer == rings.first.radius
          ? 0.5
          : ((ring.radius - rings.first.radius) / (outer - rings.first.radius))
                .clamp(0.0, 1.0);
      canvas.drawCircle(
        center,
        ring.radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.15
          ..color = accent.withValues(alpha: 0.22 + 0.48 * (1 - t)),
      );
    }

    if (drawLinks) {
      final link = Paint()
        ..color = accent.withValues(alpha: 0.55)
        ..strokeWidth = 1.25
        ..strokeCap = StrokeCap.round;
      final electrons = sim.electrons;
      for (var i = 0; i < electrons.length; i++) {
        final partner = electrons[i].partner;
        if (partner == null || partner < i) continue;
        canvas.drawLine(
          center + Offset(electrons[i].x, electrons[i].y),
          center + Offset(electrons[partner].x, electrons[partner].y),
          link,
        );
      }
    }

    final byLabel = {for (final ring in rings) ring.label: ring};
    final hole = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..color = accent;
    for (final vacancy in sim.cloud.vacancies) {
      final ring = byLabel[vacancy.label];
      if (ring == null) continue;
      _paintDottedCircle(
        canvas,
        center +
            Offset(
              math.cos(vacancy.angle) * ring.radius,
              math.sin(vacancy.angle) * ring.radius,
            ),
        sim.nodeRadius,
        hole,
      );
    }

    final node = Paint()..color = accent;
    final nodeStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.15
      ..color = haloColor.withValues(alpha: 0.92);
    final radius = sim.nodeRadius;
    for (final e in sim.electrons) {
      final at = center + Offset(e.x, e.y);
      canvas.drawCircle(at, radius, node);
      canvas.drawCircle(at, radius, nodeStroke);
    }

    if (labelRings) _paintLabels(canvas, center, rings);
  }

  /// 1px dotted ring, same size as a filled electron, for an empty seat.
  void _paintDottedCircle(Canvas canvas, Offset at, double radius, Paint paint) {
    const dots = 8;
    final step = 2 * math.pi / dots;
    for (var i = 0; i < dots; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: at, radius: radius),
        i * step,
        step * 0.42,
        false,
        paint,
      );
    }
  }

  void _paintLabels(Canvas canvas, Offset center, List<OrbitRing> rings) {
    var previous = -100.0;
    for (var i = 0; i < rings.length; i++) {
      final ring = rings[i];
      final last = i == rings.length - 1;
      if (!last && (ring.radius - previous).abs() < 14 && previous > 0) {
        continue;
      }
      previous = ring.radius;
      final angle = -0.55 + i * 0.22;
      final at =
          center +
          Offset(math.cos(angle) * ring.radius, math.sin(angle) * ring.radius);
      final painter = TextPainter(
        text: TextSpan(
          text: ring.label,
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 10,
            color: labelColor,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final rect = Rect.fromCenter(
        center: at,
        width: painter.width + 8,
        height: painter.height + 3,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(3)),
        Paint()..color = haloColor.withValues(alpha: 0.88),
      );
      painter.paint(canvas, at - Offset(painter.width / 2, painter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _ElectronPainter oldDelegate) =>
      oldDelegate.generation != generation;
}

class _ElectronDragRecognizer extends OneSequenceGestureRecognizer {
  _ElectronDragRecognizer({required this.accepts});

  final bool Function(Offset localPosition) accepts;
  ValueChanged<Offset>? onStart;
  ValueChanged<Offset>? onUpdate;
  VoidCallback? onEnd;

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (!accepts(event.localPosition)) return;
    startTrackingPointer(event.pointer, event.transform);
    resolve(GestureDisposition.accepted);
    onStart?.call(event.localPosition);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      onUpdate?.call(event.localPosition);
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      onEnd?.call();
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'electron drag';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
