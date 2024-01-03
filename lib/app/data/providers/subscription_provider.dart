import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/data/models/checkout_session_response_model.dart';
import 'package:nifty_mobile/app/data/models/subscription_plans_response_model.dart';

import '../../config/api_constants.dart';
import '../models/checkout_url_response_model.dart';

class SubscriptionProvider extends BaseProvider {

  @override
  void onInit() {
    super.onInit();
    // httpClient.baseUrl = ConfigAPI.baseUrl;
  }

  Future<CheckoutUrlResponse?> createProductCheckoutSession(int productId) async {
    final response = await get('${ConfigAPI.createProductCheckoutSessionUrl}/$productId');
    return decode<CheckoutUrlResponse?>(response, CheckoutUrlResponse.fromJson);
  }

  Future<CheckoutSessionResponse?> retrieveCheckoutSession(String sessionId) async {
    final response = await get('${ConfigAPI.retrieveCheckoutSessionUrl}/$sessionId');
    return decode<CheckoutSessionResponse?>(response, CheckoutSessionResponse.fromJson);
  }

  Future<SubscriptionPlansResponse?> getSubscriptionPans() async {
    final response = await get(ConfigAPI.getSubscriptionsPlans);
    return decode<SubscriptionPlansResponse?>(response, SubscriptionPlansResponse.fromJson);
  }
}
