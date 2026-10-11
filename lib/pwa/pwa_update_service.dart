import 'package:flutter/foundation.dart';

import 'pwa_update_service_stub.dart'
    if (dart.library.js_interop) 'pwa_update_service_web.dart';

/// Detects a waiting PWA service worker and applies it.
abstract class PwaUpdateService extends ChangeNotifier {
  static final PwaUpdateService instance = createPwaUpdateService();

  bool get updateReady;

  void start();

  /// Re-check for a waiting worker (app opened or resumed).
  void checkForUpdate();

  void dismiss();

  Future<void> applyUpdate();
}
