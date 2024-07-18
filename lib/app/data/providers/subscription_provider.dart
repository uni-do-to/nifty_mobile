import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/data/models/apple_verification_response.dart';
import 'package:nifty_mobile/app/data/models/checkout_session_response_model.dart';
import 'package:nifty_mobile/app/data/models/customer_portal_session_response_model.dart';
import 'package:nifty_mobile/app/data/models/subscription_plans_response_model.dart';

import '../../config/api_constants.dart';
import '../models/checkout_url_response_model.dart';

class SubscriptionProvider extends BaseProvider {

  @override
  void onInit() {
    super.onInit();
    // httpClient.baseUrl = ConfigAPI.baseUrl;
  }

  Future<CheckoutUrlResponse?> createSubCheckoutSession(int productId) async {
    final response = await get('${ConfigAPI.createSubCheckoutSessionUrl}/$productId');
    return decode<CheckoutUrlResponse?>(response, CheckoutUrlResponse.fromJson);
  }

  Future<CheckoutUrlResponse?> createBowlCheckoutSession() async {
    final response = await get('${ConfigAPI.createBowlCheckoutSession}');
    return decode<CheckoutUrlResponse?>(response, CheckoutUrlResponse.fromJson);
  }

  Future<AppleVerificationResponse?> verifyAppleReceipt(String verificationData) async {
    final response = await post('${ConfigAPI.verifyAppleReceipt}' , {
      'receipt': verificationData
    });
    return decode<AppleVerificationResponse?>(response, AppleVerificationResponse.fromJson);
  }

  Future<CheckoutSessionResponse?> retrieveCheckoutSession(String sessionId) async {
    final response = await get('${ConfigAPI.retrieveCheckoutSessionUrl}/$sessionId');
    return decode<CheckoutSessionResponse?>(response, CheckoutSessionResponse.fromJson);
  }

  Future<SubscriptionPlansResponse?> getSubscriptionPans() async {
    final response = await get(ConfigAPI.getSubscriptionsPlans);
    return decode<SubscriptionPlansResponse?>(response, SubscriptionPlansResponse.fromJson);
  }

  Future<SubscriptionPlansResponse?> getProductsPlans() async {
    final response = await get(ConfigAPI.getProductsPlans);
    return decode<SubscriptionPlansResponse?>(response, SubscriptionPlansResponse.fromJson);
  }

  Future<CustomerPortalSessionResponse?> createCustomerPortalSession() async {
    final response = await get('${ConfigAPI.createCustomerPortalSession}');
    return decode<CustomerPortalSessionResponse?>(response, CustomerPortalSessionResponse.fromJson);
  }

  Future<bool?> deleteMyData() async{
    final response = await get<bool?>('${ConfigAPI.deleteMyData}');

    return response.body;
  }
}
