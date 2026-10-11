import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/catalog.dart';
import 'catalog_cache.dart' if (dart.library.io) 'catalog_cache_io.dart';

class CatalogStore {
  CatalogStore();

  final CatalogCache _cache = CatalogCache();
  CatalogPack? pack;
  bool fromCache = false;
  String? cachePath;

  CatalogPack get requirePack =>
      pack ?? (throw StateError('Catalog not loaded'));

  Future<void> load({required bool hasCoreEntitlement}) async {
    if (hasCoreEntitlement) {
      final sqliteJson = await _cache.readSqliteJson();
      if (sqliteJson != null) {
        pack = CatalogPack.fromJson(jsonDecode(sqliteJson) as Map<String, dynamic>);
        fromCache = true;
        cachePath = _cache.sqlitePath;
        return;
      }
      final cachedJson = await _cache.readJsonFile();
      if (cachedJson != null) {
        pack = CatalogPack.fromJson(jsonDecode(cachedJson) as Map<String, dynamic>);
        fromCache = true;
        return;
      }
    }
    pack = await _loadAsset('assets/catalog/preview.json');
    fromCache = false;
  }

  Future<CatalogPack> _loadAsset(String asset) async {
    final raw = await rootBundle.loadString(asset);
    return CatalogPack.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> writeCacheBytes(List<int> bytes, {required String checksum}) async {
    await _cache.writeSqlite(bytes);
    cachePath = _cache.sqlitePath;
    final sqliteJson = await _cache.readSqliteJson();
    if (sqliteJson != null) {
      pack = CatalogPack.fromJson(jsonDecode(sqliteJson) as Map<String, dynamic>);
      fromCache = true;
    }
  }

  Future<void> writeCacheJson(String json, {required String checksum}) async {
    await _cache.writeJsonFile(json);
    pack = CatalogPack.fromJson(jsonDecode(json) as Map<String, dynamic>);
    fromCache = true;
  }

  Future<void> deleteCache() async {
    await _cache.deleteFiles();
    fromCache = false;
    cachePath = null;
    pack = await _loadAsset('assets/catalog/preview.json');
  }
}
