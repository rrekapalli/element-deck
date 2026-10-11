import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ElementDeckUi {
  static const wideMinWidth = 900.0;
  static const tabletShortest = 600.0;

  static bool isTabletOrWider(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.shortestSide >= tabletShortest || size.width >= wideMinWidth;
  }

  static bool isWideShell(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (size.width < wideMinWidth) return false;
    if (kIsWeb) return true;
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return size.shortestSide >= tabletShortest;
      default:
        return size.width >= wideMinWidth;
    }
  }
}
