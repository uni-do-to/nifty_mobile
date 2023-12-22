import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/config/size_constants.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 25,
        leading: Container(
          padding: EdgeInsets.only(
            top: 35,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme?.iconTheme.color,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Container(
          padding: SizeConstants.toolBarPadding,
          child:
              Text(LocaleKeys.add_new_ingredient_screen_title.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge
            ?.copyWith(color: ColorConstants.toolbarTextColor),
        toolbarHeight: 40,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.add_new_ingredient_screen_sub_title.tr,
                style: theme?.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.add_new_ingredient_screen_hint.tr,
                style: theme?.textTheme.titleMedium?.copyWith(height: 1.8),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                LocaleKeys.mandatory_fields_mark.tr,
                style: theme?.textTheme.titleSmall,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Form(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          errorText: controller.ingredientNameFranceError.value,
                        );
                      }, controller.ingredientNameFranceError),

                      ObxValue((state) {
                        return NeuFormField(
                          hintText: LocaleKeys.ingredient_name_english_label.tr,
                          controller:
                              controller.ingredientNameEnglishController,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          errorText:
                              controller.ingredientNameEnglishError.value,
                        );
                      }, controller.ingredientNameEnglishError),

                      ObxValue((state) {
                        return NeuFormField(
                          hintText: LocaleKeys.grams_per_circle_label.tr,
                          controller: controller.gramsPerCircleController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.numberWithOptions(decimal: true , signed: true),                          autocorrect: false,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          errorText: controller.gramsPerCircleError.value,
                        );
                      }, controller.gramsPerCircleError),

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 230,
                            child: ObxValue((state) {
                              return NeuFormField(
                                hintText: LocaleKeys.calories_per_gram_label.tr,
                                controller:
                                    controller.caloriesPerGramController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.numberWithOptions(decimal: true , signed: true),                                autocorrect: false,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                errorText:
                                    controller.caloriesPerGramError.value,
                              );
                            }, controller.caloriesPerGramError),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ObxValue((state) {
                              return NeuFormField(
                                hintText:
                                    LocaleKeys.nifty_points_measurement.tr,
                                controller: controller.niftyPointsController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.numberWithOptions(decimal: true , signed: true),                                autocorrect: false,
                                readOnly: true,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                errorText: controller.niftyPointsError.value,
                              );
                            }, controller.niftyPointsError),
                          ),
                        ],
                      ),

                      Text(
                        LocaleKeys.extra_measurement_section_label.tr,
                        style: theme?.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 210,
                            child: ObxValue((state) {
                              return NeuFormField(
                                hintText:
                                    LocaleKeys.unit_name_measurement_label.tr,
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
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ObxValue((state) {
                              return NeuFormField(
                                hintText: LocaleKeys
                                    .equivalent_unit_in_grams_label.tr,
                                controller:
                                    controller.equivalentUnitInGramsController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.numberWithOptions(decimal: true , signed: true),                                autocorrect: false,
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

                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 210,
                            child: ObxValue((state) {
                              return NeuFormField(
                                hintText: LocaleKeys
                                    .unit_name_another_measurement_label.tr,
                                controller: controller
                                    .unitNameAnotherMeasurementController,
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
                            width: 10,
                          ),
                          Expanded(
                            child: ObxValue((state) {
                              return NeuFormField(
                                hintText: LocaleKeys
                                    .equivalent_unit_in_grams_label.tr,
                                controller:
                                    controller.equivalentUnitInGramsController2,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.numberWithOptions(decimal: true , signed: true),                                autocorrect: false,
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
                      const SizedBox(
                        height: 10,
                      ),

                      //button
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container()),
                  Container(
                    height: 54,
                    width: 191,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.accentColor,
                    ),
                    child: NeumorphicButton(
                        style: NeumorphicStyle(
                          color: ColorConstants.accentColor,
                        ),
                        child: Container(
                          color: ColorConstants.accentColor,
                          alignment: Alignment.center,
                          child: ObxValue((ingredientCreated) {
                            return ingredientCreated.value
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      backgroundColor: ColorConstants.white,
                                    ),
                                  )
                                : Text(
                                    LocaleKeys
                                        .create_ingredient_button_label.tr,
                                    style:
                                        theme?.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.white,
                                    ),
                                  );
                          }, controller.loading),
                        ),
                        onPressed: () async {
                          try {
                            await controller.createNewIngredient();
                            Get.back();
                          } catch (err, _) {
                            printError(info: err.toString());
                            final strippedMessage = err.toString().replaceFirst(
                                  LocaleKeys.exception_snackbar_label.tr,
                                  '',
                                );

                            Get.snackbar(
                              LocaleKeys.error_snackbar_label.tr,
                              strippedMessage,
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red.withOpacity(.75),
                              colorText: Colors.white,
                              icon:
                                  const Icon(Icons.error, color: Colors.white),
                              shouldIconPulse: true,
                              barBlur: 20,
                            );
                          } finally {}
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
