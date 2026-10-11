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
import 'package:element_deck/quiz/quiz_bank_store.dart';
import 'package:element_deck/quiz/quiz_controller.dart';
import 'package:element_deck/quiz/quiz_models.dart';
import 'package:element_deck/rooms/quiz_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class _MemoryStore extends QuizBankStore {
  _MemoryStore(this.bank);
  final QuizBank bank;

  @override
  Future<QuizBank> load(int z) async => bank;
}

void main() {
  testWidgets('Quiz room shows today\'s element and locks a correct answer', (
    tester,
  ) async {
    final pack = CatalogPack.fromJson(
      jsonDecode(File('assets/catalog/preview.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final store = CatalogStore()..pack = pack;
    final catalog = CatalogController(store)..loading = false;
    final db = LearnerDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final settings = SettingsController(db);
    final selection = SelectionController(db, catalog)..currentZ = 1;
    final bank = QuizBank.fromJson(
      jsonDecode(File('assets/catalog/quiz/1.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final quiz = QuizController(
      db,
      catalog,
      selection,
      store: _MemoryStore(bank),
    )..focusZ = 1;
    final account = AccountController(db, store);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: QuizRoom()),
        ),
        GoRoute(
          path: '/quiz/:z',
          builder: (context, state) => const Scaffold(body: QuizRoom()),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: catalog),
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: selection),
          ChangeNotifierProvider.value(value: quiz),
          ChangeNotifierProvider.value(value: account),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Change element · Hydrogen'), findsOneWidget);
    expect(find.textContaining('Question'), findsOneWidget);

    final q = quiz.current!;
    expect(find.text(q.stem), findsOneWidget);
    final option = find.byKey(ValueKey('quiz-option-${q.correctIndex}'));
    await tester.ensureVisible(option);
    await tester.tap(option);
    await tester.pumpAndSettle();

    expect(find.textContaining('Correct!'), findsOneWidget);
    expect(find.textContaining('Next'), findsWidgets);
    expect(quiz.xp, 20);

    final firstStem = q.stem;
    await tester.tap(find.widgetWithText(FilledButton, 'Next (1 / 50)'));
    await tester.pumpAndSettle();
    expect(find.text(firstStem), findsNothing);
    expect(quiz.index, 1);
  });

  testWidgets('Change element opens a searchable picker', (tester) async {
    final pack = CatalogPack.fromJson(
      jsonDecode(File('assets/catalog/preview.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final store = CatalogStore()..pack = pack;
    final catalog = CatalogController(store)..loading = false;
    final db = LearnerDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final settings = SettingsController(db);
    final selection = SelectionController(db, catalog)..currentZ = 1;
    final bank = QuizBank.fromJson(
      jsonDecode(File('assets/catalog/quiz/1.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final quiz = QuizController(
      db,
      catalog,
      selection,
      store: _MemoryStore(bank),
    )..focusZ = 1;
    final account = AccountController(db, store);
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: QuizRoom()),
        ),
        GoRoute(
          path: '/quiz/:z',
          builder: (context, state) => const Scaffold(body: QuizRoom()),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: catalog),
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider.value(value: selection),
          ChangeNotifierProvider.value(value: quiz),
          ChangeNotifierProvider.value(value: account),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining('Change element'));
    await tester.pumpAndSettle();
    expect(find.text('Search name, symbol, or number'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, 'ti');
    await tester.pump();
    expect(find.text('Titanium'), findsOneWidget);
    await tester.tap(find.text('Titanium'));
    await tester.pumpAndSettle();
    expect(selection.currentZ, 22);
    expect(quiz.focusZ, 22);
  });
}
