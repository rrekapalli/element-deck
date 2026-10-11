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

@DriftDatabase(
  tables: [PreferenceRows, Bookmarks, Recents, SavedComparisons, EntitlementRows],
)
class LearnerDatabase extends _$LearnerDatabase {
  LearnerDatabase() : super(_open());

  LearnerDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

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
