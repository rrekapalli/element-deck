import 'package:flutter/material.dart';

import '../data/learner_database.dart';
import '../models/catalog.dart';
import 'catalog_controller.dart';

class SelectionController extends ChangeNotifier {
  SelectionController(this._db, this._catalog);

  final LearnerDatabase _db;
  final CatalogController _catalog;

  int currentZ = 22;
  int compareA = 6;
  int compareB = 14;
  int detailsTab = 0;
  bool neighborsRequested = false;
  String search = '';
  String categoryFilter = 'all';
  Set<int> bookmarks = {};
  List<int> recents = [];

  CatalogPack get pack => _catalog.pack;

  Future<void> load() async {
    bookmarks = await _db.bookmarkZs();
    recents = await _db.recentZs();
    final last = await _db.pref('selection.z');
    if (last != null) currentZ = int.tryParse(last) ?? currentZ;
    if (pack.byZ(currentZ) == null && pack.elements.isNotEmpty) {
      currentZ = pack.elements.first.z;
    }
    notifyListeners();
  }

  ElementRecord? get current => pack.byZ(currentZ);

  Future<void> select(int z, {bool openDetails = false}) async {
    if (currentZ != z) {
      currentZ = z;
      await _db.setPref('selection.z', '$z');
      await _db.touchRecent(z);
      recents = await _db.recentZs();
      if (compareA != z && compareB != z) {
        compareA = z;
        compareB = suggestedNeighbor(z);
      }
    }
    notifyListeners();
  }

  int suggestedNeighbor(int z) {
    final e = pack.byZ(z);
    if (e == null) return z == 6 ? 14 : 6;
    for (final n in pack.trendNotes) {
      if (n.zA == z) return n.zB;
      if (n.zB == z) return n.zA;
    }
    if (e.group != null) {
      final below = pack.elements.where((o) => o.group == e.group && o.z > z);
      if (below.isNotEmpty) return below.first.z;
      final above = pack.elements.where((o) => o.group == e.group && o.z < z);
      if (above.isNotEmpty) return above.last.z;
    }
    return z == 1 ? 2 : z - 1;
  }

  Future<void> setPair(int a, int b) async {
    if (compareA == a && compareB == b) return;
    compareA = a;
    compareB = b;
    notifyListeners();
  }

  void openNeighbors({required int a, required int b}) {
    compareA = a;
    compareB = b;
    currentZ = a;
    detailsTab = 4;
    neighborsRequested = true;
    notifyListeners();
  }

  void clearNeighborsRequest() {
    if (!neighborsRequested) return;
    neighborsRequested = false;
  }

  Future<void> toggleBookmark(int z) async {
    await _db.toggleBookmark(z);
    bookmarks = await _db.bookmarkZs();
    notifyListeners();
  }

  Future<void> saveCurrentComparison() async {
    await _db.saveComparison(compareA, compareB);
    notifyListeners();
  }

  void setSearch(String q) {
    search = q;
    notifyListeners();
  }

  void setCategory(String id) {
    categoryFilter = id;
    notifyListeners();
  }

  List<ElementRecord> get filtered {
    var list = pack.elements;
    if (categoryFilter != 'all') {
      list = list.where((e) {
        if (categoryFilter == 'halogen') return e.isHalogen;
        return e.categoryId == categoryFilter;
      }).toList();
    }
    final q = search.trim().toLowerCase();
    if (q.isEmpty) return list;
    final asZ = int.tryParse(q);
    return list.where((e) {
      if (asZ != null && e.z == asZ) return true;
      if (e.symbol.toLowerCase() == q) return true;
      if (e.name.toLowerCase().contains(q)) return true;
      return false;
    }).toList();
  }

  ElementRecord elementOfTheDay() {
    final day = DateTime.now();
    final seed = day.year * 1000 + day.month * 50 + day.day;
    final list = pack.elements;
    if (list.isEmpty) {
      throw StateError('empty catalog');
    }
    return list[seed.abs() % list.length];
  }
}
