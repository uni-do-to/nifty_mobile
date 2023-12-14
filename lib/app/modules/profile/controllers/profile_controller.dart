import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/user_permission_model.dart';
import 'package:nifty_mobile/app/services/auth_service.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final Rx<User?> user = Rx(null);

  @override
  void onInit() {
    super.onInit();
    user.value = Get.find<AuthService>().credentials?.user  ;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
