import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'learner_database.g.dart';

class PreferenceRows extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class Bookmarks extends Table {
  IntColumn get z => integer()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {z};
}

class Recents extends Table {
  IntColumn get z => integer()();
  IntColumn get viewedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {z};
}

class SavedComparisons extends Table {
  IntColumn get zA => integer()();
  IntColumn get zB => integer()();
  IntColumn get displayA => integer()();
  IntColumn get displayB => integer()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {zA, zB};
}

class EntitlementRows extends Table {
  TextColumn get packageId => text()();
  TextColumn get status => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {packageId};
}

class QuizAnswers extends Table {
  IntColumn get z => integer()();
  TextColumn get depth => text()();
  TextColumn get questionId => text()();
  BoolColumn get correct => boolean()();
  IntColumn get answeredAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {z, depth, questionId};
}

class QuizDays extends Table {
  TextColumn get day => text()();
  IntColumn get answeredAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {day};
}

class QuizNotes extends Table {
  IntColumn get z => integer()();
  TextColumn get note => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {z};
}

class QuizReports extends Table {
  IntColumn get z => integer()();
  TextColumn get depth => text()();
  TextColumn get questionId => text()();
  TextColumn get note => text()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {z, depth, questionId};
}

@DriftDatabase(
  tables: [
    PreferenceRows,
    Bookmarks,
    Recents,
    SavedComparisons,
    EntitlementRows,
    QuizAnswers,
    QuizDays,
    QuizNotes,
    QuizReports,
  ],
)
class LearnerDatabase extends _$LearnerDatabase {
  LearnerDatabase() : super(_open());

  LearnerDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(quizAnswers);
        await m.createTable(quizDays);
        await m.createTable(quizNotes);
        await m.createTable(quizReports);
      }
    },
  );

  static QueryExecutor _open() {
    return driftDatabase(
      name: 'element_deck_learner',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  Future<String?> pref(String key) async {
    final row = await (select(preferenceRows)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setPref(String key, String value) async {
    await into(preferenceRows).insertOnConflictUpdate(
      PreferenceRowsCompanion.insert(
        key: key,
        value: value,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<Set<int>> bookmarkZs() async {
    final rows = await select(bookmarks).get();
    return rows.map((e) => e.z).toSet();
  }

  Future<void> toggleBookmark(int z) async {
    final existing = await (select(bookmarks)..where((t) => t.z.equals(z)))
        .getSingleOrNull();
    if (existing == null) {
      await into(bookmarks).insert(
        BookmarksCompanion(
          z: Value(z),
          createdAt: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );
    } else {
      await (delete(bookmarks)..where((t) => t.z.equals(z))).go();
    }
  }

  Future<List<int>> recentZs() async {
    final rows = await (select(recents)
          ..orderBy([(t) => OrderingTerm.desc(t.viewedAt)]))
        .get();
    return rows.map((e) => e.z).toList();
  }

  Future<void> touchRecent(int z) async {
    await into(recents).insertOnConflictUpdate(
      RecentsCompanion(
        z: Value(z),
        viewedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<void> saveComparison(int a, int b) async {
    final lo = a < b ? a : b;
    final hi = a < b ? b : a;
    await into(savedComparisons).insertOnConflictUpdate(
      SavedComparisonsCompanion.insert(
        zA: lo,
        zB: hi,
        displayA: a,
        displayB: b,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<List<SavedComparison>> comparisons() => select(savedComparisons).get();

  Future<Set<String>> activePackages() async {
    final rows = await (select(entitlementRows)
          ..where((t) => t.status.equals('active')))
        .get();
    return rows.map((e) => e.packageId).toSet();
  }

  Future<void> setEntitlement(String packageId, String status) async {
    await into(entitlementRows).insertOnConflictUpdate(
      EntitlementRowsCompanion.insert(
        packageId: packageId,
        status: status,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> erase() async {
    await delete(preferenceRows).go();
    await delete(bookmarks).go();
    await delete(recents).go();
    await delete(savedComparisons).go();
    await delete(entitlementRows).go();
    await delete(quizAnswers).go();
    await delete(quizDays).go();
    await delete(quizNotes).go();
    await delete(quizReports).go();
  }

  static String civilDay(DateTime now) {
    final d = DateTime(now.year, now.month, now.day);
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  Future<Map<String, bool>> quizAnswersFor(int z, String depth) async {
    final rows = await (select(
      quizAnswers,
    )..where((t) => t.z.equals(z) & t.depth.equals(depth))).get();
    return {for (final r in rows) r.questionId: r.correct};
  }

  Future<void> recordQuizAnswer({
    required int z,
    required String depth,
    required String questionId,
    required bool correct,
    DateTime? now,
  }) async {
    final at = (now ?? DateTime.now()).millisecondsSinceEpoch;
    await into(quizAnswers).insertOnConflictUpdate(
      QuizAnswersCompanion.insert(
        z: z,
        depth: depth,
        questionId: questionId,
        correct: correct,
        answeredAt: at,
      ),
    );
    await into(quizDays).insertOnConflictUpdate(
      QuizDaysCompanion.insert(day: civilDay(now ?? DateTime.now()), answeredAt: at),
    );
  }

  Future<int> quizCorrectCount() async {
    final rows = await (select(
      quizAnswers,
    )..where((t) => t.correct.equals(true))).get();
    return rows.length;
  }

  Future<int> quizFinishedPoolCount({int poolSize = 50}) async {
    final rows = await select(quizAnswers).get();
    final counts = <String, int>{};
    for (final r in rows) {
      final key = '${r.z}|${r.depth}';
      counts[key] = (counts[key] ?? 0) + 1;
    }
    return counts.values.where((c) => c >= poolSize).length;
  }

  Future<int> quizStreak(DateTime now) async {
    final rows = await select(quizDays).get();
    if (rows.isEmpty) return 0;
    final days = rows.map((r) => r.day).toSet();
    final today = DateTime(now.year, now.month, now.day);
    final todayS = civilDay(today);
    final yesterdayS = civilDay(today.subtract(const Duration(days: 1)));
    if (!days.contains(todayS) && !days.contains(yesterdayS)) return 0;
    var cursor = days.contains(todayS)
        ? today
        : today.subtract(const Duration(days: 1));
    var count = 0;
    while (days.contains(civilDay(cursor))) {
      count++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return count;
  }

  Future<String> quizNote(int z) async {
    final row = await (select(
      quizNotes,
    )..where((t) => t.z.equals(z))).getSingleOrNull();
    return row?.note ?? '';
  }

  Future<void> setQuizNote(int z, String note) async {
    await into(quizNotes).insertOnConflictUpdate(
      QuizNotesCompanion(
        z: Value(z),
        note: Value(note),
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<void> reportQuizQuestion({
    required int z,
    required String depth,
    required String questionId,
    required String note,
  }) async {
    await into(quizReports).insertOnConflictUpdate(
      QuizReportsCompanion.insert(
        z: z,
        depth: depth,
        questionId: questionId,
        note: note,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<Map<String, dynamic>> exportJson() async {
    return {
      'preferences': {
        for (final r in await select(preferenceRows).get()) r.key: r.value,
      },
      'bookmarks': [for (final r in await select(bookmarks).get()) r.z],
      'comparisons': [
        for (final r in await select(savedComparisons).get())
          {'a': r.displayA, 'b': r.displayB},
      ],
    };
  }
}
