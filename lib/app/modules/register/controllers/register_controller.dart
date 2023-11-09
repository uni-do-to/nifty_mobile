import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  RxInt currentStep = 0.obs;

  final GlobalKey<FormState> yourInfoFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  RxString selectedGender = ''.obs;

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
