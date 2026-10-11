import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:element_deck/account/account_controller.dart';
import 'package:element_deck/billing/purchase_service.dart';
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
    final account = AccountController(db, store);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: catalog),
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: selection),
          ChangeNotifierProvider.value(value: account),
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

  testWidgets('carbon Forms and Neighbors open against silicon', (tester) async {
    final pack = CatalogPack.fromJson(
      jsonDecode(File('assets/catalog/core.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final store = CatalogStore()..pack = pack;
    final catalog = CatalogController(store)..loading = false;
    final db = LearnerDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final settings = SettingsController(db)..depth = 'beginner';
    final selection = SelectionController(db, catalog)..currentZ = 6;
    await selection.select(6);
    final account = AccountController(db, store);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: catalog),
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: selection),
          ChangeNotifierProvider.value(value: account),
        ],
        child: const MaterialApp(home: Scaffold(body: DetailsRoom())),
      ),
    );
    await tester.pump();

    await tester.scrollUntilVisible(find.text('Forms'), 400);
    expect(find.text('Forms'), findsOneWidget);
    expect(find.text('Diamond'), findsOneWidget);
    expect(find.text('Graphite'), findsOneWidget);
    expect(
      find.textContaining('every carbon atom is tied to four neighbors'),
      findsOneWidget,
    );

    await tester.tap(find.text('Neighbors'));
    await tester.pumpAndSettle();
    expect(find.text('VS'), findsOneWidget);
    expect(find.textContaining('Silicon'), findsWidgets);
  });

  testWidgets('unpaid sodium dossier offers a course pack', (tester) async {
    final index = CatalogPack.fromJson(
      jsonDecode(File('assets/catalog/index.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final preview = CatalogPack.fromJson(
      jsonDecode(File('assets/catalog/preview.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final byZ = {for (final e in index.elements) e.z: e};
    for (final e in preview.elements) {
      byZ[e.z] = e;
    }
    final pack = CatalogPack(
      id: 'preview',
      version: preview.version,
      sciencePins: preview.sciencePins,
      elements: byZ.values.toList()..sort((a, b) => a.z.compareTo(b.z)),
      trendNotes: preview.trendNotes,
    );
    final store = CatalogStore()..pack = pack;
    final catalog = CatalogController(store)..loading = false;
    final db = LearnerDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final settings = SettingsController(db)..depth = 'beginner';
    final selection = SelectionController(db, catalog)..currentZ = 11;
    final account = AccountController(db, store);
    final billing = PurchaseService(account);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: catalog),
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: selection),
          ChangeNotifierProvider.value(value: account),
          Provider.value(value: billing),
        ],
        child: const MaterialApp(home: Scaffold(body: DetailsRoom())),
      ),
    );
    await tester.pump();

    expect(find.textContaining('Sodium'), findsWidgets);
    expect(find.textContaining('The table is free'), findsOneWidget);
    expect(find.text('Sign in to buy'), findsOneWidget);
  });
}
