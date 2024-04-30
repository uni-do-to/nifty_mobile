import 'package:get/get.dart';

import '../../../data/providers/subscription_provider.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionProvider>(
          () => SubscriptionProvider(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find()),
    );
  }
}
