import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/app/data/models/change_password_request_model.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class ChangePasswordController extends AuthController {
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();
  RxBool isPasswordChanged = false.obs;

  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;
  var currentPasswordError = ''.obs;

  final AuthProvider provider;

  ChangePasswordController(this.provider) : super(provider);

  @override
  void onInit() {
    super.onInit();
  }

  bool validateForm() {
    if (currentPasswordController.text.isEmpty) {
      currentPasswordError.value = LocaleKeys.current_password_error_message.tr;
    } else {
      currentPasswordError.value = '';
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

    if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value =
          LocaleKeys.password_not_match_error_message.tr;
    } else {
      confirmPasswordError.value = '';
    }
    return currentPasswordError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty;
  }

  Future<void> changePassword() async {
    if (validateForm() && !isPasswordChanged.value) {
      try {
        isPasswordChanged.value = true;
        ChangePasswordRequest data = ChangePasswordRequest(
          password: passwordController.text,
          passwordConfirmation: confirmPasswordController.text,
          currentPassword: currentPasswordController.text,
        );
        await authProvider.changePassword(data);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        passwordController.clear();
        confirmPasswordController.clear();
        currentPasswordController.clear();
        rethrow;
      } finally {
        isPasswordChanged.value = false;
      }
      changePasswordFormKey.currentState!.save();
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
