import 'package:flutter/foundation.dart';

import '../data/learner_database.dart';
import '../models/catalog.dart';
import '../providers/catalog_controller.dart';
import '../providers/selection_controller.dart';
import 'quiz_bank_store.dart';
import 'quiz_models.dart';

class QuizController extends ChangeNotifier {
  QuizController(
    this._db,
    this._catalog,
    this._selection, {
    QuizBankStore? store,
    this.now = DateTime.now,
  }) : _store = store ?? QuizBankStore();

  final LearnerDatabase _db;
  final CatalogController _catalog;
  final SelectionController _selection;
  final QuizBankStore _store;
  final DateTime Function() now;

  static const poolSize = 50;
  static const xpPerCorrect = 20;

  int focusZ = 0;
  String depth = 'intermediate';
  QuizBank? bank;
  List<QuizQuestion> pool = const [];
  Map<String, bool> answered = {};
  int index = 0;
  int? picked;
  bool loading = false;
  String? error;
  int xp = 0;
  int streak = 0;
  int finishedPools = 0;
  String note = '';
  String? _openKey;

  CatalogPack get pack => _catalog.pack;

  ElementRecord? get element => pack.byZ(focusZ);

  QuizQuestion? get current {
    if (index < 0 || index >= pool.length) return null;
    return pool[index];
  }

  bool get complete =>
      pool.isNotEmpty && answered.length >= pool.length;

  int get answeredCount => answered.length;

  int get correctInPool =>
      answered.values.where((v) => v).length;

  String get tierName => quizTierName(finishedPools);

  Future<void> refreshStats() async {
    xp = xpPerCorrect * await _db.quizCorrectCount();
    streak = await _db.quizStreak(now());
    finishedPools = await _db.quizFinishedPoolCount(poolSize: poolSize);
    notifyListeners();
  }

  void focusToday() {
    if (pack.elements.isEmpty) return;
    focusZ = _selection.elementOfTheDay().z;
    notifyListeners();
  }

  void setFocus(int z) {
    if (focusZ == z) return;
    focusZ = z;
    _openKey = null;
    notifyListeners();
  }

  Future<void> open({required int z, required String depth}) async {
    if (z <= 0) return;
    final key = '$z|$depth';
    if (_openKey == key && !loading && pool.isNotEmpty) {
      if (this.depth != depth) this.depth = depth;
      return;
    }
    _openKey = key;
    focusZ = z;
    this.depth = depth;
    loading = true;
    error = null;
    picked = null;
    notifyListeners();
    try {
      bank = await _store.load(z);
      pool = List.of(bank!.poolFor(depth));
      if (pool.length > poolSize) {
        pool = pool.take(poolSize).toList();
      }
      if (pool.isEmpty) {
        throw StateError('empty quiz pool');
      }
      answered = await _db.quizAnswersFor(z, depth);
      note = await _db.quizNote(z);
      index = _firstUnanswered();
      _syncPicked();
      await refreshStats();
    } catch (e) {
      error = 'Quiz bank unavailable for Z=$z';
      pool = const [];
      bank = null;
      _openKey = null;
    }
    loading = false;
    notifyListeners();
  }

  int _firstUnanswered() {
    for (var i = 0; i < pool.length; i++) {
      if (!answered.containsKey(pool[i].id)) return i;
    }
    return pool.isEmpty ? 0 : pool.length - 1;
  }

  bool get hasPrevious => index > 0;
  bool get hasNext => index < pool.length - 1;

  void _syncPicked() {
    final q = current;
    if (q == null || !answered.containsKey(q.id)) {
      picked = null;
      return;
    }
    picked = answered[q.id] == true ? q.correctIndex : null;
  }

  Future<void> choose(int option) async {
    final q = current;
    if (q == null) return;
    if (answered.containsKey(q.id)) return;
    if (picked != null) return;
    picked = option;
    notifyListeners();
    final ok = option == q.correctIndex;
    await _db.recordQuizAnswer(
      z: focusZ,
      depth: depth,
      questionId: q.id,
      correct: ok,
      now: now(),
    );
    answered = Map.of(answered)..[q.id] = ok;
    await refreshStats();
  }

  void next() {
    if (!hasNext) return;
    index++;
    _syncPicked();
    notifyListeners();
  }

  void previous() {
    if (!hasPrevious) return;
    index--;
    _syncPicked();
    notifyListeners();
  }

  void goTo(int i) {
    if (pool.isEmpty) return;
    index = i.clamp(0, pool.length - 1);
    _syncPicked();
    notifyListeners();
  }

  Future<void> saveNote(String value) async {
    note = value;
    await _db.setQuizNote(focusZ, value);
    notifyListeners();
  }

  Future<void> report(String value) async {
    final q = current;
    if (q == null) return;
    await _db.reportQuizQuestion(
      z: focusZ,
      depth: depth,
      questionId: q.id,
      note: value,
    );
  }

  Map<String, (int done, int total)> categoryBars() {
    final totals = <String, int>{};
    final done = <String, int>{};
    for (final q in pool) {
      totals[q.category] = (totals[q.category] ?? 0) + 1;
      if (answered.containsKey(q.id)) {
        done[q.category] = (done[q.category] ?? 0) + 1;
      }
    }
    return {
      for (final e in totals.entries) e.key: (done[e.key] ?? 0, e.value),
    };
  }

  List<int> switcherZs() {
    final today = pack.elements.isEmpty ? focusZ : _selection.elementOfTheDay().z;
    final out = <int>[];
    void add(int z) {
      if (pack.byZ(z) == null) return;
      if (!out.contains(z)) out.add(z);
    }

    add(today);
    add(_selection.currentZ);
    for (final z in _selection.recents) {
      add(z);
      if (out.length >= 4) break;
    }
    if (out.length < 3) {
      for (final e in pack.elements) {
        add(e.z);
        if (out.length >= 4) break;
      }
    }
    return out;
  }
}
