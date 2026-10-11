import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../billing/pack_ids.dart';
import '../data/catalog_store.dart';
import '../data/learner_database.dart';

const _debugEntitlementFlag = bool.fromEnvironment('DEBUG_ENTITLEMENT');

/// Compile-time fixture entitlement. Release builds ignore the flag.
bool get debugEntitlement => _debugEntitlementFlag && !kReleaseMode;

const _allPacks = {packBeginner, packIntermediate, packAdvanced};

class AccountController extends ChangeNotifier {
  AccountController(this._db, this._store);

  final LearnerDatabase _db;
  final CatalogStore _store;

  User? user;
  Set<String> packages = {};
  bool firebaseReady = false;
  String? lastError;
  String? packVersion;
  bool _googleInitialized = false;

  bool get hasCore =>
      !coursePacksEnabled ||
      packages.contains(packBeginner) ||
      packages.contains(packIntermediate) ||
      packages.contains(packAdvanced) ||
      packages.contains(packLegacy) ||
      debugEntitlement;

  bool ownsDepth(String depth) {
    if (!coursePacksEnabled ||
        debugEntitlement ||
        packages.contains(packLegacy)) {
      return true;
    }
    return packages.contains(packIdForDepth(depth));
  }

  String? get highestOwnedDepth {
    if (ownsDepth('advanced')) return 'advanced';
    if (ownsDepth('intermediate')) return 'intermediate';
    if (ownsDepth('beginner')) return 'beginner';
    return null;
  }

  Future<void> load() async {
    packages = await _db.activePackages();
    if (debugEntitlement) {
      packages = {...packages, ..._allPacks};
      for (final id in _allPacks) {
        await _db.setEntitlement(id, 'active');
      }
    }
    notifyListeners();
  }

  Future<void> attachFirebase() async {
    firebaseReady = true;
    FirebaseAuth.instance.authStateChanges().listen((u) async {
      user = u;
      if (u != null) {
        await _syncUser(u);
        await refreshPurchases();
      }
      notifyListeners();
    });
  }

  Future<void> signInGoogle() async {
    lastError = null;
    try {
      if (kIsWeb) {
        await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
        return;
      }
      await _initGoogleSignIn();
      final google = GoogleSignIn.instance;
      if (!google.supportsAuthenticate()) {
        lastError = 'Google sign-in is not available on this device.';
        notifyListeners();
        return;
      }
      final account = await google.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        lastError = 'Google did not return an ID token.';
        notifyListeners();
        return;
      }
      final cred = GoogleAuthProvider.credential(idToken: idToken);
      await FirebaseAuth.instance.signInWithCredential(cred);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return;
      lastError = e.description ?? '$e';
      notifyListeners();
    } catch (e) {
      lastError = '$e';
      notifyListeners();
    }
  }

  Future<void> _initGoogleSignIn() async {
    if (_googleInitialized) return;
    await GoogleSignIn.instance.initialize();
    _googleInitialized = true;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if (_googleInitialized) {
      try {
        await GoogleSignIn.instance.signOut();
      } catch (_) {}
    }
    user = null;
    notifyListeners();
  }

  Future<void> _syncUser(User u) async {
    await FirebaseFirestore.instance.collection('users').doc(u.uid).set({
      'email': u.email,
      'displayName': u.displayName,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> refreshPurchases() async {
    if (user == null) {
      if (debugEntitlement) {
        packages = {..._allPacks};
      }
      notifyListeners();
      return;
    }
    final snap = await FirebaseFirestore.instance
        .collection('purchases')
        .where('uid', isEqualTo: user!.uid)
        .get();
    packages = {};
    for (final doc in snap.docs) {
      final data = doc.data();
      if (data['status'] == 'active') {
        packages.add(data['packageId'] as String);
      }
    }
    if (debugEntitlement) packages.addAll(_allPacks);
    await _db.eraseEntitlementsExcept(packages);
    for (final id in packages) {
      await _db.setEntitlement(id, 'active');
    }
    if (!hasCore) {
      await _store.deleteCache();
    }
    notifyListeners();
  }

  Future<void> eraseDevice() async {
    await _db.erase();
    await _store.deleteCache();
    packages = debugEntitlement ? {..._allPacks} : {};
    notifyListeners();
  }
}

extension on LearnerDatabase {
  Future<void> eraseEntitlementsExcept(Set<String> keep) async {
    final current = await activePackages();
    for (final id in current.difference(keep)) {
      await setEntitlement(id, 'expired');
    }
  }
}
