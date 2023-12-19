import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/register/views/register_views_title.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/register_controller.dart';

class NiftyPointsView extends GetView<RegisterController> {
  const NiftyPointsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    return Form(
      key: controller.niftyPointsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RegisterViewsTitle(text: LocaleKeys.nifty_points_screen_title.tr),
          Expanded(child: Container()),
          Text(
            controller.nameController.text + LocaleKeys.daily_quantity_label.tr,
            style: theme?.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: theme?.accentColor,
            child: Column(
              children: [
                Text(
                  "${controller.targetCaloriesPerDay.value.round()} ${LocaleKeys.calories_measurement.tr}",
                  style: theme?.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${controller.niftyPoints.value.round()} ${LocaleKeys.nifty_points_measurement_unit.tr}",
                  style: theme?.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
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
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                LocaleKeys.terms_and_conditions_label.tr,
                style: theme?.textTheme.titleSmall?.copyWith(
                  height: 1.2,
                  fontWeight: FontWeight.normal,
                ),
                softWrap: true,
              ),
            ),

            // more widgets ...
          ]),
          const SizedBox(
            height: 15,
          ),
          ObxValue((state) {
            return Text(
              state.value,
              style: theme?.textTheme.titleSmall?.copyWith(
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
