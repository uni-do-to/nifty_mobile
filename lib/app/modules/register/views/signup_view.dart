import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/register/views/register_views_title.dart';

import '../../../../generated/locales.g.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/form_field.dart';
import '../controllers/register_controller.dart';

class SignupView extends GetView<RegisterController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;
    return Form(
      key: controller.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RegisterViewsTitle(text: LocaleKeys.signup_screen_title.tr),
          Expanded(child: Container()),
          ObxValue((state) {
            return NeuFormField(
              hintText: LocaleKeys.email_label.tr,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              prefixIcon: const Icon(Icons.email),
              errorText: controller.emailError.value,
            );
          }, controller.emailError),
          SizedBox(
            height: 20.toHeight,
          ),
          ObxValue((state) {
            return NeuFormField(
              hintText: LocaleKeys.password_label.tr,
              obscureText: true,
              controller: controller.passwordController,
              prefixIcon: const Icon(Icons.lock),
              errorText: controller.passwordError.value,
            );
          }, controller.passwordError),
          SizedBox(
            height: 20.toHeight,
          ),
          ObxValue((state) {
            return NeuFormField(
              hintText: LocaleKeys.confirm_password_label.tr,
              obscureText: true,
              controller: controller.confirmPasswordController,
              prefixIcon: const Icon(Icons.lock),
              errorText: controller.confirmPasswordError.value,
            );
          }, controller.confirmPasswordError),
          SizedBox(
            height: 40.toHeight,
          ),
          NeumorphicButton(

              child: Container(
                  height: 48.toHeight,
                  alignment: Alignment.center,
                  child: ObxValue((isSignup) {
                    return isSignup.value
                        ? Container(
                            width: 32.toHeight,
                            height: 32.toHeight,
                            child: CircularProgressIndicator(
                              backgroundColor:
                                  NeumorphicTheme.currentTheme(context)
                                      .textTheme
                                      .labelLarge
                                      ?.color,
                            ),
                          )
                        : Text(LocaleKeys.signup_screen_title.tr,
                            style: NeumorphicTheme.currentTheme(context)
                                .textTheme
                                .bodyMedium);
                  }, controller.isSignup)),
              onPressed: () async {
                try {
                  await controller.signup();
                  Get.offAllNamed(Routes.HOME);
                } catch (err, _) {
                  printError(info: err.toString());
                  final strippedMessage = err
                      .toString()
                      .replaceFirst(LocaleKeys.exception_snackbar_label.tr, '');

                  Get.snackbar(
                    LocaleKeys.error_snackbar_label.tr,
                    strippedMessage,
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red.withOpacity(.75),
                    colorText: Colors.white,
                    icon: const Icon(Icons.error, color: Colors.white),
                    shouldIconPulse: true,
                    barBlur: 20,
                  );
                } finally {}
              }),

          Expanded(child: Container()),
        ],
      ),
    );
  }
}
