import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/app/data/models/checkout_session_response_model.dart';
import 'package:nifty_mobile/app/data/models/subscription_plans_response_model.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:stripe_checkout/stripe_checkout.dart';

import '../../../data/models/user_permission_model.dart';
import 'platforms/stripe_checkout.dart'
    if (dart.library.js) 'platforms/stripe_checkout_web.dart';

import '../../../data/providers/subscription_provider.dart';

class SubscriptionController extends AuthController {
  final SubscriptionProvider provider;

  RxBool loading = false.obs;
  RxBool checkoutSuccess = false.obs;

  RxList<SubscriptionPlan> plans = RxList([]);

  Rx<CheckoutSessionResponse?> checkoutSession = Rx(null);

  SubscriptionController(this.provider, AuthProvider authProvider)
      : super(authProvider);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
    try {
      loading.value = true;
      var response = await provider.getSubscriptionPans();
      plans.value = response?.subscriptionPlans ?? [];
      // url.value = urlResponse?.id ?? "";
    } catch (err, _) {
      debugPrint(err.toString());
    } finally {
      loading.value = false;
    }
  }

  Future redirectToSubscription(int id) async {
    final session = await provider.createProductCheckoutSession(id);

    final result = await redirectToCheckout(
        context: Get.context!,
        sessionId: session!.id!,
        publishableKey: ConfigAPI.stripePublishableKey,
        successUrl: 'https://dashboard.theniftydiet.com/payment/success',
        canceledUrl:'https://dashboard.theniftydiet.com/payment/cancel',
        initialPageUrl:
            "https://tohami.github.io/stripe_checkout_template/index.html");

    String text = "";
    result?.when(
      success: () {
        checkoutSuccess.value = true;
        retrieveCheckoutSession(session.id!);
        text = "Checkout Success";
      },
      canceled: () {
        text = "Checkout canceled";
      },
      error: (e) => 'Error $e',
      redirected: () => 'Redirected succesfully',
    );

    Get.showSnackbar(
      GetSnackBar(message: text),
    );
  }

  Future retrieveCheckoutSession(String sessionId) async {
    try {
      await provider.retrieveCheckoutSession(sessionId);
      final user = await getMe();
      if (user?.subscribed == true) {
        Get.offNamed(Routes.HOME);
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
            message: "unable to retrieve Checkout Session please retry",
            mainButton: TextButton(
              child: const Text("RETRY"),
              onPressed: () => retrieveCheckoutSession(sessionId),
            )),
      );
    }
  }

  void logout() async{
    await authProvider.authService.removeCredentials();
    Get.offAllNamed(Routes.SPLASH) ;
  }
}
