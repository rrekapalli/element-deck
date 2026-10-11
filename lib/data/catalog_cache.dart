/// Web stub: pack cache stays in memory as JSON. SQLite FFI is native-only.
class CatalogCache {
  Future<String?> readSqliteJson() async => null;

  Future<void> writeSqlite(List<int> bytes) async {}

  Future<String?> readJsonFile() async => null;

  Future<void> writeJsonFile(String json) async {}

  Future<void> deleteFiles() async {}

  String? get sqlitePath => null;
}
