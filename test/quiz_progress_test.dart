import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:element_deck/data/catalog_store.dart';
import 'package:element_deck/data/learner_database.dart';
import 'package:element_deck/models/catalog.dart';
import 'package:element_deck/providers/catalog_controller.dart';
import 'package:element_deck/providers/selection_controller.dart';
import 'package:element_deck/quiz/quiz_bank_store.dart';
import 'package:element_deck/quiz/quiz_controller.dart';
import 'package:element_deck/quiz/quiz_models.dart';
import 'package:flutter_test/flutter_test.dart';

class _MemoryStore extends QuizBankStore {
  _MemoryStore(this.bank);
  final QuizBank bank;

  @override
  Future<QuizBank> load(int z) async => bank;
}

void main() {
  late LearnerDatabase db;
  late QuizController quiz;
  late QuizBank bank;
  var clock = DateTime(2026, 10, 11);

  setUp(() {
    db = LearnerDatabase.forTesting(NativeDatabase.memory());
    final pack = CatalogPack.fromJson(
      jsonDecode(File('assets/catalog/preview.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    final catalog = CatalogController(CatalogStore()..pack = pack)
      ..loading = false;
    final selection = SelectionController(db, catalog);
    bank = QuizBank.fromJson(
      jsonDecode(File('assets/catalog/quiz/1.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    clock = DateTime(2026, 10, 11);
    quiz = QuizController(
      db,
      catalog,
      selection,
      store: _MemoryStore(bank),
      now: () => clock,
    );
  });

  tearDown(() => db.close());

  test('a correct answer locks and adds 20 XP; a miss adds none', () async {
    await quiz.open(z: 1, depth: 'beginner');
    final q = quiz.current!;
    await quiz.choose(q.correctIndex);
    expect(quiz.picked, q.correctIndex);
    expect(quiz.xp, QuizController.xpPerCorrect);
    expect(quiz.answered[q.id], isTrue);

    quiz.next();
    final q2 = quiz.current!;
    expect(q2.id, isNot(q.id));
    final wrong = q2.correctIndex == 0 ? 1 : 0;
    await quiz.choose(wrong);
    expect(quiz.xp, QuizController.xpPerCorrect);
    expect(quiz.answered[q2.id], isFalse);
  });

  test('switching depth loads the other pool without deleting the first', () async {
    await quiz.open(z: 1, depth: 'beginner');
    final firstId = quiz.current!.id;
    await quiz.choose(quiz.current!.correctIndex);

    await quiz.open(z: 1, depth: 'advanced');
    expect(quiz.answered, isEmpty);
    expect(quiz.depth, 'advanced');
    expect(quiz.xp, QuizController.xpPerCorrect);

    await quiz.open(z: 1, depth: 'beginner');
    expect(quiz.answered[firstId], isTrue);
  });

  test('streak uses the local civil date and a missed day resets on the next answer', () async {
    await quiz.open(z: 1, depth: 'beginner');
    await quiz.choose(quiz.current!.correctIndex);
    expect(quiz.streak, 1);

    clock = DateTime(2026, 10, 12);
    quiz.next();
    await quiz.choose(quiz.current!.correctIndex);
    expect(quiz.streak, 2);

    clock = DateTime(2026, 10, 15);
    expect(await db.quizStreak(clock), 0);
    quiz.next();
    await quiz.choose(quiz.current!.correctIndex);
    expect(quiz.streak, 1);
  });

  test('tier names follow finished pool counts', () {
    expect(quizTierName(0), 'Observer');
    expect(quizTierName(1), 'Student');
    expect(quizTierName(5), 'Scholar');
    expect(quizTierName(15), 'Fellow');
    expect(quizTierName(40), 'Master');
  });
}
