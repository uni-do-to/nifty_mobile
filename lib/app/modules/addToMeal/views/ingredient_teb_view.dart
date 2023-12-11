import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/modules/addToMeal/controllers/add_to_meal_controller.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/add_ingredient_widget.dart';
import 'package:nifty_mobile/app/widgets/add_quantity_widget.dart';
import 'package:nifty_mobile/app/widgets/selected_ingredient_recipe_item.dart';

import 'package:nifty_mobile/app/widgets/small_action_button.dart';

class IngredientTabView extends StatelessWidget {
  final NeumorphicThemeData theme;
  final Meals selectedMeal;

  final AddToMealController controller = Get.find();

  final void Function()  onAddIngredientToMealPressed;

  IngredientTabView({Key? key, required this.theme, required this.selectedMeal , required this.onAddIngredientToMealPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 37.35,
            width: 230,
            margin: const EdgeInsets.only(
              left: 21,
              top: 21,
            ),
            child: SmallActionButton(
              text: 'Ajouter un nouvel Ingrédient',
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
                        child: AddIngredientFormWidget(
                          theme: theme,
                          onIngredientSelected: (ingredient) {
                            controller.onIngredientSelected(ingredient) ;
                          },
                        ),
                      );
              }, controller.loading),
            ),
          ),
          ObxValue((state) {
            return Container(
              height: 177,
              child: AddQuantityWidget(
                theme: theme,
                measurementUnitsItems: controller.measurementUnitsIngredientItems,
                selectedMeasurementUnit:
                    controller.selectedIngredientMeasurementUnit.value,
                quantityValue: controller.ingredientQuantity.value,
                onMeasurementUnitChange: (unit) =>
                    controller.selectedIngredientMeasurementUnit.value = unit,
                onQuantityChange: (value) => controller.ingredientQuantity.value = value,
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
                              "Choisissez un élément dans la liste"
                          : controller.selectedIngredient.value?.attributes
                                  ?.nameEn ??
                              "Choisissez un élément dans la liste",
                      quantityName:
                          controller.selectedIngredientMeasurementUnit.value?.name ??
                              "QTé",
                      quantityValue: controller.ingredientQuantity.value,
                      isChecked:
                          controller.selectedIngredient.value?.attributes !=
                                  null &&
                              controller.selectedIngredientMeasurementUnit.value != null,
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
                          text: 'Ajouter au repas',
                          backgroundColor: controller.selectedIngredient.value
                                          ?.attributes !=
                                      null &&
                                  controller.selectedIngredientMeasurementUnit.value !=
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
