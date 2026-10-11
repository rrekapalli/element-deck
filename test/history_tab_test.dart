import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:element_deck/account/account_controller.dart';
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
  testWidgets('History tab explains the discovery and the cosmic origin', (
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
    final settings = SettingsController(db);
    final selection = SelectionController(db, catalog)..currentZ = 24;
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

    await tester.tap(find.text('History'));
    await tester.pump();

    expect(find.text('History of Chromium'), findsOneWidget);
    expect(find.text('How Chromium was discovered'), findsOneWidget);
    expect(find.text('Louis-Nicolas Vauquelin'), findsWidgets);
    expect(find.textContaining('potassium carbonate'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Formed in the Universe'), 400);
    expect(find.text('Formed in the Universe'), findsOneWidget);
    expect(find.textContaining('chromium-52'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Red Crystals from Siberia'),
      400,
    );
    expect(find.text('Red Crystals from Siberia'), findsOneWidget);
  });
}
