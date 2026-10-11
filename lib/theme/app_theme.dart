import 'package:flutter/material.dart';

import 'ambient_background.dart';

enum ColorThemeId { blue, obsidianOrbit, deepSea, graphite, chalk, custom }

extension ColorThemeIdX on ColorThemeId {
  String get label => switch (this) {
    ColorThemeId.blue => 'Blue',
    ColorThemeId.obsidianOrbit => 'Obsidian Orbit',
    ColorThemeId.deepSea => 'Deep Sea',
    ColorThemeId.graphite => 'Graphite',
    ColorThemeId.chalk => 'Chalk',
    ColorThemeId.custom => 'Custom',
  };

  bool get isLightPreset => this == ColorThemeId.chalk;
}

class ChromePalette {
  const ChromePalette({
    required this.canvas,
    required this.surface,
    required this.raised,
    required this.border,
    required this.text,
    required this.muted,
    required this.faint,
    required this.action,
    required this.onAction,
  });

  final Color canvas;
  final Color surface;
  final Color raised;
  final Color border;
  final Color text;
  final Color muted;
  final Color faint;
  final Color action;
  final Color onAction;

  static ChromePalette resolve({
    required ColorThemeId id,
    required Brightness brightness,
    required Color customSeed,
  }) {
    if (brightness == Brightness.light) {
      return _light(id, customSeed);
    }
    final action = switch (id) {
      ColorThemeId.blue => const Color(0xFF38BDF8),
      ColorThemeId.deepSea => const Color(0xFF2DD4BF),
      ColorThemeId.graphite => const Color(0xFF94A3B8),
      ColorThemeId.custom => customSeed,
      _ => const Color(0xFF38BDF8),
    };
    final canvas = switch (id) {
      ColorThemeId.graphite => const Color(0xFF0A0A0C),
      ColorThemeId.deepSea => const Color(0xFF061018),
      _ => const Color(0xFF080C14),
    };
    return ChromePalette(
      canvas: canvas,
      surface: const Color(0xFF0F172A),
      raised: const Color(0xFF1E293B),
      border: const Color(0xFF334155),
      text: const Color(0xFFF8FAFC),
      muted: const Color(0xFF94A3B8),
      faint: const Color(0xFF64748B),
      action: action,
      onAction: const Color(0xFF080C14),
    );
  }

  static const _paper = ChromePalette(
    canvas: Color(0xFFF4F6FA),
    surface: Color(0xFFFFFFFF),
    raised: Color(0xFFE8EEF6),
    border: Color(0xFFC5D0DC),
    text: Color(0xFF0B1326),
    muted: Color(0xFF4B5870),
    faint: Color(0xFF6B778C),
    action: Color(0xFF0369A1),
    onAction: Color(0xFFFFFFFF),
  );

  static ChromePalette _light(ColorThemeId id, Color customSeed) {
    if (id == ColorThemeId.blue) {
      return const ChromePalette(
        canvas: Color(0xFFEFF5FC),
        surface: Color(0xFFF7FBFF),
        raised: Color(0xFFE3EEF9),
        border: Color(0xFFC5D7EB),
        text: Color(0xFF0B1B33),
        muted: Color(0xFF3E5674),
        faint: Color(0xFF6B7F99),
        action: Color(0xFF1D4ED8),
        onAction: Color(0xFFFFFFFF),
      );
    }
    final action = switch (id) {
      ColorThemeId.deepSea => const Color(0xFF0F766E),
      ColorThemeId.graphite => const Color(0xFF475569),
      ColorThemeId.custom => customSeed,
      _ => _paper.action,
    };
    return ChromePalette(
      canvas: _paper.canvas,
      surface: _paper.surface,
      raised: _paper.raised,
      border: _paper.border,
      text: _paper.text,
      muted: _paper.muted,
      faint: _paper.faint,
      action: action,
      onAction: _paper.onAction,
    );
  }
}

class AppTheme {
  static ThemeData build({
    required ChromePalette chrome,
    required Brightness brightness,
    required bool glass,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: chrome.action,
      onPrimary: chrome.onAction,
      secondary: const Color(0xFFDDB7FF),
      onSecondary: const Color(0xFF2C0051),
      error: const Color(0xFFFFB4AB),
      onError: const Color(0xFF690005),
      surface: chrome.surface,
      onSurface: chrome.text,
      outline: chrome.border,
    );
    final dark = brightness == Brightness.dark;
    final frost = dark
        ? Colors.white.withValues(alpha: 0.10)
        : Colors.white.withValues(alpha: 0.62);
    final bar = dark
        ? chrome.surface.withValues(alpha: 0.55)
        : Colors.white.withValues(alpha: 0.58);
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.transparent,
      fontFamily: 'Plus Jakarta Sans',
      textTheme: ThemeData(brightness: brightness).textTheme.apply(
        fontFamily: 'Plus Jakarta Sans',
        bodyColor: chrome.text,
        displayColor: chrome.text,
      ),
    );
    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[
        DeckChrome(canvas: chrome.canvas, accent: chrome.action, glass: glass),
      ],
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: DeckPageTransitionsBuilder(),
          TargetPlatform.iOS: DeckPageTransitionsBuilder(),
          TargetPlatform.macOS: DeckPageTransitionsBuilder(),
          TargetPlatform.windows: DeckPageTransitionsBuilder(),
          TargetPlatform.linux: DeckPageTransitionsBuilder(),
          TargetPlatform.fuchsia: DeckPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: glass ? bar : chrome.surface,
        foregroundColor: chrome.text,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: glass ? bar : chrome.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: chrome.action.withValues(alpha: 0.16),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: glass ? bar : chrome.surface,
        indicatorColor: chrome.action.withValues(alpha: 0.16),
        selectedIconTheme: IconThemeData(color: chrome.action),
        selectedLabelTextStyle: TextStyle(color: chrome.action),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: glass ? frost : chrome.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(glass ? 16 : 8),
          side: BorderSide(
            color: glass
                ? Colors.white.withValues(alpha: dark ? 0.14 : 0.72)
                : chrome.border.withValues(alpha: 0.5),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: chrome.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintStyle: TextStyle(color: chrome.faint),
      ),
    );
  }

  static bool defaultGlass() => true;
}

class Mono {
  static TextStyle of(
    BuildContext context, {
    double size = 13,
    FontWeight? weight,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'JetBrains Mono',
      fontSize: size,
      fontWeight: weight,
      color: color ?? Theme.of(context).colorScheme.onSurface,
      letterSpacing: 0.03 * size / 13,
    );
  }
}
