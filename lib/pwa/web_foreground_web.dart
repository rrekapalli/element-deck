import 'dart:js_interop';

import 'package:web/web.dart' as web;

DateTime? _lastFireAt;

void bindWebForegroundImpl(void Function() onForeground) {
  void fire(web.Event _) {
    final now = DateTime.now();
    if (_lastFireAt != null &&
        now.difference(_lastFireAt!) < const Duration(milliseconds: 1500)) {
      return;
    }
    _lastFireAt = now;
    onForeground();
  }

  void onVisibility(web.Event event) {
    if (web.document.visibilityState == 'visible') fire(event);
  }

  web.document.addEventListener('visibilitychange', onVisibility.toJS);
  web.window.addEventListener('pageshow', fire.toJS);
  web.window.addEventListener('focus', fire.toJS);
}
