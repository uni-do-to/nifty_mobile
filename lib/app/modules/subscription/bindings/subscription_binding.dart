import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/app/data/providers/subscription_provider.dart';
import 'package:nifty_mobile/app/modules/subscription/controllers/buy_nifty_bowl_controller.dart';

import '../controllers/apple_subscription_controller.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionProvider>(
          () => SubscriptionProvider(),
    );
    Get.lazyPut<AuthProvider>(
          () => AuthProvider(),
    );

    Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(Get.find() , Get.find()),
    );

    Get.lazyPut<AppleSubscriptionController>(
      () => AppleSubscriptionController(Get.find() , Get.find()),
    );

    Get.lazyPut<BuyNiftyBowlController>(
          () => BuyNiftyBowlController(Get.find() , Get.find()),
    );
  }
}
