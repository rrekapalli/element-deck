import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class CatalogCache {
  String? sqlitePath;

  Future<Directory> _dir() async {
    final docs = await getApplicationDocumentsDirectory();
    return Directory(p.join(docs.path, 'packs'));
  }

  Future<File> _sqliteFile() async {
    final dir = await _dir();
    return File(p.join(dir.path, 'catalog.sqlite'));
  }

  Future<File> _jsonFile() async {
    final dir = await _dir();
    return File(p.join(dir.path, 'catalog.json'));
  }

  Future<String?> readSqliteJson() async {
    try {
      final file = await _sqliteFile();
      if (!file.existsSync()) return null;
      sqlitePath = file.path;
      final db = sqlite3.open(file.path, mode: OpenMode.readOnly);
      try {
        final meta = db.select('SELECT id, version, science_pins FROM pack_meta LIMIT 1');
        if (meta.isEmpty) return null;
        final elements = db.select('SELECT json FROM elements ORDER BY z');
        final notes = db.select('SELECT json FROM trend_notes');
        return jsonEncode({
          'id': meta.first['id'],
          'version': meta.first['version'],
          'sciencePins': jsonDecode(meta.first['science_pins'] as String),
          'elements': [
            for (final r in elements) jsonDecode(r['json'] as String),
          ],
          'trendNotes': [
            for (final r in notes) jsonDecode(r['json'] as String),
          ],
        });
      } finally {
        db.dispose();
      }
    } catch (_) {
      return null;
    }
  }

  Future<void> writeSqlite(List<int> bytes) async {
    final file = await _sqliteFile();
    await file.parent.create(recursive: true);
    final tmp = File('${file.path}.tmp');
    await tmp.writeAsBytes(bytes, flush: true);
    if (file.existsSync()) await file.delete();
    await tmp.rename(file.path);
    sqlitePath = file.path;
  }

  Future<String?> readJsonFile() async {
    try {
      final file = await _jsonFile();
      if (!file.existsSync()) return null;
      return file.readAsStringSync();
    } catch (_) {
      return null;
    }
  }

  Future<void> writeJsonFile(String json) async {
    final file = await _jsonFile();
    await file.parent.create(recursive: true);
    await file.writeAsString(json, flush: true);
  }

  Future<void> deleteFiles() async {
    final sqlite = await _sqliteFile();
    final json = await _jsonFile();
    if (sqlite.existsSync()) await sqlite.delete();
    if (json.existsSync()) await json.delete();
    sqlitePath = null;
  }
}
