import 'package:element_deck/help/help_catalog.dart';
import 'package:element_deck/help/help_document.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('splits title, hero images, callouts, and body', () {
    const markdown = '''
# Table

![Table](asset:assets/help/images/table.png)

Callouts: **Search** · **family chips**.

## Purpose

Search the elements.
''';
    final doc = HelpDocument.parse(markdown);
    expect(doc.title, 'Table');
    expect(doc.images, hasLength(1));
    expect(doc.images.first.assetPath, 'assets/help/images/table.png');
    expect(doc.imageCaption, '**Search** · **family chips**.');
    expect(doc.bodyMarkdown, startsWith('## Purpose'));
    expect(doc.bodyMarkdown, contains('Search the elements.'));
  });

  test('keeps extra screenshots as heroes', () {
    const markdown = '''
# Details

![Details](asset:assets/help/images/details.png)

![Data](asset:assets/help/images/details_data.png)

Body copy.
''';
    final doc = HelpDocument.parse(markdown);
    expect(doc.images.map((e) => e.alt).toList(), ['Details', 'Data']);
    expect(doc.bodyMarkdown, 'Body copy.');
  });

  test('body-only markdown has no heroes', () {
    final doc = HelpDocument.parse('## Purpose\n\nHello.');
    expect(doc.hasHeroImages, isFalse);
    expect(doc.bodyMarkdown, '## Purpose\n\nHello.');
  });

  test('previous and next follow the guide order', () {
    expect(HelpCatalog.previous(HelpCatalog.table), isNull);
    expect(HelpCatalog.next(HelpCatalog.table)?.id, HelpCatalog.details);
    expect(HelpCatalog.previous(HelpCatalog.details)?.id, HelpCatalog.table);
    expect(HelpCatalog.next(HelpCatalog.about), isNull);
    expect(HelpCatalog.previous(HelpCatalog.about)?.id, HelpCatalog.appHealth);
    expect(
      HelpCatalog.roomTopics,
      [HelpCatalog.table, HelpCatalog.details, HelpCatalog.compare, HelpCatalog.spectra],
    );
  });
}
