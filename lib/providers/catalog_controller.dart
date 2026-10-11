import 'package:flutter/material.dart';

import '../data/catalog_store.dart';
import '../models/catalog.dart';

class CatalogController extends ChangeNotifier {
  CatalogController(this.store);

  final CatalogStore store;
  bool loading = true;
  String? error;

  CatalogPack get pack =>
      store.pack ??
      CatalogPack(
        id: 'preview',
        version: '0',
        sciencePins: const [],
        elements: const [],
        trendNotes: const [],
      );

  bool get isPreview => pack.id == 'preview';

  Future<void> load({required bool hasCoreEntitlement}) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await store.load(hasCoreEntitlement: hasCoreEntitlement);
    } catch (e) {
      error = '$e';
    }
    loading = false;
    notifyListeners();
  }

  Future<void> reload({required bool hasCoreEntitlement}) =>
      load(hasCoreEntitlement: hasCoreEntitlement);
}
