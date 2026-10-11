import 'dart:convert';
import 'dart:io';

import 'package:element_deck/models/catalog.dart';
import 'package:element_deck/models/periodic_layout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('preview catalog has the five fixture elements', () {
    final file = File('assets/catalog/preview.json');
    final pack = CatalogPack.fromJson(
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>,
    );
    expect(pack.elements.map((e) => e.z).toSet(), {1, 6, 10, 14, 22});
    expect(pack.byZ(10)!.glow, isNotNull);
    expect(pack.trendNotes.first.matches(6, 14), isTrue);
  });

  test('core catalog has 118 elements', () {
    final file = File('assets/catalog/core.json');
    final pack = CatalogPack.fromJson(
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>,
    );
    expect(pack.elements, hasLength(118));
    expect(pack.byZ(9)!.isHalogen, isTrue);
    expect(pack.byZ(9)!.categoryId, 'reactive-nonmetal');
  });

  test('every element has beginner, intermediate, and advanced copy', () {
    final file = File('assets/catalog/core.json');
    final pack = CatalogPack.fromJson(
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>,
    );
    for (final e in pack.elements) {
      expect(e.summary.beginner.length, greaterThan(80), reason: 'summary beginner Z=${e.z}');
      expect(e.summary.intermediate.length, greaterThan(80), reason: 'summary intermediate Z=${e.z}');
      expect(e.summary.advanced.length, greaterThan(80), reason: 'summary advanced Z=${e.z}');
      expect(e.curriculum.beginner.length, greaterThan(60), reason: 'curriculum beginner Z=${e.z}');
      expect(e.curriculum.intermediate.length, greaterThan(60), reason: 'curriculum intermediate Z=${e.z}');
      expect(e.curriculum.advanced.length, greaterThan(80), reason: 'curriculum advanced Z=${e.z}');
      expect(e.applications, isNotEmpty, reason: 'apps Z=${e.z}');
      expect(e.discovery, isNotNull, reason: 'discovery Z=${e.z}');
    }
  });

  test('bundled sqlite catalog exists', () {
    final file = File('assets/catalog/catalog.sqlite');
    expect(file.existsSync(), isTrue);
    expect(file.lengthSync(), greaterThan(100000));
  });

  test('sonification divisor is 1e12', () {
    final file = File('assets/catalog/preview.json');
    final pack = CatalogPack.fromJson(
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>,
    );
    final line = pack.byZ(10)!.spectralLines.first;
    expect(line.audibleHz, closeTo(line.frequencyHz / 1e12, 0.01));
  });

  test('periodic table places 118 unique elements', () {
    expect(PeriodicLayout.elements, hasLength(118));
    expect(PeriodicLayout.cells.map((c) => c.z).toSet(), hasLength(118));
    expect(PeriodicLayout.element(1)!.symbol, 'H');
    expect(PeriodicLayout.element(118)!.symbol, 'Og');
    expect(PeriodicLayout.element(9)!.halogen, isTrue);
  });
}
