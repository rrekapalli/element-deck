import 'package:flutter/material.dart';

import '../data/learner_database.dart';
import '../theme/app_theme.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(this._db);

  final LearnerDatabase _db;

  ThemeMode mode = ThemeMode.light;
  ColorThemeId colorTheme = ColorThemeId.blue;
  Color customSeed = const Color(0xFF38BDF8);
  bool glass = AppTheme.defaultGlass();
  bool reduceGlow = false;

  ChromePalette get chrome {
    final brightness = mode == ThemeMode.light
        ? Brightness.light
        : Brightness.dark;
    var id = colorTheme;
    if (id == ColorThemeId.chalk && mode == ThemeMode.dark) {
      id = ColorThemeId.obsidianOrbit;
    }
    return ChromePalette.resolve(
      id: id,
      brightness: brightness,
      customSeed: customSeed,
    );
  }

  ThemeData get light => AppTheme.build(
    chrome: ChromePalette.resolve(
      id: colorTheme,
      brightness: Brightness.light,
      customSeed: customSeed,
    ),
    brightness: Brightness.light,
    glass: glass,
  );

  ThemeData get dark =>
      AppTheme.build(chrome: chrome, brightness: Brightness.dark, glass: glass);

  Future<void> load() async {
    final modeName = await _db.pref('appearance.themeMode') ?? 'light';
    mode = ThemeMode.values.firstWhere(
      (m) => m.name == modeName,
      orElse: () => ThemeMode.light,
    );
    final themeName = await _db.pref('appearance.colorTheme') ?? 'blue';
    colorTheme = ColorThemeId.values.firstWhere(
      (m) => m.name == themeName,
      orElse: () => ColorThemeId.blue,
    );
    final seed = await _db.pref('appearance.customSeed');
    if (seed != null) customSeed = Color(int.parse(seed));
    final glassPref = await _db.pref('appearance.frostedGlass');
    glass = glassPref == null || glassPref == 'true';
    reduceGlow = (await _db.pref('appearance.reduceGlow')) == 'true';
    notifyListeners();
  }

  Future<void> setMode(ThemeMode value) async {
    mode = value;
    await _db.setPref('appearance.themeMode', value.name);
    notifyListeners();
  }

  Future<void> setColorTheme(ColorThemeId value) async {
    colorTheme = value;
    if (value.isLightPreset) mode = ThemeMode.light;
    if (value == ColorThemeId.obsidianOrbit && mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    }
    await _db.setPref('appearance.colorTheme', value.name);
    await _db.setPref('appearance.themeMode', mode.name);
    notifyListeners();
  }

  Future<void> setGlass(bool value) async {
    glass = value;
    await _db.setPref('appearance.frostedGlass', '$value');
    notifyListeners();
  }

  Future<void> setReduceGlow(bool value) async {
    reduceGlow = value;
    await _db.setPref('appearance.reduceGlow', '$value');
    notifyListeners();
  }

  Future<void> setCustomSeed(Color value) async {
    customSeed = value;
    colorTheme = ColorThemeId.custom;
    await _db.setPref('appearance.customSeed', '${value.toARGB32()}');
    await _db.setPref('appearance.colorTheme', colorTheme.name);
    notifyListeners();
  }
}
