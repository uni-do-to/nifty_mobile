import 'package:get/get.dart';

import '../controllers/edit_health_profile_controller.dart';

class EditHealthProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditHealthProfileController>(
      () => EditHealthProfileController(Get.find()),
    );
  }
}
