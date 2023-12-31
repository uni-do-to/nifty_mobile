import 'package:date_format/date_format.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/modules/register/views/about_you_view.dart';
import 'package:nifty_mobile/app/modules/register/views/nifty_points_view.dart';
import 'package:nifty_mobile/app/modules/register/views/signup_view.dart';
import 'package:nifty_mobile/app/modules/register/views/your_bmi_view.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../widgets/form_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      controller.dateOfBirthController.text =
          formatDate(picked, [dd, '/', mm, '/', yyyy]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20 , right: 20),
                child: ObxValue((state) {
                  return NeumorphicProgress(
                    percent: state.value / 3,
                    curve: Curves.easeIn,
                    duration: Duration(seconds: 1),
                  );
                }, controller.currentStep),
              ),
              Expanded(
                child: ObxValue((state) {
                  if (state.value == 0) {
                    return AboutYouView();
                  } else if (state.value == 1) {
                    return YourBmiView();
                  } else if (state.value == 2) {
                    return NiftyPointsView();
                  } else if (state.value == 3) {
                    return SignupView();
                  } else {
                    return Container();
                  }
                }, controller.currentStep),
              ),
              Container(
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                        visible: controller.currentStep.value > 0,
                        child: SmallActionButton(
                          text: LocaleKeys.back_button_label.tr,
                          prefixIcon: Icon(
                            Icons.arrow_back_ios,
                            color: ColorConstants.accentColor,
                            size: 17,
                          ),
                          onPressed: () => controller.currentStep.value--,
                          // Optionally, specify width and height
                        ),
                      ),
                      Visibility(
                        visible: controller.currentStep.value < 3,
                        child: SmallActionButton(
                          text: LocaleKeys.continue_button_label.tr,
                          backgroundColor: Color(0xff274C5B),
                          textColor: Colors.white,
                          icon: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.white,
                            size: 17,
                          ),
                          onPressed: () {
                            if (controller.currentStep.value == 0 &&
                                !controller.validateUserInfoForm()) return;

                            if (controller.currentStep.value == 1 &&
                                !controller.validateBMIForm()) return;

                            if (controller.currentStep.value == 2 &&
                                !controller.validateNiftyPointsForm()) return;

                            if (controller.currentStep.value == 0) {
                              controller.userAge.value =
                                  controller.calculateUserAge();
                            }
                            if (controller.currentStep.value == 1) {
                              controller.calculateNiftyPoints();
                            }
                            controller.currentStep.value++;
                          },
                          // Optionally, specify width and height
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
