import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ColorThemeId { obsidianOrbit, deepSea, graphite, chalk, custom }

extension ColorThemeIdX on ColorThemeId {
  String get label => switch (this) {
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
    if (id == ColorThemeId.chalk || brightness == Brightness.light) {
      return const ChromePalette(
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
    }
    final action = switch (id) {
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
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: chrome.canvas,
      fontFamily: 'Plus Jakarta Sans',
      textTheme: ThemeData(brightness: brightness).textTheme.apply(
            fontFamily: 'Plus Jakarta Sans',
            bodyColor: chrome.text,
            displayColor: chrome.text,
          ),
    );
    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: glass ? chrome.surface.withValues(alpha: 0.7) : chrome.surface,
        foregroundColor: chrome.text,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: chrome.surface,
        indicatorColor: chrome.action.withValues(alpha: 0.2),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: chrome.surface,
        indicatorColor: chrome.action.withValues(alpha: 0.2),
        selectedIconTheme: IconThemeData(color: chrome.action),
        selectedLabelTextStyle: TextStyle(color: chrome.action),
      ),
      cardTheme: CardThemeData(
        color: glass ? chrome.surface.withValues(alpha: 0.72) : chrome.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: chrome.border.withValues(alpha: 0.5)),
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

  static bool defaultGlass() => !kIsWeb;
}

class Mono {
  static TextStyle of(BuildContext context, {double size = 13, FontWeight? weight, Color? color}) {
    return TextStyle(
      fontFamily: 'JetBrains Mono',
      fontSize: size,
      fontWeight: weight,
      color: color ?? Theme.of(context).colorScheme.onSurface,
      letterSpacing: 0.03 * size / 13,
    );
  }
}
