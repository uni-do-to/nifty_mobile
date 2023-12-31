import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:stripe_checkout/stripe_checkout.dart';

import '../../../data/providers/subscription_provider.dart';

class SubscriptionController extends GetxController {

  final SubscriptionProvider provider ;
  RxBool loading = false.obs;
  RxString sessionId = "".obs;



  SubscriptionController(this.provider);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
    try {
      loading.value = true;
      // var urlResponse = await provider.getCheckoutUrl(2);
      // url.value = urlResponse?.id ?? "";
    } catch (err, _) {
      debugPrint(err.toString());
    } finally {
      loading.value = false;
    }
  }

  Future redirectToSubscription() async {
    final session = await provider.getCheckoutUrl(2);

    final result = await redirectToCheckout(
      context: Get.context!,
      sessionId: session!.id!,
      publishableKey: ConfigAPI.stripePublishableKey,
      successUrl: 'https://checkout.stripe.dev/success',
      canceledUrl: 'https://checkout.stripe.dev/cancel',
    );

    final text = result.when(
      success: () => 'Paid succesfully',
      canceled: () => 'Checkout canceled',
      error: (e) => 'Error $e',
      redirected: () => 'Redirected succesfully',
    );
    Get.showSnackbar(
      GetSnackBar(message: text),
    );
  }

}
