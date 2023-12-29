import 'dart:math';

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/register/views/register_views_title.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/card.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/gender_radio.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../config/color_constants.dart';
import '../controllers/register_controller.dart';

class YourBmiView extends GetView<RegisterController> {
  const YourBmiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;
    return Form(
      key: controller.yourBmiFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
              height: 182,
              width: 244,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 10.5,
          ),
          RegisterViewsTitle(text: LocaleKeys.your_bmi_screen_title.tr),
          const SizedBox(
            height: 10.8,
          ),
          Neumorphic(
            style: const NeumorphicStyle(depth: 1.3, intensity: 1),
            padding: const EdgeInsets.only(left: 18, right: 18, top: 25),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ObxValue((state) {
                    return NeuFormField(
                      hintText: LocaleKeys.your_tall_label.tr,
                      controller: controller.tallController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true , signed: true),                      autocorrect: false,
                      prefixIcon: const Icon(
                        Icons.height,
                        size: 24,
                      ),
                      suffixIcon: Container(
                        width: 10,
                        alignment: Alignment.centerRight,
                        child: Text(
                          LocaleKeys.tall_measurement.tr,
                          style: theme?.textTheme.titleSmall,
                        ),
                      ),
                      errorText: controller.tallError.value,
                    );
                  }, controller.tallError),
                  ObxValue((state) {
                    return NeuFormField(
                      hintText: LocaleKeys.your_weight_label.tr,
                      controller: controller.weightController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true , signed: true),              autocorrect: false,
                      prefixIcon: const Icon(
                        Icons.balance,
                        size: 24,
                      ),
                      suffixIcon: Container(
                        width: 10,
                        alignment: Alignment.centerRight,
                        child: Text(
                          LocaleKeys.weight_measurement.tr,
                          style: theme?.textTheme.bodySmall,
                        ),
                      ),
                      errorText: controller.weightError.value,
                    );
                  }, controller.weightError),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Neumorphic(
            style: const NeumorphicStyle(depth: 1.3, intensity: 1),
            padding: const EdgeInsets.only(left: 18, right: 18, top: 15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.your_goals_title.tr,
                    style: theme?.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    LocaleKeys.target_bmi_instructions.tr,
                    style: theme?.textTheme.titleSmall?.copyWith(
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      NeuCard(
                        backgroundColor: Colors.white,
                        child: Container(
                          width: 136,
                          height: 130,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.current_bmi_label.tr,
                                style: theme?.textTheme.titleLarge?.copyWith(
                                    color: ColorConstants.mainThemeColor,
                                    fontWeight: FontWeight.normal),
                              ),
                              Row(
                                children: [
                                  ObxValue((state) {
                                    return Visibility(
                                      visible: state.value > 0,
                                      child: Text(
                                        (state.value.round()).toString(),
                                        style: theme?.textTheme.titleLarge
                                            ?.copyWith(),
                                      ),
                                    );
                                  }, controller.currentBMI),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ObxValue((state) {
                                    return Visibility(
                                      visible: state.value > 0,
                                      child: Text(
                                        LocaleKeys.bmi_measurement.tr,
                                        style: theme?.textTheme.titleSmall,
                                      ),
                                    );
                                  }, controller.currentBMI),
                                ],
                              ),
                              Row(
                                children: [
                                  ObxValue((state) {
                                    return Visibility(
                                      visible: state.value > 0,
                                      child: Text(
                                        controller.weightController.text,
                                        style: theme?.textTheme.titleLarge
                                            ?.copyWith(),
                                      ),
                                    );
                                  }, controller.currentBMI),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ObxValue((state) {
                                    return Visibility(
                                      visible: state.value > 0,
                                      child: Text(
                                        LocaleKeys.weight_measurement.tr,
                                        style: theme?.textTheme.titleSmall,
                                      ),
                                    );
                                  }, controller.currentBMI),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      NeuCard(
                        backgroundColor:
                            ColorConstants.mainThemeColor.withOpacity(0.4),
                        child: Container(
                          width: 136,
                          height: 130,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                LocaleKeys.target_bmi_label.tr,
                                style: theme?.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              ObxValue((state) {
                                return Visibility(
                                  visible: state.value > 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${state.value.round()}",
                                            style: theme?.textTheme.titleLarge,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            LocaleKeys.bmi_measurement.tr,
                                            style: theme?.textTheme.titleSmall,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${controller.targetWeight.round()}",
                                            style: theme?.textTheme.titleLarge,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            LocaleKeys.weight_measurement.tr,
                                            style: theme?.textTheme.titleSmall,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${controller.targetCaloriesPerDay.round()}",
                                            style: theme?.textTheme.titleLarge,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            LocaleKeys
                                                .calories_per_gram_measurement
                                                .tr,
                                            style: theme?.textTheme.titleSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }, controller.targetBMI),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ObxValue((state) {
                    return Visibility(
                      visible: !(controller.tallController.text.isEmpty &&
                          controller.weightController.text.isEmpty),
                      child: Column(
                        children: [
                          FlutterSlider(
                              values: [controller.targetBMI.value],
                              max: max(controller.maxBMIValue.value,
                                  controller.targetBMI.value),
                              min: min(controller.minBMIValue.value,
                                  controller.targetBMI.value),
                              centeredOrigin: true,
                              trackBar: const FlutterSliderTrackBar(),
                              onDragging:
                                  (handlerIndex, lowerValue, upperValue) {
                                if (lowerValue <= controller.minBMIValue.value)
                                  return;

                                controller.targetBMI.value = lowerValue;
                                controller.calculateUserGoalMeasurements();

                                // if (lowerValue > (max - min) / 2) {
                                //   // trackBarColor = Colors.blueAccent;
                                // } else {
                                //   // trackBarColor = Colors.redAccent;
                                // }
                                // setState(() {});
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.below_bmi_slider_label.tr,
                                style: theme?.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                LocaleKeys.above_bmi_slider_label.tr,
                                style: theme?.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }, controller.targetBMI),
                  const SizedBox(
                    height: 5,
                  ),
                  ObxValue((state) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        state.value,
                        style: theme?.textTheme.titleSmall?.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    );
                  }, controller.targetBMIError),
                ],
              ),
            ),
          ),

          Expanded(child: Container()),
        ],
      ),
    );
  }
}
