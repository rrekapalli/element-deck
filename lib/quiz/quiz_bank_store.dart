import 'dart:convert';

import 'package:flutter/services.dart';

import 'quiz_models.dart';

class QuizBankStore {
  QuizBankStore({this.assetPrefix = 'assets/catalog/quiz'});

  final String assetPrefix;
  final Map<int, QuizBank> _cache = {};

  Future<QuizBank> load(int z) async {
    final cached = _cache[z];
    if (cached != null) return cached;
    final raw = await rootBundle.loadString('$assetPrefix/$z.json');
    final bank = QuizBank.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    _cache[z] = bank;
    return bank;
  }
}
