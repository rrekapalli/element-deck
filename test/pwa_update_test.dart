import 'package:flutter_test/flutter_test.dart';

import 'package:element_deck/pwa/pwa_update_service.dart';

void main() {
  test('native and test builds do not report a PWA update', () {
    final service = PwaUpdateService.instance;
    service.start();
    service.checkForUpdate();
    expect(service.updateReady, isFalse);
    service.dismiss();
    expect(service.updateReady, isFalse);
  });
}
