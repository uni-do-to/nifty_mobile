import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/user_permission_model.dart';
import 'package:nifty_mobile/app/modules/register/signup_request_model.dart';

import '../data/auth_provider.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {

  final AuthProvider authProvider ;
  late AuthService _authService ;

  AuthController(this.authProvider){
    _authService = Get.find() ;
  }

  Future<UserPermission?> signIn(String email, String password) async {
    try {
      UserPermission? user = await authProvider.loginLocal(email, password);

      if(user?.jwt != null) {
        print("saving credintials ${user?.toJson()}") ;
        await _authService.saveCredentials(user) ;
      }
      return user ;
    } catch (e) {
      // printLog(e);
      printError(info: e.toString());
      rethrow;
    }
  }

  Future<UserPermission?> signUp(SignupRequest userData) async {
    try {
      UserPermission? user = await authProvider.registerLocal(userData);

      if(user?.jwt != null) {
        await _authService.saveCredentials(user) ;
      }
      return user ;
    } catch (e) {
      // printLog(e);
      printError(info: e.toString());
      rethrow;
    }
  }


  @override
  void onInit() {
    super.onInit();
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
