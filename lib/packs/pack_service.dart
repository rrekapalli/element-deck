import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../account/account_controller.dart';
import '../billing/pack_ids.dart';
import '../data/catalog_store.dart';

class PackService {
  PackService(this.store, this.account);

  final CatalogStore store;
  final AccountController account;

  String? publishedVersion;
  String? status;

  Future<void> downloadIfEntitled() async {
    if (!coursePacksEnabled) {
      await _loadFixtureJson();
      return;
    }
    if (!account.hasCore) {
      status = 'Preview only';
      return;
    }
    try {
      final meta = await FirebaseFirestore.instance
          .collection('contentPacks')
          .doc('core')
          .get();
      if (!meta.exists) {
        await _loadFixtureJson();
        return;
      }
      final data = meta.data()!;
      publishedVersion = data['version'] as String?;
      final path = data['storagePath'] as String? ??
          'packs/core/${data['version']}/catalog.sqlite';
      final checksum = data['sha256'] as String? ?? '';
      final ref = FirebaseStorage.instance.ref(path);
      final bytes = await ref.getData(20 * 1024 * 1024);
      if (bytes == null) {
        await _loadFixtureJson();
        return;
      }
      final hash = sha256.convert(bytes).toString();
      if (checksum.isNotEmpty && hash != checksum) {
        throw StateError('checksum mismatch');
      }
      await store.writeCacheBytes(bytes, checksum: checksum);
      account.packVersion = publishedVersion;
      status = 'Pack ${publishedVersion ?? ''} cached';
    } catch (_) {
      await _loadFixtureJson();
    }
  }

  Future<void> _loadFixtureJson() async {
    if (!debugEntitlement && !account.hasCore) return;
    final raw = await rootBundle.loadString('assets/catalog/core.json');
    await store.writeCacheJson(raw, checksum: '');
    account.packVersion = jsonDecode(raw)['version'] as String?;
    status = 'Fixture pack cached';
  }
}
