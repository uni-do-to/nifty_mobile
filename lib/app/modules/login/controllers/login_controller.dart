import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class LoginController extends AuthController {
  final AuthProvider provider;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  RxBool isLogin = false.obs;

  var emailError = ''.obs;
  var passwordError = ''.obs;

  LoginController(this.provider) : super(provider);

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

    return emailError.isEmpty && passwordError.isEmpty;
  }

  Future<void> login() async {
    if (validateForm() && !isLogin.value) {
      try {
        isLogin.value = true;

        await signIn(emailController.text, passwordController.text);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        passwordController.clear();
        rethrow;
      } finally {
        isLogin.value = false;
      }
      loginFormKey.currentState!.save();
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
