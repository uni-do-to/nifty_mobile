
import 'package:flutter/cupertino.dart';
import 'package:nifty_mobile/app/services/auth_service.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthService authService = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (authService.sessionIsEmpty()) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    return null ;
  }
}

class NotAuthMiddleware extends GetMiddleware {
  final AuthService authService = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (!authService.sessionIsEmpty()) {
      return const RouteSettings(name: Routes.HOME);
    }
    return null ;
  }
}