import 'dart:convert';
import 'dart:io';

import 'package:element_deck/guides/spectra_detail.dart';
import 'package:element_deck/models/catalog.dart';
import 'package:element_deck/rooms/spectra_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every element has a spectrum essay', () {
    expect(ElementSpectra.byZ, hasLength(118));
    for (var z = 1; z <= 118; z++) {
      final essay = ElementSpectra.lookup(z);
      expect(essay, isNotNull, reason: 'missing essay for Z=$z');
      expect(essay!.z, z);
      expect(essay.lede.length, greaterThan(80), reason: 'lede Z=$z');
      expect(
        essay.sections.length,
        greaterThanOrEqualTo(3),
        reason: 'sections Z=$z',
      );
      final body = essay.sections.fold<int>(
        0,
        (sum, section) => sum + section.body.length,
      );
      expect(body, greaterThan(700), reason: 'body Z=$z');
      for (final section in essay.sections) {
        expect(section.heading.trim(), isNotEmpty, reason: 'Z=$z');
        expect(
          section.paragraphs,
          isNotEmpty,
          reason: 'Z=$z ${section.heading}',
        );
      }
    }
  });

  test('the shared primer is a full account of spectra', () {
    expect(spectraPrimer.sections.length, greaterThanOrEqualTo(6));
    final body = spectraPrimer.sections.fold<int>(
      0,
      (sum, section) => sum + section.body.length,
    );
    expect(body, greaterThan(4000));
    expect(spectraPrimer.lede.length, greaterThan(80));
  });

  testWidgets('Details keeps the element essay and opens the shared primer', (
    tester,
  ) async {
    final pack = CatalogPack.fromJson(
      jsonDecode(File('assets/catalog/preview.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final hydrogen = pack.byZ(1)!;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ListView(
                children: spectraDetailChildren(
                  context: context,
                  element: hydrogen,
                  packVersion: pack.version,
                  depth: 'advanced',
                ),
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('What a spectrum is'), findsOneWidget);
    expect(find.text('Jump to Hydrogen'), findsNothing);
    expect(find.text('Light sorted by wavelength'), findsNothing);
    expect(find.text('Hydrogen spectrum'), findsOneWidget);

    await tester.tap(find.text('What a spectrum is'));
    await tester.pumpAndSettle();

    expect(find.text('Light sorted by wavelength'), findsOneWidget);
    expect(find.text(spectraPrimer.lede), findsOneWidget);
    expect(find.text('SPECTRA  ·  REFERENCE'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('The series'), 400);
    expect(find.text('The series'), findsOneWidget);

    await tester.scrollUntilVisible(find.textContaining('656.28 nm'), 400);
    expect(find.textContaining('656.28 nm'), findsOneWidget);
  });
}
