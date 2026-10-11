import 'package:flutter/material.dart';

import '../data/learner_database.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this._db);

  final LearnerDatabase _db;

  String depth = 'intermediate';
  String persona = 'student';
  String temperature = 'K';
  String energy = 'eV';
  String length = 'pm';
  bool configShorthand = true;
  bool sonification = true;
  bool reducedMotion = false;
  String localeApply = 'all';

  Future<void> load() async {
    depth = await _db.pref('learning.depth') ?? 'intermediate';
    persona = await _db.pref('persona') ?? 'student';
    temperature = await _db.pref('units.temperature') ?? 'K';
    energy = await _db.pref('units.energy') ?? 'eV';
    length = await _db.pref('units.length') ?? 'pm';
    configShorthand = (await _db.pref('units.configuration')) != 'full';
    sonification = (await _db.pref('spectra.sonification')) != 'false';
    reducedMotion = (await _db.pref('motion.reduced')) == 'true';
    localeApply = await _db.pref('locale.apply') ?? 'all';
    notifyListeners();
  }

  Future<void> setDepth(String value) async {
    depth = value;
    await _db.setPref('learning.depth', value);
    notifyListeners();
  }

  Future<void> setPersona(String value) async {
    persona = value;
    await _db.setPref('persona', value);
    final d = switch (value) {
      'enthusiast' => 'advanced',
      _ => 'intermediate',
    };
    await setDepth(d);
  }

  Future<void> setTemperature(String v) async {
    temperature = v;
    await _db.setPref('units.temperature', v);
    notifyListeners();
  }

  Future<void> setEnergy(String v) async {
    energy = v;
    await _db.setPref('units.energy', v);
    notifyListeners();
  }

  Future<void> setLength(String v) async {
    length = v;
    await _db.setPref('units.length', v);
    notifyListeners();
  }

  Future<void> setShorthand(bool v) async {
    configShorthand = v;
    await _db.setPref('units.configuration', v ? 'shorthand' : 'full');
    notifyListeners();
  }

  Future<void> setSonification(bool v) async {
    sonification = v;
    await _db.setPref('spectra.sonification', '$v');
    notifyListeners();
  }

  Future<void> setReducedMotion(bool v) async {
    reducedMotion = v;
    await _db.setPref('motion.reduced', '$v');
    notifyListeners();
  }

  String temp(double kelvin) {
    if (temperature == 'C') {
      return '${(kelvin - 273.15).toStringAsFixed(0)} °C';
    }
    return '${kelvin.toStringAsFixed(0)} K';
  }

  String energyValue(double eV) {
    if (energy == 'kJ/mol') {
      return '${(eV * 96.485).toStringAsFixed(1)} kJ/mol';
    }
    return '${eV.toStringAsFixed(3)} eV';
  }

  String lengthValue(double pm) {
    if (length == 'angstrom') {
      return '${(pm / 100).toStringAsFixed(2)} Å';
    }
    return '${pm.toStringAsFixed(0)} pm';
  }
}
