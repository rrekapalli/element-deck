import 'pwa_update_service.dart';

PwaUpdateService createPwaUpdateService() => _StubPwaUpdateService();

class _StubPwaUpdateService extends PwaUpdateService {
  @override
  bool get updateReady => false;

  @override
  void start() {}

  @override
  void checkForUpdate() {}

  @override
  void dismiss() {}

  @override
  Future<void> applyUpdate() async {}
}
