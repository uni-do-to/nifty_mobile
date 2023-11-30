import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../utils/size_utils.dart';
import '../controllers/add_new_ingredient_controller.dart';

class AddNewIngredientView extends GetView<AddNewIngredientController> {
  const AddNewIngredientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: theme?.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        titleSpacing: 30,
        title: Text(
          LocaleKeys.add_new_ingredient_screen_title.tr,
        ),
        iconTheme: theme?.iconTheme,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.add_new_ingredient_screen_sub_title.tr,
              style: theme?.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.toHeight,
            ),
            Text(
              LocaleKeys.add_new_ingredient_screen_hint.tr,
              style: theme?.textTheme.bodySmall?.copyWith(height: 1.8),
            ),
            SizedBox(
              height: 40.toHeight,
            ),
            Text(
              LocaleKeys.mandatory_fields_mark.tr,
              style: theme?.textTheme.bodySmall,
            ),
            SizedBox(
              height: 40.toHeight,
            ),
            Form(
              key: controller.addIngredientFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ObxValue((state) {
                    return NeuFormField(
                      hintText: LocaleKeys.ingredient_name_france_label.tr,
                      controller: controller.ingredientNameFranceController,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      errorText: controller.ingredientNameFranceError.value,
                    );
                  }, controller.ingredientNameFranceError),
                  SizedBox(
                    height: 20.toHeight,
                  ),
                  ObxValue((state) {
                    return NeuFormField(
                      hintText: LocaleKeys.ingredient_name_english_label.tr,
                      controller: controller.ingredientNameEnglishController,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      errorText: controller.ingredientNameEnglishError.value,
                    );
                  }, controller.ingredientNameEnglishError),
                  SizedBox(
                    height: 20.toHeight,
                  ),
                  ObxValue((state) {
                    return NeuFormField(
                      hintText: LocaleKeys.grams_per_circle_label.tr,
                      controller: controller.gramsPerCircleController,
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      errorText: controller.gramsPerCircleError.value,
                    );
                  }, controller.gramsPerCircleError),
                  SizedBox(
                    height: 20.toHeight,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 300.toWidth,
                        child: ObxValue((state) {
                          return NeuFormField(
                            hintText: LocaleKeys.calories_per_gram_label.tr,
                            controller: controller.caloriesPerGramController,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            errorText: controller.caloriesPerGramError.value,
                          );
                        }, controller.caloriesPerGramError),
                      ),
                      SizedBox(
                        width: 20.toWidth,
                      ),
                      Expanded(
                        child: ObxValue((state) {
                          return NeuFormField(
                            hintText: LocaleKeys.nifty_points_measurement.tr,
                            controller: controller.niftyPointsController,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            readOnly: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            errorText: controller.niftyPointsError.value,
                          );
                        }, controller.niftyPointsError),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.toHeight,
                  ),
                  Text(
                    LocaleKeys.extra_measurement_section_label.tr,
                    style: theme?.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.toHeight,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 300.toWidth,
                        child: ObxValue((state) {
                          return NeuFormField(
                            hintText: LocaleKeys.unit_name_measurement_label.tr,
                            controller:
                                controller.unitNameMeasurementController,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            errorText:
                                controller.unitNameMeasurementError.value,
                          );
                        }, controller.unitNameMeasurementError),
                      ),
                      SizedBox(
                        width: 20.toWidth,
                      ),
                      Expanded(
                        child: ObxValue((state) {
                          return NeuFormField(
                            hintText:
                                LocaleKeys.equivalent_unit_in_grams_label.tr,
                            controller:
                                controller.equivalentUnitInGramsController,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            errorText:
                                controller.equivalentUnitInGramsError.value,
                          );
                        }, controller.equivalentUnitInGramsError),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.toHeight,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 300.toWidth,
                        child: ObxValue((state) {
                          return NeuFormField(
                            hintText: LocaleKeys
                                .unit_name_another_measurement_label.tr,
                            controller:
                                controller.unitNameAnotherMeasurementController,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            errorText: controller
                                .unitNameAnotherMeasurementError.value,
                          );
                        }, controller.unitNameAnotherMeasurementError),
                      ),
                      SizedBox(
                        width: 20.toWidth,
                      ),
                      Expanded(
                        child: ObxValue((state) {
                          return NeuFormField(
                            hintText:
                                LocaleKeys.equivalent_unit_in_grams_label.tr,
                            controller:
                                controller.equivalentUnitInGramsController2,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            errorText:
                                controller.equivalentUnitInGramsError.value,
                          );
                        }, controller.equivalentUnitInGramsError),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.toHeight,
                  ),

                  //button
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: Container()),
                      Container(
                        width: 280.toWidth,
                        child: NeumorphicButton(
                            child: Container(
                              height: 45.toHeight,
                              alignment: Alignment.center,
                              child: ObxValue((ingredientCreated) {
                                return ingredientCreated.value
                                    ? Container(
                                        width: 32.toHeight,
                                        height: 32.toHeight,
                                        child: CircularProgressIndicator(
                                          backgroundColor: theme
                                              ?.textTheme.labelLarge?.color,
                                        ),
                                      )
                                    : Text(
                                        LocaleKeys
                                            .create_ingredient_button_label.tr,
                                        style: theme?.textTheme.bodySmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      );
                              }, controller.loading),
                            ),
                            onPressed: () async {
                                    try {
                                      await controller.createNewIngredient();
                                      Get.offAllNamed(Routes.HOME);
                                    } catch (err, _) {
                                      printError(info: err.toString());
                                      final strippedMessage =
                                          err.toString().replaceFirst(
                                                LocaleKeys
                                                    .exception_snackbar_label
                                                    .tr,
                                                '',
                                              );

                                      Get.snackbar(
                                        LocaleKeys.error_snackbar_label.tr,
                                        strippedMessage,
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor:
                                            Colors.red.withOpacity(.75),
                                        colorText: Colors.white,
                                        icon: const Icon(Icons.error,
                                            color: Colors.white),
                                        shouldIconPulse: true,
                                        barBlur: 20,
                                      );
                                    } finally {}
                                  }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.toHeight,
                  ),
                  Text(
                    LocaleKeys.tutorial_link_label.tr,
                    style: theme?.textTheme.bodySmall?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
