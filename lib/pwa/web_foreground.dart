import 'web_foreground_stub.dart'
    if (dart.library.js_interop) 'web_foreground_web.dart';

/// Installed PWAs often skip Flutter [AppLifecycleState]. Bind browser
/// visibility and pageshow so an update check runs when the app is opened.
void bindWebForeground(void Function() onForeground) =>
    bindWebForegroundImpl(onForeground);
