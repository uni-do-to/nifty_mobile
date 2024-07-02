import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nifty_mobile/app/config/app_constants.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/app/services/auth_service.dart';
import '../../../data/providers/subscription_provider.dart';
import '../../../routes/app_pages.dart';

class SingleSubscriptionController extends GetxController {
  final SubscriptionProvider provider;
  final AuthProvider authProvider;

  RxBool loading = false.obs;
  RxBool checkoutSuccess = false.obs;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];

  SingleSubscriptionController(this.provider, this.authProvider);

  @override
  void onInit() {
    print("on init") ;
    super.onInit();
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // Handle error here.
    });
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  Future<void> purchaseLifetimeMembership() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      Get.showSnackbar(GetSnackBar(message: "Store is unavailable", duration: Duration(seconds: 3)));
      return;
    }

    const Set<String> _kIds = {'lifetime_membership'};

    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kIds);

    if (response.notFoundIDs.isNotEmpty) {
      Get.showSnackbar(GetSnackBar(message: "Product not found", duration: Duration(seconds: 3)));
      return;
    }

    final ProductDetails productDetails = response.productDetails.first;

    late PurchaseParam purchaseParam;

    if (Platform.isAndroid) {
      purchaseParam = GooglePlayPurchaseParam(
        productDetails: productDetails,
        applicationUserName: authProvider.authService.credentials?.user?.email,
      );
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
        // ProductDetails(
        //     id: 'lifetime_membership',
        //     title: '', description: '',currencyCode: '',rawPrice: 0,currencySymbol: '', price: ''
        //
        // ),
        applicationUserName: authProvider.authService.credentials?.user?.email,
      );
    }

    var transactions = await SKPaymentQueueWrapper().transactions();
    transactions.forEach((skPaymentTransactionWrapper) {
      SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
    });

    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        loading.value = true;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            _deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
          }
        }
        if (Platform.isAndroid) {
          final InAppPurchaseAndroidPlatformAddition androidAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> _deliverProduct(PurchaseDetails purchaseDetails) async {
    final response = await _verifyPurchase(purchaseDetails);
    if (response) {
      checkoutSuccess.value = true;
      loading.value = false;
    } else {
      _handleInvalidPurchase(purchaseDetails);
    }
  }

  void _handleError(IAPError error) {
    loading.value = false;
    Get.showSnackbar(GetSnackBar(message: "Purchase Error: ${error.message}", duration: Duration(seconds: 3)));
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    loading.value = false;
    Get.showSnackbar(GetSnackBar(message: "Invalid Purchase", duration: Duration(seconds: 3)));
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    final response = await provider.verifyAppleReceipt(purchaseDetails.verificationData.serverVerificationData);
    return response?.status == 'success';
  }

  void logout() async {
    await authProvider.authService.removeCredentials();
    Get.offAllNamed(Routes.SPLASH);
  }
}
