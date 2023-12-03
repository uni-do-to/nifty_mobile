import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/sport_provider.dart';

import '../controllers/add_sport_controller.dart';

class AddSportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SportProvider>(
      () => SportProvider(),
    );

    Get.lazyPut<AddSportController>(
      () => AddSportController(Get.find()),
    );
  }
}
