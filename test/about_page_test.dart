import 'package:element_deck/settings/settings_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  testWidgets('About shows the app version under the title', (tester) async {
    PackageInfo.setMockInitialValues(
      appName: 'Element Deck',
      packageName: 'element_deck',
      version: '0.26.0',
      buildNumber: '26',
      buildSignature: '',
    );

    await tester.pumpWidget(const MaterialApp(home: AboutPage()));
    await tester.pump();

    expect(find.text('Element Deck'), findsWidgets);
    expect(find.text('Version 0.26.0'), findsOneWidget);
    expect(find.textContaining('not a lab measurement'), findsOneWidget);
  });
}
