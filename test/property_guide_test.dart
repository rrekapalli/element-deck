import 'package:element_deck/guides/property_guide.dart';
import 'package:element_deck/guides/property_guide_page.dart';
import 'package:element_deck/widgets/property_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every Data-tab label has one substantial reference article', () {
    expect(PropertyGuides.all, hasLength(GuideId.all.length));
    expect(PropertyGuides.byId.keys.toSet(), GuideId.all.toSet());

    for (final id in GuideId.all) {
      final guide = PropertyGuides.lookup(id);
      expect(guide, isNotNull, reason: id);
      expect(guide!.title.trim(), isNotEmpty, reason: id);
      expect(guide.group.trim(), isNotEmpty, reason: id);
      expect(guide.lede.length, greaterThan(140), reason: id);
      expect(guide.sections, hasLength(greaterThanOrEqualTo(4)), reason: id);
      final body = guide.sections.fold<int>(
        0,
        (sum, section) => sum + section.body.length,
      );
      expect(body, greaterThan(1600), reason: id);
      for (final section in guide.sections) {
        expect(section.heading.trim(), isNotEmpty, reason: id);
        expect(
          section.paragraphs,
          isNotEmpty,
          reason: '$id ${section.heading}',
        );
      }
    }
  });

  testWidgets('a single tap does not open the article', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PropertyLabel(label: 'Period', guideId: GuideId.period),
        ),
      ),
    );

    await tester.tap(find.text('Period'));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('How the rows were drawn'), findsNothing);
  });

  testWidgets('a double tap opens the reference article', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              PropertyLabel(label: 'Period', guideId: GuideId.period),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('Period'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.text('Period'));
    await tester.pumpAndSettle();

    final guide = PropertyGuides.lookup(GuideId.period)!;
    expect(find.text(guide.sections.first.heading), findsOneWidget);
    expect(find.text(guide.lede), findsOneWidget);
  });

  testWidgets('the article page renders every section', (tester) async {
    final guide = PropertyGuides.lookup(GuideId.firstIonization)!;
    await tester.pumpWidget(MaterialApp(home: PropertyGuidePage(guide: guide)));

    expect(find.text('First ionization'), findsWidgets);
    for (final section in guide.sections) {
      await tester.scrollUntilVisible(
        find.text(section.heading),
        500,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text(section.heading), findsOneWidget);
    }
    await tester.scrollUntilVisible(
      find.textContaining('Teaching reference'),
      500,
      scrollable: find.byType(Scrollable),
    );
    expect(find.textContaining('Teaching reference'), findsOneWidget);
  });
}
