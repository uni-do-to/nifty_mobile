import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/user_permission_model.dart';
import 'package:nifty_mobile/app/modules/register/signup_request_model.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

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

  Future<User?> getMe() async {
    try {
      User? user = await authProvider.getMe();

      if(user?.id != null) {
        await _authService.updateUserInfo(user!) ;
      }
      return user ;
    } catch (e) {
      // printLog(e);
      printError(info: e.toString());
      rethrow;
    }
  }

  Timer? _timer  ;
  RxInt countDown = 0.obs ;

  void showConfirmationMessage() {
    Get.snackbar(LocaleKeys.confirmation_send.tr,
        LocaleKeys.confirmation_message.tr,
        duration: 30.seconds,
        mainButton: TextButton(
            onPressed: () async {
              if (countDown > 0) {
                return;
              }
              var result = await authProvider.sendConfirmationEmail();
              if (result == true) {
                countDown.value = 30;
                _timer?.cancel();
                _timer = Timer(30.seconds, () {
                  countDown.value = countDown.value - 1;
                });
              }
            },
            child: ObxValue((state) {
              return Text(countDown > 0 ? "......" : LocaleKeys.resend.tr);
            }, countDown)));
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
