import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';

import '../../../data/models/user_permission_model.dart';

class SplashView extends GetView<AuthController> {

  SplashView({Key? key}) : super(key: key) {

    Future.wait([Future.delayed(const Duration(seconds: 4)) , controller.getMe()]).then((value) {
      User user = value[1] ;
      if(user.subscribed == true) {
        Get.offAllNamed(Routes.SUBSCRIPTION);
      }else {
        Get.offAllNamed(Routes.HOME);
      }
    }).catchError((e){
      Get.offAllNamed(Routes.LOGIN) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
