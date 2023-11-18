import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class RegisterController extends AuthController {
  RxInt currentStep = 0.obs;

  final GlobalKey<FormState> yourInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> yourBmiFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> niftyPointsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final tallController = TextEditingController();
  final weightController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxString selectedGender = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;
  RxBool isSignup = false.obs;

  RegisterController(super.authProvider);

  @override
  void onInit() {
    super.onInit();
  }

  bool validateForm() {
    if (emailController.text.isEmpty) {
      emailError.value = LocaleKeys.email_error_message.tr;
    } else {
      emailError.value = '';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = LocaleKeys.password_error_message.tr;
    } else {
      passwordError.value = '';
    }

    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = LocaleKeys.confirm_password_error_message.tr;
    } else {
      confirmPasswordError.value = '';
    }

    if (confirmPasswordController.text == passwordController.text) {
      confirmPasswordError.value =
          LocaleKeys.password_not_match_error_message.tr;
    } else {
      confirmPasswordError.value = '';
    }
    return emailError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty;
  }

  Future<void> signup() async {
    if (validateForm() && !isSignup.value) {
      try {
        isSignup.value = true;

        await signUp(emailController.text, passwordController.text);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        passwordController.clear();
        rethrow;
      } finally {
        isSignup.value = false;
      }
      signupFormKey.currentState!.save();
    } else {
      throw Exception(LocaleKeys.global_error_message.tr);
    }
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
