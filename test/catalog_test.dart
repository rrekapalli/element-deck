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
