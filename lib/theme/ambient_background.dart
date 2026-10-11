import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

/// Canvas, accent, and glass flag kept on the theme after the scaffold is
/// made transparent so the wash can show through.
class DeckChrome extends ThemeExtension<DeckChrome> {
  const DeckChrome({
    required this.canvas,
    required this.accent,
    required this.glass,
  });

  final Color canvas;
  final Color accent;
  final bool glass;

  @override
  DeckChrome copyWith({Color? canvas, Color? accent, bool? glass}) {
    return DeckChrome(
      canvas: canvas ?? this.canvas,
      accent: accent ?? this.accent,
      glass: glass ?? this.glass,
    );
  }

  @override
  DeckChrome lerp(ThemeExtension<DeckChrome>? other, double t) {
    if (other is! DeckChrome) return this;
    return DeckChrome(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      glass: t < 0.5 ? glass : other.glass,
    );
  }
}

/// Soft diagonal wash and color orbs behind the shell.
///
/// Modeled on RxFolio's ambient background: a theme-tinted gradient with a
/// few blurred-looking orbs, so frosted surfaces have something to frost over.
class AmbientBackground extends StatelessWidget {
  const AmbientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final chrome = Theme.of(context).extension<DeckChrome>();
    final canvas = chrome?.canvas ?? const Color(0xFFEFF5FC);
    final accent = chrome?.accent ?? const Color(0xFF1D4ED8);
    final glass = chrome?.glass ?? true;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final start = _washStart(canvas, accent, dark);
    final end = _washEnd(canvas, accent, dark);

    if (!glass) {
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-0.5, -0.6),
            radius: 1.2,
            colors: [start, end],
            stops: const [0, 0.65],
          ),
        ),
        child: child,
      );
    }

    final lift = Color.lerp(accent, Colors.white, dark ? 0.28 : 0.38)!;
    final c1 = accent.withValues(alpha: dark ? 0.48 : 0.34);
    final c2 = lift.withValues(alpha: dark ? 0.34 : 0.28);
    final c3 = Color.lerp(accent, const Color(0xFFFF8AC8), 0.42)!
        .withValues(alpha: dark ? 0.28 : 0.22);

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [start, canvas, end],
              stops: const [0.0, 0.48, 1.0],
            ),
          ),
        ),
        Positioned(top: -90, left: -70, child: _Orb(color: c1, size: 300)),
        Positioned(top: 140, right: -100, child: _Orb(color: c2, size: 270)),
        Positioned(bottom: -50, left: 30, child: _Orb(color: c3, size: 250)),
        child,
      ],
    );
  }

  static Color _washStart(Color canvas, Color accent, bool dark) {
    if (dark) return Color.lerp(canvas, accent, 0.42)!;
    final tint = Color.lerp(accent, const Color(0xFFEAF3FF), 0.62)!;
    return Color.lerp(canvas, tint, 0.78)!;
  }

  static Color _washEnd(Color canvas, Color accent, bool dark) {
    const blush = Color(0xFFFF8AC8);
    if (dark) {
      return Color.lerp(canvas, Color.lerp(accent, blush, 0.45)!, 0.30)!;
    }
    final lilac = Color.lerp(const Color(0xFFF7ECFF), accent, 0.06)!;
    return Color.lerp(canvas, lilac, 0.88)!;
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

/// Opaque ambient fill on each route so a slide does not reveal the page
/// underneath through a transparent scaffold.
class DeckPageTransitionsBuilder extends PageTransitionsBuilder {
  const DeckPageTransitionsBuilder();

  static const CupertinoPageTransitionsBuilder _slide =
      CupertinoPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (!route.opaque) return child;
    return _slide.buildTransitions<T>(
      route,
      context,
      animation,
      secondaryAnimation,
      AmbientBackground(child: child),
    );
  }
}
