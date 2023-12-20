import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../routes/app_pages.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 25,
        leading: Container(
          padding: EdgeInsets.only(
            top: 35,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme?.iconTheme.color,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(
            top: 47,
            bottom: 13,
          ),
          child: Text(LocaleKeys.change_password_screen_title.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge,
        toolbarHeight: 86,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.change_password_screen_sub_title.tr,
                style: theme?.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.change_password_screen_hint.tr,
                style: theme?.textTheme.titleMedium?.copyWith(height: 1.8),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                LocaleKeys.mandatory_fields_mark.tr,
                style: theme?.textTheme.titleSmall,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Form(
                  key: controller.changePasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ObxValue((state) {
                        return NeuFormField(
                          hintText: LocaleKeys.current_password_label.tr,
                          controller: controller.currentPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          autocorrect: false,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          errorText: controller.currentPasswordError.value,
                        );
                      }, controller.currentPasswordError),
                      ObxValue((state) {
                        return NeuFormField(
                          hintText: LocaleKeys.new_password_label.tr,
                          controller: controller.passwordController,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          obscureText: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          errorText: controller.passwordError.value,
                        );
                      }, controller.passwordError),
                      ObxValue((state) {
                        return NeuFormField(
                          hintText: LocaleKeys.confirm_password_label.tr,
                          controller: controller.confirmPasswordController,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          obscureText: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          errorText: controller.confirmPasswordError.value,
                        );
                      }, controller.confirmPasswordError),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Container()),
                  Container(
                    height: 54,
                    width: 230,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.accentColor,
                    ),
                    child: NeumorphicButton(
                        style: NeumorphicStyle(
                          color: ColorConstants.accentColor,
                        ),
                        child: Container(
                            alignment: Alignment.center,
                            color: ColorConstants.accentColor,
                            child: ObxValue((isPasswordChanged) {
                              return isPasswordChanged.value
                                  ? Container(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        backgroundColor: ColorConstants.white,
                                      ),
                                    )
                                  : Text(
                                      LocaleKeys.change_password_screen_title.tr,
                                      style: theme?.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: ColorConstants.white,
                                      ),
                                    );
                            }, controller.isPasswordChanged)),
                        onPressed: () async {
                          try {
                            await controller.changePassword();
                            Get.back();
                          } catch (err, _) {
                            printError(info: err.toString());
                            final strippedMessage = err.toString().replaceFirst(
                                LocaleKeys.exception_snackbar_label.tr, '');

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
                  ),
                  Expanded(child: Container()),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
