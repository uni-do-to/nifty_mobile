import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/modules/register/views/register_views_title.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/gender_radio.dart';
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
      body: SafeArea(
        child: Form(
          key: controller.editInfoFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RegisterViewsTitle(text: LocaleKeys.about_you_screen_title.tr),
              Expanded(child: Container()),
              ObxValue((state) {
                return NeuFormField(
                  hintText: LocaleKeys.your_name_label.tr,
                  controller: controller.nameController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  prefixIcon: const Icon(Icons.person),
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
                  prefixIcon: const Icon(Icons.date_range),
                  errorText: controller.birthDateError.value,
                );
              }, controller.birthDateError),
              const SizedBox(
                height: 15,
              ),
              ObxValue((state) {
                return Column(
                  children: [
                    RegisterViewsTitle(text: LocaleKeys.choose_gender_label.tr),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  ],
                );
              }, controller.selectedGender),
              const SizedBox(
                height: 15,
              ),
              ObxValue((state) {
                return Text(
                  state.value,
                  style: theme?.textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                  ),
                );
              }, controller.genderError),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
