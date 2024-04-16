import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/history_provider.dart';

import '../controllers/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryProvider>(
          () => HistoryProvider(),
    );
    Get.lazyPut<HistoryController>(
      () => HistoryController(Get.find()),
    );
  }
}
