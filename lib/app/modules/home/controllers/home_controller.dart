import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';

class HomeController extends AuthController {
  List<String> mealsList = [];

  RxInt selectedMeal = 0.obs;

  HomeController(super.authProvider);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
