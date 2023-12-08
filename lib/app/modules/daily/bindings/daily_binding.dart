import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/daily_provider.dart';

import '../controllers/daily_controller.dart';

class DailyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyProvider>(
          () => DailyProvider(),
    );
    Get.lazyPut<DailyController>(
      () => DailyController(Get.find()),
    );
  }
}
