import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../account/account_controller.dart';
import 'pack_ids.dart';

class PurchaseService {
  PurchaseService(this.account);

  final AccountController account;
  final InAppPurchase _iap = InAppPurchase.instance;
  bool storeAvailable = false;
  List<ProductDetails> products = [];
  String? message;

  Future<void> init() async {
    if (kIsWeb) {
      storeAvailable = false;
      message =
          'Buy on Android or iOS. Web can sign in and download a pack you already own.';
      return;
    }
    storeAvailable = await _iap.isAvailable();
    if (!storeAvailable) return;
    final response = await _iap.queryProductDetails(storeProductIds);
    products = response.productDetails;
    _iap.purchaseStream.listen(_onPurchase);
  }

  String priceLabel(String productId) {
    for (final p in products) {
      if (p.id == productId) return p.price;
    }
    return '₹199';
  }

  Future<void> buy(String productId) async {
    if (kIsWeb) {
      message =
          'Buy on Android or iOS. Then sign in here to download the pack.';
      return;
    }
    ProductDetails? product;
    for (final p in products) {
      if (p.id == productId) product = p;
    }
    if (product == null) {
      message = 'Product $productId is not in the store yet.';
      return;
    }
    await _iap.buyNonConsumable(
      purchaseParam: PurchaseParam(productDetails: product),
    );
  }

  Future<void> restore() async {
    await _iap.restorePurchases();
    await account.refreshPurchases();
  }

  Future<void> _onPurchase(List<PurchaseDetails> purchases) async {
    for (final p in purchases) {
      if (p.status == PurchaseStatus.purchased ||
          p.status == PurchaseStatus.restored) {
        await _verify(p);
        if (p.pendingCompletePurchase) {
          await _iap.completePurchase(p);
        }
      }
    }
    await account.refreshPurchases();
  }

  Future<void> _verify(PurchaseDetails p) async {
    final user = account.user;
    if (user == null) return;
    try {
      final callable = FirebaseFunctions.instance.httpsCallable('verifyReceipt');
      await callable.call({
        'source': p.verificationData.source,
        'serverData': p.verificationData.serverVerificationData,
        'productId': p.productID,
        'purchaseId': p.purchaseID,
      });
    } catch (e) {
      message = '$e';
    }
  }
}
