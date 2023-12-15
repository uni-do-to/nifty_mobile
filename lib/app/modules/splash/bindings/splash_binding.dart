import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(Get.find()),
    );
  }
}
