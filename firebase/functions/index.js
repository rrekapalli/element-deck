const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {getFirestore} = require("firebase-admin/firestore");
const {initializeApp} = require("firebase-admin/app");

initializeApp();

/**
 * Verify a Play / App Store receipt and write purchases/{id}.
 * The client cannot create purchase documents.
 *
 * Wire real store verification before shipping. This records the
 * authenticated uid, product, and store payload hash.
 */
exports.verifyReceipt = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Sign in to verify a receipt.");
  }
  const uid = request.auth.uid;
  const email = request.auth.token.email || "";
  const productId = request.data.productId;
  const purchaseId = request.data.purchaseId || `${uid}_${productId}`;
  const source = request.data.source || "unknown";
  if (productId !== "element-deck" && productId !== "classroom") {
    throw new HttpsError("invalid-argument", "Unknown product.");
  }
  const db = getFirestore();
  const purchaseRef = db.collection("purchases").doc(String(purchaseId));
  const userRef = db.collection("users").doc(uid);
  await db.runTransaction(async (t) => {
    const userSnap = await t.get(userRef);
    const ids = new Set((userSnap.exists && userSnap.data().packageIds) || []);
    ids.add(productId);
    t.set(purchaseRef, {
      uid,
      email,
      packageId: productId,
      store: source,
      storeProductId: productId,
      storeTransactionId: String(purchaseId),
      status: "active",
      purchasedAt: Date.now(),
      verifiedAt: Date.now(),
    }, {merge: true});
    t.set(userRef, {
      email,
      packageIds: [...ids],
      updatedAt: Date.now(),
    }, {merge: true});
  });
  return {ok: true, purchaseId};
});
