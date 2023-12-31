import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';

import '../../config/api_constants.dart';
import '../models/checkout_url_response_model.dart';

class SubscriptionProvider extends BaseProvider {

  @override
  void onInit() {
    super.onInit();
    // httpClient.baseUrl = ConfigAPI.baseUrl;
  }

  Future<CheckoutUrlResponse?> getCheckoutUrl(int productId) async {
    final response = await get('${ConfigAPI.checkoutSessionUrl}/$productId');
    return decode<CheckoutUrlResponse?>(response, CheckoutUrlResponse.fromJson);
  }


}
