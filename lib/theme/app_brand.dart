import 'dart:math' as math;
import 'dart:ui' show ImageFilter, PointMode;

import 'package:flutter/material.dart';

/// Launcher mark and splash colors. These stay on the brand canvas and do not
/// follow the in-app color preset.
abstract final class AppBrand {
  static const canvas = Color(0xFF080C14);
  static const action = Color(0xFF38BDF8);
  static const gold = Color(0xFFE4B84A);
  static const muted = Color(0xFF94A3B8);
  static const text = Color(0xFFF8FAFC);
  static const ink = Color(0xFF0B1B33);
}

/// The Element Deck mark: a frosted glass plate, a capital E, a one-pixel
/// dotted orbit, and a single electron. Raster home-screen copies are
/// generated from the same layout.
class AppMark extends StatelessWidget {
  const AppMark({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    final inset = size * 0.08;
    final plate = size - inset * 2;
    final radius = plate * 0.22;
    final blur = (size * 0.08).clamp(1.5, 16.0);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned(
            left: inset,
            top: inset,
            width: plate,
            height: plate,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: const SizedBox.expand(),
              ),
            ),
          ),
          CustomPaint(
            size: Size.square(size),
            painter: const _AppMarkPainter(),
          ),
        ],
      ),
    );
  }
}

class _AppMarkPainter extends CustomPainter {
  const _AppMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final inset = side * 0.08;
    final rect = Rect.fromLTWH(inset, inset, side - inset * 2, side - inset * 2);
    final radius = Radius.circular(rect.width * 0.22);
    final rrect = RRect.fromRectAndRadius(rect, radius);

    canvas.save();
    canvas.clipRRect(rrect);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x9EF8FCFF), Color(0x56D2E4F2)],
        ).createShader(rect),
    );
    final sheenHeight = rect.height * 0.34;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(rect.center.dx, rect.top + sheenHeight * 0.15),
        width: rect.width * 0.78,
        height: sheenHeight,
      ),
      Paint()
        ..color = const Color(0x30FFFFFF)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, (side / 64).clamp(0.8, 12)),
    );
    if (rect.width >= 24) {
      final grain = Paint()..color = const Color(0x16FFFFFF);
      final rng = math.Random(7);
      final count = math.max(1, (rect.width * rect.height) ~/ 70);
      for (var i = 0; i < count; i++) {
        canvas.drawRect(
          Rect.fromLTWH(
            rect.left + rng.nextDouble() * rect.width,
            rect.top + rng.nextDouble() * rect.height,
            1,
            1,
          ),
          grain,
        );
      }
    }
    canvas.restore();

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = const Color(0xD2FFFFFF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    const tilt = -0.42;
    final rx = rect.width * 0.34;
    final ry = rect.height * 0.21;
    final electron = _rotate(Offset(rx * math.cos(-0.55), ry * math.sin(-0.55)), tilt);
    final electronRadius = math.max(1.6, rect.width * 0.026);
    final gap = rect.width < 40 ? 2.0 : 3.0;
    final dots = <Offset>[];
    final samples = math.max(240, ((rx + ry) * 8).round());
    var traveled = gap;
    Offset? previous;
    for (var i = 0; i <= samples; i++) {
      final angle = i * math.pi * 2 / samples;
      final point = _rotate(Offset(rx * math.cos(angle), ry * math.sin(angle)), tilt);
      if (previous != null) {
        traveled += (point - previous).distance;
        if (traveled >= gap) {
          if ((point - electron).distance >= electronRadius + 1.5) {
            dots.add(rect.center + point);
          }
          traveled = 0;
        }
      }
      previous = point;
    }
    canvas.drawPoints(
      PointMode.points,
      dots,
      Paint()
        ..color = AppBrand.action
        ..strokeWidth = 1
        ..strokeCap = StrokeCap.round,
    );

    final symbol = TextPainter(
      text: TextSpan(
        text: 'E',
        style: TextStyle(
          color: AppBrand.ink,
          fontSize: rect.width * 0.5,
          fontWeight: FontWeight.w400,
          fontFamily: 'Plus Jakarta Sans',
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    symbol.paint(
      canvas,
      Offset(
        rect.center.dx - symbol.width / 2,
        rect.center.dy - symbol.height / 2,
      ),
    );

    canvas.drawCircle(
      rect.center + electron,
      electronRadius,
      Paint()..color = AppBrand.gold,
    );
  }

  Offset _rotate(Offset point, double tilt) {
    final cosT = math.cos(tilt);
    final sinT = math.sin(tilt);
    return Offset(
      point.dx * cosT - point.dy * sinT,
      point.dx * sinT + point.dy * cosT,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Full-screen splash shared by the HTML shell and the first Flutter frames.
class AppSplash extends StatelessWidget {
  const AppSplash({super.key, this.caption});

  final String? caption;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppBrand.canvas,
      child: SizedBox.expand(child: _SplashBody(caption: caption)),
    );
  }
}

class _SplashBody extends StatelessWidget {
  const _SplashBody({this.caption});

  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppMark(size: 104),
          const SizedBox(height: 20),
          const Text(
            'Element Deck',
            style: TextStyle(
              color: AppBrand.text,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'PERIODIC EXPLORER',
            style: TextStyle(
              color: AppBrand.muted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.6,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
          if (caption != null) ...[
            const SizedBox(height: 28),
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppBrand.action,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              caption!,
              style: const TextStyle(color: AppBrand.muted, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }
}
