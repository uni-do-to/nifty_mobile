import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/modules/register/views/register_views_title.dart';
import 'package:nifty_mobile/generated/locales.g.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/form_field.dart';
import '../../../widgets/gender_radio.dart';
import '../controllers/register_controller.dart';

class AboutYouView extends GetView<RegisterController> {
  final RxString selectedGender = "Male".obs;

  AboutYouView({Key? key}) : super(key: key);

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
    return Container(
      child: Form(
        key: controller.yourInfoFormKey,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Container(
              //   alignment: Alignment.center,
              //   child: Image.asset(
              //     'assets/images/logo.png',
              //     height: 182,
              //     width: 244,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegisterViewsTitle(text: LocaleKeys.about_you_screen_title.tr),
                ],
              ),
              const SizedBox(
                height: 24.8,
              ),
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
                      SizedBox(height: 16,),
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
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegisterViewsTitle(text: LocaleKeys.choose_gender_label.tr),
                ],
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GenderRadio(
                              label: LocaleKeys.male_radio_label.tr,
                              icon: Icons.male,
                              value: "male",
                              groupValue: controller.selectedGender.value,
                              onChanged: (value) => controller
                                  .selectedGender.value = value.toString(),
                            ),
                            SizedBox(
                              width: 8,
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
            ],
          ),
        ),
      ),
    );
  }
}
