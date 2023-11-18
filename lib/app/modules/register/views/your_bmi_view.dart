import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/register/views/register_views_title.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/card.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/gender_radio.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

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
          NeuFormField(
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
            validator: (value) {
              return null;
            },
          ),
          SizedBox(
            height: 24.toHeight,
          ),
          NeuFormField(
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
            validator: (value) {
              return null;
            },
          ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  NeuCard(
                    child: Container(
                      width: 200.toWidth,
                      height: 150.toHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.toHeight,
                          ),
                          Text(LocaleKeys.current_bmi_label.tr),
                        ],
                      ),
                    ),
                  ),
                  NeuCard(
                    child: Container(
                      width: 200.toWidth,
                      height: 150.toHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.toHeight,
                          ),
                          Text(LocaleKeys.target_bmi_label.tr),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.toHeight,
              ),
              RangeSlider(
                values: RangeValues(20,30),
                min: 0,
                max: 100,
                onChanged: (val) {},
              ),

            ],
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
