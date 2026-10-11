import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../account/account_controller.dart';

class ClassroomInfo {
  ClassroomInfo({
    required this.id,
    required this.name,
    required this.joinCode,
    required this.ownerUid,
    required this.pinned,
    required this.suggestedDepth,
  });

  final String id;
  final String name;
  final String joinCode;
  final String ownerUid;
  final List<int> pinned;
  final String suggestedDepth;
}

class ClassroomController extends ChangeNotifier {
  ClassroomController(this.account);

  final AccountController account;
  ClassroomInfo? current;
  String? error;

  Future<void> create({required String name, required List<int> pinned, required String depth}) async {
    final uid = account.user?.uid;
    if (uid == null) {
      error = 'Sign in to create a class.';
      notifyListeners();
      return;
    }
    if (!account.hasClassroom) {
      error = 'Classroom is a later package. Buy it after Element Deck restores on this account.';
      notifyListeners();
      return;
    }
    final code = DateTime.now().millisecondsSinceEpoch.toRadixString(36).substring(4);
    final ref = await FirebaseFirestore.instance.collection('classrooms').add({
      'name': name,
      'joinCode': code,
      'ownerUid': uid,
      'pinned': pinned,
      'suggestedDepth': depth,
    });
    current = ClassroomInfo(
      id: ref.id,
      name: name,
      joinCode: code,
      ownerUid: uid,
      pinned: pinned,
      suggestedDepth: depth,
    );
    notifyListeners();
  }

  Future<void> join(String code) async {
    final snap = await FirebaseFirestore.instance
        .collection('classrooms')
        .where('joinCode', isEqualTo: code.trim())
        .limit(1)
        .get();
    if (snap.docs.isEmpty) {
      error = 'No class for that code.';
      notifyListeners();
      return;
    }
    final doc = snap.docs.first;
    final data = doc.data();
    current = ClassroomInfo(
      id: doc.id,
      name: data['name'] as String? ?? 'Class',
      joinCode: data['joinCode'] as String,
      ownerUid: data['ownerUid'] as String? ?? '',
      pinned: (data['pinned'] as List<dynamic>? ?? []).map((e) => e as int).toList(),
      suggestedDepth: data['suggestedDepth'] as String? ?? 'intermediate',
    );
    final uid = account.user?.uid;
    if (uid != null) {
      await doc.reference.collection('members').doc(uid).set({
        'role': 'learner',
        'joinedAt': FieldValue.serverTimestamp(),
      });
    }
    error = null;
    notifyListeners();
  }

  void leave() {
    current = null;
    notifyListeners();
  }
}
