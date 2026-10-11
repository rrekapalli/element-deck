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
    expect(pack.countInCategory('all'), 118);
    expect(pack.countInCategory('reactive-nonmetal'), 13);
    expect(pack.countInCategory('noble-gas'), 7);
    expect(pack.countInCategory('alkali-metal'), 6);
    expect(pack.countInCategory('alkaline-earth'), 6);
    expect(pack.countInCategory('transition-metal'), 38);
    expect(pack.countInCategory('post-transition'), 12);
    expect(pack.countInCategory('metalloid'), 6);
    expect(pack.countInCategory('lanthanide'), 15);
    expect(pack.countInCategory('actinide'), 15);
    expect(pack.countInCategory('halogen'), 6);
  });

  test('every element has beginner, intermediate, and advanced copy', () {
    final file = File('assets/catalog/core.json');
    final pack = CatalogPack.fromJson(
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>,
    );
    for (final e in pack.elements) {
      expect(
        e.summary.beginner.length,
        greaterThan(80),
        reason: 'summary beginner Z=${e.z}',
      );
      expect(
        e.summary.intermediate.length,
        greaterThan(80),
        reason: 'summary intermediate Z=${e.z}',
      );
      expect(
        e.summary.advanced.length,
        greaterThan(80),
        reason: 'summary advanced Z=${e.z}',
      );
      expect(
        e.curriculum.beginner.length,
        greaterThan(60),
        reason: 'curriculum beginner Z=${e.z}',
      );
      expect(
        e.curriculum.intermediate.length,
        greaterThan(60),
        reason: 'curriculum intermediate Z=${e.z}',
      );
      expect(
        e.curriculum.advanced.length,
        greaterThan(80),
        reason: 'curriculum advanced Z=${e.z}',
      );
      expect(
        e.history.trim().length,
        greaterThan(120),
        reason: 'history Z=${e.z}',
      );
      expect(
        e.howDiscovered.trim().length,
        greaterThan(200),
        reason: 'how discovered Z=${e.z}',
      );
      expect(
        e.cosmicOrigin.trim().length,
        greaterThan(200),
        reason: 'cosmic origin Z=${e.z}',
      );
      expect(
        e.trivia.length,
        greaterThanOrEqualTo(5),
        reason: 'trivia Z=${e.z}',
      );
      for (final story in e.trivia) {
        expect(
          story.title.trim().length,
          greaterThan(8),
          reason: 'trivia title Z=${e.z}',
        );
        expect(
          story.summary.trim().length,
          greaterThan(40),
          reason: 'trivia summary Z=${e.z}',
        );
        expect(
          story.story.trim().length,
          greaterThan(200),
          reason: 'trivia story Z=${e.z} ${story.title}',
        );
      }
      expect(e.applications, isNotEmpty, reason: 'apps Z=${e.z}');
      expect(
        e.applications.length,
        greaterThanOrEqualTo(3),
        reason: 'uses Z=${e.z}',
      );
      for (final use in e.applications) {
        expect(
          use.body.trim().length,
          greaterThan(80),
          reason: 'use Z=${e.z} ${use.title}',
        );
        final image = use.image;
        if (image != null) {
          expect(image, startsWith('assets/uses/'), reason: use.title);
          expect(File(image).existsSync(), isTrue, reason: image);
        }
      }
      final sample = e.sample;
      expect(sample, isNotNull, reason: 'sample Z=${e.z}');
      expect(
        sample!.body.trim().length,
        greaterThan(80),
        reason: 'sample Z=${e.z}',
      );
      expect(
        sample.image,
        startsWith('assets/samples/'),
        reason: 'sample Z=${e.z}',
      );
      expect(File(sample.image!).existsSync(), isTrue, reason: sample.image);
      expect(sample.credit, isNotNull, reason: 'sample credit Z=${e.z}');
      expect(
        sample.credit!.trim(),
        isNotEmpty,
        reason: 'sample credit Z=${e.z}',
      );
      expect(
        e.summary.beginner,
        isNot(contains('configuration')),
        reason: 'Z=${e.z}',
      );
      expect(
        e.summary.beginner,
        isNot(contains('oxidation')),
        reason: 'Z=${e.z}',
      );
      expect(e.discovery, isNotNull, reason: 'discovery Z=${e.z}');
    }
  });

  test('bundled sqlite catalog exists', () {
    final file = File('assets/catalog/catalog.sqlite');
    expect(file.existsSync(), isTrue);
    expect(file.lengthSync(), greaterThan(100000));
  });

  test('visible teaching lines are stored for common elements', () {
    final file = File('assets/catalog/core.json');
    final pack = CatalogPack.fromJson(
      jsonDecode(file.readAsStringSync()) as Map<String, dynamic>,
    );
    expect(pack.byZ(2)!.spectralLines, isNotEmpty);
    expect(
      pack.byZ(11)!.spectralLines.map((l) => l.nm),
      containsAll([588.995, 589.592]),
    );
    expect(
      pack.byZ(80)!.spectralLines.any((l) => (l.nm - 546.07).abs() < 0.02),
      isTrue,
    );
    expect(pack.byZ(1)!.spectralLines.length, greaterThanOrEqualTo(4));
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
