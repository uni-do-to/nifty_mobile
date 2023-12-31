import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/subscription_provider.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionProvider>(
          () => SubscriptionProvider(),
    );
    Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(Get.find()),
    );
  }
}
