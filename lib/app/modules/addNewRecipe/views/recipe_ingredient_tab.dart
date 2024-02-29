import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/controllers/ingredient_controller.dart';
import 'package:nifty_mobile/app/modules/addNewRecipe/controllers/add_new_recipe_controller.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/widgets/add_ingredient_widget.dart';
import 'package:nifty_mobile/app/widgets/add_quantity_widget.dart';
import 'package:nifty_mobile/app/widgets/selected_ingredient_recipe_item.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../data/models/ingredient_model.dart';

class RecipeIngredientTab extends StatelessWidget {
  RecipeIngredientTab({Key? key}) : super(key: key);

  final AddNewRecipeController controller = Get.find();
  final IngredientController ingredientController = Get.find();

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 37.35,
                margin: const EdgeInsets.only(
                  left: 21,
                  top: 21,
                ),
                child: SmallActionButton(
                  text: LocaleKeys.add_new_ingredient_screen_sub_title.tr,
                  backgroundColor: ColorConstants.mainThemeColor,
                  textColor: Colors.white,
                  fontSize: 14,
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 17.75,
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
              padding: EdgeInsets.symmetric(horizontal: 21),
              child: ObxValue((state) {
                return state.value
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: theme?.textTheme.labelLarge?.color,
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
                            theme: theme!,
                            onIngredientSelected: (Ingredient ingredient) {
                              controller.onIngredientSelected(ingredient);
                            },
                          ),
                        ),
                      );
              }, controller.loading),
            ),
          ),
          // Obx(() {
          //   return Container(
          //     height: 200,
          //     child: AddQuantityWidget(
          //       theme: theme!,
          //       measurementUnitsItems:
          //           controller.measurementUnitsIngredientItems,
          //       selectedMeasurementUnit:
          //           controller.selectedIngredientMeasurementUnit.value,
          //       quantityController: controller.ingredientQuantityController,
          //       onMeasurementUnitChange: (unit) =>
          //           controller.selectedIngredientMeasurementUnit.value = unit,
          //       onQuantityChange: (value) => {},
          //     ),
          //   );
          // }),
          // const SizedBox(
          //   height: 9,
          // ),
          Obx(
            () {
              return Column(
                children: [
                  // Container(
                  //   height: 61,
                  //   child: SelectedIngredientRecipeItem(
                  //     theme: theme!,
                  //     selectedIngredientsRecipeLength:
                  //         controller.recipeIngredientsList.length,
                  //     selectedItemName: Get.locale?.languageCode == 'fr'
                  //         ? controller.selectedIngredient.value?.attributes
                  //                 ?.nameFr ??
                  //             LocaleKeys
                  //                 .selected_ingredient_recipe_hint_label.tr
                  //         : controller.selectedIngredient.value?.attributes
                  //                 ?.nameEn ??
                  //             LocaleKeys
                  //                 .selected_ingredient_recipe_hint_label.tr,
                  //     quantityName: controller
                  //             .selectedIngredientMeasurementUnit.value?.name ??
                  //         LocaleKeys.quantity_of_selected_item_hint.tr,
                  //     quantityValue: controller.ingredientQuantity.value,
                  //     isChecked: controller
                  //                 .selectedIngredient.value?.attributes !=
                  //             null &&
                  //         controller.selectedIngredientMeasurementUnit.value !=
                  //             null,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 9,
                  // ),
                  Row(
                    children: [
                      Container(
                        height: 54,
                        padding: const EdgeInsets.only(left: 27),
                        child: SmallActionButton(
                          width: 90,
                          text: LocaleKeys.close_label.tr,
                          backgroundColor: ColorConstants.accentColor,
                          textColor: Colors.white,
                          onPressed: () {
                            controller.clearRecipeIngredientForm();
                            Get.back();
                          },
                          // Optionally, specify width and height
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        height: 54,
                        padding: const EdgeInsets.only(right: 24),
                        child: SmallActionButton(
                          text: LocaleKeys.add_ingredient_to_recipe_title_page.tr,
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
                          onPressed: () {
                            if (controller.selectedIngredient.value != null) {
                              controller.addIngredientsToRecipe();
                              controller.clearRecipeIngredientForm();
                            }
                          },
                          // Optionally, specify width and height
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
