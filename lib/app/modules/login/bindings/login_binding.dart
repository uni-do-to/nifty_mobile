import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(Get.find()),
    );
  }
}
