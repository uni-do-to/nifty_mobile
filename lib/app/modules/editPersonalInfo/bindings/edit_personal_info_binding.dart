import 'package:get/get.dart';

import '../controllers/edit_personal_info_controller.dart';

class EditPersonalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPersonalInfoController>(
      () => EditPersonalInfoController(Get.find()),
    );
  }
}
