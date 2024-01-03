import 'package:get/get.dart';

import '../models/subscription_plans_response_model.dart';

class SubscriptionPlansResponseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>)
        return SubscriptionPlansResponse.fromJson(map);
      if (map is List)
        return map
            .map((item) => SubscriptionPlansResponse.fromJson(item))
            .toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<SubscriptionPlansResponse?> getSubscriptionPlansResponse(
      int id) async {
    final response = await get('subscriptionplansresponse/$id');
    return response.body;
  }

  Future<Response<SubscriptionPlansResponse>> postSubscriptionPlansResponse(
          SubscriptionPlansResponse subscriptionplansresponse) async =>
      await post('subscriptionplansresponse', subscriptionplansresponse);
  Future<Response> deleteSubscriptionPlansResponse(int id) async =>
      await delete('subscriptionplansresponse/$id');
}
