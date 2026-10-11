import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'pwa_update_service.dart';

@JS('__elementdeckApplyPwaUpdate')
external void _applyPwaUpdateJs();

@JS('__elementdeckCheckPwaUpdate')
external void _checkPwaUpdateJs(JSBoolean force);

@JS('__elementdeckNotifyPwaIfReady')
external void _notifyPwaIfReadyJs();

PwaUpdateService createPwaUpdateService() => _WebPwaUpdateService();

class _WebPwaUpdateService extends PwaUpdateService {
  bool _ready = false;
  bool _started = false;

  @override
  bool get updateReady => _ready;

  @override
  void start() {
    if (_started) return;
    _started = true;
    web.window.addEventListener('elementdeck-pwa-update', _onReady.toJS);
    try {
      _checkPwaUpdateJs(true.toJS);
    } catch (_) {}
    try {
      _notifyPwaIfReadyJs();
    } catch (_) {}
  }

  @override
  void checkForUpdate() {
    try {
      _checkPwaUpdateJs(true.toJS);
    } catch (_) {}
  }

  void _onReady(web.Event _) {
    if (_ready) return;
    _ready = true;
    notifyListeners();
  }

  @override
  void dismiss() {
    if (!_ready) return;
    _ready = false;
    notifyListeners();
  }

  @override
  Future<void> applyUpdate() async {
    try {
      _applyPwaUpdateJs();
    } catch (_) {
      web.window.location.reload();
    }
  }
}
