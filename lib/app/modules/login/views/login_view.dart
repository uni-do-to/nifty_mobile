import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/form_field.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  void _showError(String error) async {
    await Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                    child: NeumorphicText(LocaleKeys.login.tr,
                        textStyle: NeumorphicTextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                        ),
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          depth: 2,
                          intensity: 0.8,
                          surfaceIntensity: 0.5,
                        ))),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: controller.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ObxValue((state) {
                          return NeuFormField(
                            hintText: LocaleKeys.email_label.tr,
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 24,
                            ),
                            errorText: controller.emailError.value,
                          );
                        }, controller.emailError),
                        const SizedBox(
                          height: 12,
                        ),
                        ObxValue((state) {
                          return NeuFormField(
                            hintText: LocaleKeys.password_label.tr,
                            obscureText: true,
                            controller: controller.passwordController,
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 24,
                            ),
                            errorText: controller.passwordError.value,
                          );
                        }, controller.passwordError),
                        const SizedBox(
                          height: 16,
                        ),
                        NeumorphicButton(
                            child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child: ObxValue((isLogin) {
                                  return isLogin.value
                                      ? Container(
                                          width: 25,
                                          height: 25,
                                          child: CircularProgressIndicator(
                                            backgroundColor:
                                                NeumorphicTheme.currentTheme(
                                                        context)
                                                    .textTheme
                                                    .labelLarge
                                                    ?.color,
                                          ),
                                        )
                                      : Text(LocaleKeys.login.tr,
                                          style: NeumorphicTheme.currentTheme(
                                                  context)
                                              .textTheme
                                              .titleLarge);
                                }, controller.isLogin)),
                            onPressed: () async {
                              try {
                                await controller.login();
                                Get.offAllNamed(Routes.HOME);
                              } catch (err, _) {
                                printError(info: err.toString());
                                final strippedMessage = err
                                    .toString()
                                    .replaceFirst(
                                        LocaleKeys.exception_snackbar_label.tr,
                                        '');

                                Get.snackbar(
                                  LocaleKeys.error_snackbar_label.tr,
                                  strippedMessage,
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.red.withOpacity(.75),
                                  colorText: Colors.white,
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  shouldIconPulse: true,
                                  barBlur: 20,
                                );
                              } finally {}
                            })
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(LocaleKeys.not_have_account_label.tr),
                      const SizedBox(
                        height: 8,
                      ),
                      NeumorphicButton(
                          child: Text(
                            LocaleKeys.sign_up_label.tr,
                            style: NeumorphicTheme.currentTheme(context)
                                .textTheme
                                .titleMedium,
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.REGISTER);
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
