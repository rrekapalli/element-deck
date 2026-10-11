import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Returns true when a default Firebase app started.
/// Missing google-services / options is a normal local preview.
Future<bool> bootstrapFirebase() async {
  try {
    if (Firebase.apps.isNotEmpty) return true;
    await Firebase.initializeApp();
    return true;
  } catch (e) {
    debugPrint('Firebase not configured: $e');
    return false;
  }
}
