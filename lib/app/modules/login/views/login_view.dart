import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/login/controllers/login_controller.dart';

import '../../../utils/size_utils.dart';
import '../../../widgets/NeuFormFiled.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  LoginView({Key? key}) : super(key: key);

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
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          depth: 2,
                          intensity: 0.8,
                          surfaceIntensity: 0.5,
                        ))),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        NeuFormFiled(
                          hintText: 'Email address',
                          controller: _emailController,
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
                        SizedBox(
                          height: 12,
                        ),
                        NeuFormFiled(
                          hintText: 'Password',
                          obscureText: true,
                          controller: _passwordController,
                          prefixIcon: Icon(Icons.password),
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
                            onPressed: () {

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
