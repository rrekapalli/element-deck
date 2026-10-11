import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Launcher mark and splash colors. These stay on the brand canvas and do not
/// follow the in-app color preset.
abstract final class AppBrand {
  static const canvas = Color(0xFF080C14);
  static const tile = Color(0xFF0F172A);
  static const action = Color(0xFF38BDF8);
  static const gold = Color(0xFFE4B84A);
  static const muted = Color(0xFF94A3B8);
  static const text = Color(0xFFF8FAFC);
  static const markVersion = '1.1';
}

/// The Element Deck mark: an electron tile. Used on the splash, the shell, and
/// About. Raster copies for the home screen are generated from the same layout.
class AppMark extends StatelessWidget {
  const AppMark({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: const _AppMarkPainter(),
    );
  }
}

class _AppMarkPainter extends CustomPainter {
  const _AppMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final inset = side * 0.16;
    final rect = Rect.fromLTWH(
      inset,
      inset,
      side - inset * 2,
      side - inset * 2,
    );
    final radius = Radius.circular(rect.width * 0.18);
    final rrect = RRect.fromRectAndRadius(rect, radius);

    canvas.drawRRect(rrect, Paint()..color = AppBrand.tile);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = AppBrand.action
        ..style = PaintingStyle.stroke
        ..strokeWidth = (side * 0.025).clamp(1.5, 8),
    );

    final version = TextPainter(
      text: TextSpan(
        text: AppBrand.markVersion,
        style: TextStyle(
          color: AppBrand.muted,
          fontSize: rect.width * 0.14,
          fontFamily: 'JetBrains Mono',
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    version.paint(
      canvas,
      Offset(rect.left + rect.width * 0.08, rect.top + rect.height * 0.07),
    );

    final symbol = TextPainter(
      text: TextSpan(
        text: 'e',
        style: TextStyle(
          color: AppBrand.action,
          fontSize: rect.width * 0.5,
          fontWeight: FontWeight.w800,
          fontFamily: 'Plus Jakarta Sans',
          height: 1,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final symbolOrigin = Offset(
      rect.center.dx - symbol.width / 2,
      rect.center.dy - symbol.height / 2 + rect.height * 0.05,
    );
    symbol.paint(canvas, symbolOrigin);

    final orbitCenter = Offset(rect.center.dx, rect.center.dy + rect.height * 0.04);
    final rx = rect.width * 0.36;
    final ry = rect.height * 0.24;
    canvas.save();
    canvas.translate(orbitCenter.dx, orbitCenter.dy);
    canvas.rotate(-0.32);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: rx * 2, height: ry * 2),
      Paint()
        ..color = AppBrand.gold
        ..style = PaintingStyle.stroke
        ..strokeWidth = (side * 0.018).clamp(1.2, 5),
    );
    const t = -0.85;
    final electron = Offset(rx * math.cos(t), ry * math.sin(t));
    _drawStar(canvas, electron, rect.width * 0.055, AppBrand.gold);
    canvas.restore();
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path();
    for (var i = 0; i < 8; i++) {
      final r = i.isEven ? radius : radius * 0.38;
      final a = -math.pi / 2 + i * math.pi / 4;
      final point = Offset(center.dx + r * math.cos(a), center.dy + r * math.sin(a));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
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
