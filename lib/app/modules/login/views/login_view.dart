import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/login/controllers/login_controller.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/NeuFormFiled.dart';

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
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                    child: NeumorphicText('LOGIN',
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
                        NeuFormFiled(
                          hintText: 'Email address',
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          prefixIcon: const Icon(Icons.email),
                          validator: (value) {
                            // if (value?.isEmpty == true) {
                            //   return 'Email is required.';
                            // }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        NeuFormFiled(
                          hintText: 'Password',
                          obscureText: true,
                          controller: controller.passwordController,
                          prefixIcon: const Icon(Icons.password),
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Password is required.';
                            // }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        NeumorphicButton(
                          // style: NeumorphicTheme.of(context)
                          //     ?.current
                          //     ?.buttonStyle,
                            child: Container(
                              height: 48.toHeight,
                              alignment: Alignment.center,
                              child: false
                                  ? Container(
                                width: 32.toHeight,
                                height: 32.toHeight,
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                  NeumorphicTheme.currentTheme(
                                      context)
                                      .textTheme
                                      .bodyText1
                                      ?.color,
                                ),
                              )
                                  : Text('Login',
                                  style:
                                  NeumorphicTheme.currentTheme(context)
                                      .textTheme
                                      .bodyText1),
                            ),
                            onPressed: () async{
                              if (controller.loginFormKey.currentState!
                                  .validate()) {
                                try {
                                  await controller.login();
                                  Get.offAllNamed(Routes.HOME);
                                } catch (err, _) {
                                  printError(info: err.toString());
                                  final strippedMessage = err.toString().replaceFirst('Exception: ', '');

                                  Get.snackbar(
                                    "Error",
                                    strippedMessage,
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor:
                                    Colors.red.withOpacity(.75),
                                    colorText: Colors.white,
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    shouldIconPulse: true,
                                    barBlur: 20,
                                  );
                                } finally {}

                                controller.loginFormKey.currentState!.save();
                              }
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
                      Text('Don`t have an account?'),
                      SizedBox(
                        height: 8,
                      ),
                      NeumorphicButton(
                          child: Text(
                            'Sing up',
                            style: NeumorphicTheme.currentTheme(context)
                                .textTheme
                                .bodyText1,
                          ),
                          onPressed: () {

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
