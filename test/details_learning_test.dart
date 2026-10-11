import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:element_deck/data/catalog_store.dart';
import 'package:element_deck/data/learner_database.dart';
import 'package:element_deck/models/catalog.dart';
import 'package:element_deck/providers/catalog_controller.dart';
import 'package:element_deck/providers/selection_controller.dart';
import 'package:element_deck/providers/settings_controller.dart';
import 'package:element_deck/rooms/details_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Details copy follows learning mode, and Uses replaces Trivia', (
    tester,
  ) async {
    final pack = CatalogPack.fromJson(
      jsonDecode(File('assets/catalog/core.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final store = CatalogStore()..pack = pack;
    final catalog = CatalogController(store)..loading = false;
    final db = LearnerDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final settings = SettingsController(db)..depth = 'beginner';
    final selection = SelectionController(db, catalog)..currentZ = 1;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: catalog),
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: selection),
        ],
        child: const MaterialApp(home: Scaffold(body: DetailsRoom())),
      ),
    );
    await tester.pump();

    expect(find.text('Trivia'), findsNothing);
    expect(find.textContaining('You meet it in water'), findsOneWidget);
    expect(find.textContaining('1s1'), findsNothing);
    expect(
      find.textContaining('1 electron in the first shell'),
      findsOneWidget,
    );

    settings.depth = 'advanced';
    settings.notifyListeners();
    await tester.pump();

    expect(find.textContaining('Balmer series'), findsOneWidget);
    expect(find.textContaining('1s1'), findsWidgets);
    expect(find.textContaining('You meet it in water'), findsNothing);

    settings.depth = 'beginner';
    settings.notifyListeners();
    await tester.pump();
    await tester.scrollUntilVisible(
      find.textContaining('The picture shows the electrons'),
      300,
    );
    expect(
      find.textContaining('The picture shows the electrons'),
      findsOneWidget,
    );

    await tester.tap(find.text('Uses'));
    await tester.pump();
    expect(find.text('The pure element'), findsOneWidget);
    expect(find.textContaining('CC BY-SA'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Water'), 300);
    expect(find.text('Water'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Stars'), 300);
    expect(find.text('Stars'), findsOneWidget);
    expect(find.textContaining('NASA / SDO'), findsOneWidget);
  });
}
