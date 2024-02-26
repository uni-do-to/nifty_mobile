import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/modules/register/views/register_views_title.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/gender_radio.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../controllers/edit_personal_info_controller.dart';

class EditPersonalInfoView extends GetView<EditPersonalInfoController> {
  EditPersonalInfoView({Key? key}) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000, 1, 1),
        firstDate: DateTime(1900),
        lastDate: DateTime(2021));
    if (picked != null) {
      controller.dateOfBirthController.text =
          DateFormat("dd-MM-yyyy").format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 30,
        leading: Container(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme?.iconTheme.color,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        title: Container(
          // padding: SizeConstants.toolBarPadding,
          child: Text(LocaleKeys.edit_personal_info_screen_title.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge
            ?.copyWith(color: ColorConstants.toolbarTextColor),
        toolbarHeight: 40,
      ),
      body: SafeArea(
        child: Form(
          key: controller.editInfoFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Neumorphic(
                  style: NeumorphicStyle(depth: 1.3, intensity: 1),
                  padding: const EdgeInsets.only(
                      top: 40, bottom: 15, left: 20, right: 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ObxValue((state) {
                          return NeuFormField(
                            hintText: LocaleKeys.your_name_label.tr,
                            controller: controller.nameController,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            prefixIcon: const Icon(
                              Icons.person,
                              size: 24,
                            ),
                            errorText: controller.nameError.value,
                          );
                        }, controller.nameError),
                        ObxValue((state) {
                          return NeuFormField(
                            hintText: LocaleKeys.birthdate_label.tr,
                            controller: controller.dateOfBirthController,
                            keyboardType: TextInputType.datetime,
                            autocorrect: false,
                            readOnly: true,
                            onTap: () {
                              // Call the _selectDate function when the text field is tapped.
                              _selectDate(context);
                            },
                            prefixIcon: const Icon(
                              Icons.date_range,
                              size: 24,
                            ),
                            errorText: controller.birthDateError.value,
                          );
                        }, controller.birthDateError),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Neumorphic(
                  style: NeumorphicStyle(depth: 1.3, intensity: 1),
                  padding: const EdgeInsets.only(
                      top: 40, bottom: 15, left: 20, right: 20),
                  child: Container(
                    child: ObxValue((state) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GenderRadio(
                                label: LocaleKeys.male_radio_label.tr,
                                icon: Icons.male,
                                value: "male",
                                groupValue: controller.selectedGender.value,
                                onChanged: (value) => controller
                                    .selectedGender.value = value.toString(),
                              ),
                              GenderRadio(
                                label: LocaleKeys.female_radio_label.tr,
                                icon: Icons.female,
                                value: "female",
                                groupValue: controller.selectedGender.value,
                                onChanged: (value) => controller
                                    .selectedGender.value = value.toString(),
                              ),
                            ],
                          ),
                          ObxValue((state) {
                            return Text(
                              state.value,
                              style: theme?.textTheme.titleSmall?.copyWith(
                                color: Colors.red,
                              ),
                            );
                          }, controller.genderError),
                        ],
                      );
                    }, controller.selectedGender),
                  ),
                ),
                Expanded(child: Container()),
                NeumorphicButton(
                    style:
                        NeumorphicStyle(color: ColorConstants.mainThemeColor),
                    child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: ObxValue((isInfoFormUpdated) {
                          return isInfoFormUpdated.value
                              ? Container(
                                  width: 25,
                                  height: 25,
                                  child: const CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                )
                              : Text(
                                  LocaleKeys.edit_health_profile_btn.tr,
                                  style: NeumorphicTheme.currentTheme(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: ColorConstants.white));
                        }, controller.isInfoFormUpdated)),
                    onPressed: () async {
                      // try {
                        await controller.editProfile();
                        Get.back();
                      // } catch (err, _) {
                      //   printError(info: err.toString());
                      //   final strippedMessage = err.toString().replaceFirst(
                      //       LocaleKeys.exception_snackbar_label.tr, '');
                      //
                      //   Get.snackbar(
                      //     LocaleKeys.error_snackbar_label.tr,
                      //     strippedMessage,
                      //     snackPosition: SnackPosition.TOP,
                      //     backgroundColor: Colors.red.withOpacity(.75),
                      //     colorText: Colors.white,
                      //     icon: const Icon(Icons.error, color: Colors.white),
                      //     shouldIconPulse: true,
                      //     barBlur: 20,
                      //   );
                      // } finally {}
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
