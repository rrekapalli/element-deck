import 'package:flutter/widgets.dart';

import 'app.dart';
import 'data/catalog_store.dart';
import 'data/learner_database.dart';
import 'firebase/firebase_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseReady = await bootstrapFirebase();
  final db = LearnerDatabase();
  final store = CatalogStore();
  runApp(
    ElementDeckApp(
      db: db,
      store: store,
      firebaseReady: firebaseReady,
    ),
  );
}
