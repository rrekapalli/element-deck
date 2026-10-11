import 'dart:convert';
import 'dart:io';

import 'package:element_deck/quiz/quiz_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every element has 50 questions at each learning depth', () {
    const depths = ['beginner', 'intermediate', 'advanced'];
    for (var z = 1; z <= 118; z++) {
      final file = File('assets/catalog/quiz/$z.json');
      expect(file.existsSync(), isTrue, reason: 'missing quiz for Z=$z');
      final bank = QuizBank.fromJson(
        jsonDecode(file.readAsStringSync()) as Map<String, dynamic>,
      );
      expect(bank.z, z);
      for (final depth in depths) {
        final pool = bank.poolFor(depth);
        expect(pool, hasLength(50), reason: 'Z=$z $depth');
        expect(pool.map((q) => q.id).toSet(), hasLength(50), reason: 'ids Z=$z $depth');
        for (final q in pool) {
          expect(q.options, hasLength(4), reason: q.id);
          expect(q.options.toSet(), hasLength(4), reason: q.id);
          expect(q.correctIndex, inInclusiveRange(0, 3), reason: q.id);
          expect(q.explanation.trim(), isNotEmpty, reason: q.id);
          expect(q.stem.trim(), isNotEmpty, reason: q.id);
          if (depth == 'beginner') {
            final blob = '${q.stem} ${q.options.join(' ')} ${q.explanation}';
            expect(blob, isNot(contains('nuclear spin')), reason: q.id);
            expect(blob.toLowerCase(), isNot(contains('electronegativ')), reason: q.id);
            expect(blob, isNot(contains(' eV')), reason: q.id);
            if (z == 1) {
              expect(blob, isNot(contains('copernicium')), reason: q.id);
            }
          }
        }
      }
    }
  });
}
