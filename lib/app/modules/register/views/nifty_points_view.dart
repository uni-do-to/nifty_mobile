import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/register/views/register_views_title.dart';

import '../../../../generated/locales.g.dart';
import '../../../utils/size_utils.dart';
import '../controllers/register_controller.dart';

class NiftyPointsView extends GetView<RegisterController> {
  const NiftyPointsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;
    return Form(
      key: controller.niftyPointsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RegisterViewsTitle(text: LocaleKeys.nifty_points_screen_title.tr),
          Expanded(child: Container()),
          Text(
            LocaleKeys.daily_quantity_label.tr,
            style: theme?.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 30.toFont,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10.toHeight,
          ),
          Text(
            controller.nameController.text +
                LocaleKeys.username_daily_calories_label.tr,
            style: theme?.textTheme.bodySmall,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 60.toHeight,
          ),
          Container(
            padding: EdgeInsets.all(70.toHeight),
            color: theme?.accentColor,
            child: Text(
              "${controller.niftyPoints.value.round()} ${LocaleKeys.nifty_points_measurement_unit.tr}",
              style: theme?.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40.toHeight,
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ObxValue((state) {
              return Checkbox(
                value: state.value,
                activeColor: theme?.accentColor,
                onChanged: (val) {
                  state.value = val!;
                },
              );
            }, controller.termsAndConditions),
            Expanded(
              child: Text(
                LocaleKeys.terms_and_conditions_label.tr,
                style: theme?.textTheme.bodySmall?.copyWith(height: 1.8),
                softWrap: true,
              ),
            ),

            // more widgets ...
          ]),
          SizedBox(
            height: 20.toHeight,
          ),
          ObxValue((state) {
            return Text(
              state.value,
              style: theme?.textTheme.bodySmall?.copyWith(
                color: Colors.red,
              ),
            );
          }, controller.termsAndConditionsError),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
