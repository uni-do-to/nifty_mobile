import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/config/theme_data.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/modules/addToMeal/controllers/add_to_meal_controller.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/add_ingredient_widget.dart';
import 'package:nifty_mobile/app/widgets/add_quantity_widget.dart';
import 'package:nifty_mobile/app/widgets/selected_ingredient_recipe_item.dart';

import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class IngredientTabView extends StatelessWidget {
  final NeumorphicThemeData theme;
  final Meals selectedMeal;

  final AddToMealController controller = Get.find();

  final void Function() onAddIngredientToMealPressed;

  IngredientTabView(
      {Key? key,
      required this.theme,
      required this.selectedMeal,
      required this.onAddIngredientToMealPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     ThemeConfig.mainTabsShadow,
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 46,
                clipBehavior: Clip.none,
                margin: const EdgeInsets.only(
                  left: 21,
                  top: 21,
                ),
                child: SmallActionButton(
                  text: LocaleKeys.add_new_ingredient_screen_sub_title.tr,
                  backgroundColor: ColorConstants.mainThemeColor,
                  textColor: Colors.white,
                  fontSize: 16,
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.ADD_NEW_INGREDIENT);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.toWidth),
              child: ObxValue((state) {
                return state.value
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: theme.textTheme.labelLarge?.color,
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(
                          right: 21,
                          left: 21,
                          top: 10.6,
                        ),
                        child: SingleChildScrollView(
                          child: AddIngredientFormWidget(
                            theme: theme,
                            onIngredientSelected: (ingredient) {
                              controller.onIngredientSelected(ingredient);
                            },
                          ),
                        ),
                      );
              }, controller.loading),
            ),
          ),
          ObxValue((state) {
            return Container(
              height: 200,
              child: AddQuantityWidget(
                theme: theme,
                measurementUnitsItems:
                    controller.measurementUnitsIngredientItems,
                selectedMeasurementUnit:
                    controller.selectedIngredientMeasurementUnit.value,
                quantityController: controller.ingredientQuantityController,
                onMeasurementUnitChange: (unit) =>
                    controller.selectedIngredientMeasurementUnit.value = unit,
                onQuantityChange: (value) => {},
              ),
            );
          }, controller.selectedIngredientMeasurementUnit),
          const SizedBox(
            height: 11,
          ),
          Obx(
            () {
              return Column(
                children: [
                  Container(
                    height: 61,
                    child: SelectedIngredientRecipeItem(
                      theme: theme,
                      selectedItemName: Get.locale?.languageCode == 'fr'
                          ? controller.selectedIngredient.value?.attributes
                                  ?.nameFr ??
                              LocaleKeys
                                  .selected_ingredient_recipe_hint_label.tr
                          : controller.selectedIngredient.value?.attributes
                                  ?.nameEn ??
                              LocaleKeys
                                  .selected_ingredient_recipe_hint_label.tr,
                      quantityName: controller
                              .selectedIngredientMeasurementUnit.value?.name ??
                          LocaleKeys.quantity_of_selected_item_hint.tr,
                      quantityValue: controller.ingredientQuantity.value,
                      isChecked: controller
                                  .selectedIngredient.value?.attributes !=
                              null &&
                          controller.selectedIngredientMeasurementUnit.value !=
                              null,
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        height: 54,
                        padding: const EdgeInsets.only(right: 24),
                        child: SmallActionButton(
                          width: 181,
                          text: LocaleKeys.add_to_meal_button_label.tr,
                          backgroundColor:
                              controller.selectedIngredient.value?.attributes !=
                                          null &&
                                      controller
                                              .selectedIngredientMeasurementUnit
                                              .value !=
                                          null
                                  ? ColorConstants.accentColor
                                  : ColorConstants.accentColor.withOpacity(0.4),
                          textColor: Colors.white,
                          onPressed: onAddIngredientToMealPressed,
                          // Optionally, specify width and height
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
