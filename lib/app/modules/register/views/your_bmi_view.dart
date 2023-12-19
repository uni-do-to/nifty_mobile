import 'dart:math';

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
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
        children: <Widget>[
          RegisterViewsTitle(text: LocaleKeys.your_bmi_screen_title.tr),
          Expanded(child: Container()),
          ObxValue((state) {
            return NeuFormField(
              hintText: LocaleKeys.your_tall_label.tr,
              controller: controller.tallController,
              keyboardType: TextInputType.number,
              autocorrect: false,
              suffixIcon: Container(
                width: 20.toWidth,
                alignment: Alignment.centerRight,
                child: Text(
                  LocaleKeys.tall_measurement.tr,
                  style: theme?.textTheme.bodySmall,
                ),
              ),
              errorText: controller.tallError.value,
            );
          }, controller.tallError),
          SizedBox(
            height: 24.toHeight,
          ),
          ObxValue((state) {
            return NeuFormField(
              hintText: LocaleKeys.your_weight_label.tr,
              controller: controller.weightController,
              keyboardType: TextInputType.number,
              autocorrect: false,
              suffixIcon: Container(
                width: 20.toWidth,
                alignment: Alignment.centerRight,
                child: Text(
                  LocaleKeys.weight_measurement.tr,
                  style: theme?.textTheme.bodySmall,
                ),
              ),
              errorText: controller.weightError.value,
            );
          }, controller.weightError),
          SizedBox(
            height: 24.toHeight,
          ),
          Divider(
            color: theme?.accentColor,
            height: 2,
            thickness: 2,
          ),
          SizedBox(
            height: 30.toHeight,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.your_goals_title.tr,
                style: theme?.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 15.toHeight,
              ),
              Text(
                LocaleKeys.target_bmi_instructions.tr,
                style: theme?.textTheme.bodySmall?.copyWith(
                  height: 1.8,
                ),
              ),
              SizedBox(
                height: 50.toHeight,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  NeuCard(
                    child: Container(
                      width: 230.toWidth,
                      height: 200.toHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.toHeight,
                          ),
                          Text(LocaleKeys.current_bmi_label.tr),
                          SizedBox(
                            height: 20.toHeight,
                          ),
                          ObxValue((state) {
                            return Visibility(
                              visible: state.value > 0,
                              child: Text(
                                (state.value.round()).toString(),
                                style: theme?.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }, controller.currentBMI),
                        ],
                      ),
                    ),
                  ),
                  NeuCard(
                    child: Container(
                      width: 230.toWidth,
                      height: 200.toHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.toHeight,
                          ),
                          Text(LocaleKeys.target_bmi_label.tr),
                          SizedBox(
                            height: 20.toHeight,
                          ),
                          ObxValue((state) {
                            return Visibility(
                              visible: state.value > 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${state.value.round()} ${LocaleKeys.bmi_measurement.tr}",
                                    style: theme?.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.lightGreen),
                                  ),
                                  SizedBox(
                                    height: 10.toHeight,
                                  ),
                                  Text(
                                    "${controller.targetWeight.round()} ${LocaleKeys.weight_measurement.tr}",
                                    style: theme?.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.lightGreen),
                                  ),
                                  SizedBox(
                                    height: 10.toHeight,
                                  ),
                                  Text(
                                    "${controller.targetCaloriesPerDay.round()} ${LocaleKeys.calories_per_gram_measurement.tr}",
                                    style: theme?.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.lightGreen),
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
              SizedBox(
                height: 20.toHeight,
              ),
              ObxValue((state) {
                return Visibility(
                  visible: !(controller.tallController.text.isEmpty &&
                      controller.weightController.text.isEmpty),
                  child: Column(
                    children: [
                      FlutterSlider(
                          values: [controller.targetBMI.value],
                          max: max(controller.maxBMIValue.value ,controller.targetBMI.value),
                          min: min(controller.minBMIValue.value , controller.targetBMI.value),
                          centeredOrigin: true,
                          trackBar: FlutterSliderTrackBar(),
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            if(lowerValue <= controller.minBMIValue.value)
                              return ;

                            controller.targetBMI.value = lowerValue;
                            controller.calculateUserGoalMeasurements();

                            // if (lowerValue > (max - min) / 2) {
                            //   // trackBarColor = Colors.blueAccent;
                            // } else {
                            //   // trackBarColor = Colors.redAccent;
                            // }
                            // setState(() {});
                          }),
                      SizedBox(
                        height: 10.toHeight,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            LocaleKeys.below_bmi_slider_label.tr,
                            style: theme?.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            LocaleKeys.above_bmi_slider_label.tr,
                            style: theme?.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                );
              }, controller.targetBMI),
              SizedBox(
                height: 10.toHeight,
              ),
              ObxValue((state) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    state.value,
                    style: theme?.textTheme.bodySmall?.copyWith(
                      color: Colors.red,
                    ),
                  ),
                );
              }, controller.targetBMIError),
              SizedBox(
                height: 20.toHeight,
              ),
            ],
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
