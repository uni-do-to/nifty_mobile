import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/modules/addToMeal/controllers/add_to_meal_controller.dart';
import 'package:nifty_mobile/app/widgets/add_quantity_widget.dart';
import 'package:nifty_mobile/app/widgets/delete_alert_dialog.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/recipe_ingredient_list_item.dart';
import 'package:nifty_mobile/app/widgets/selected_ingredient_recipe_item.dart';

import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class RecipeTabView extends StatelessWidget {
  final NeumorphicThemeData theme;
  final Meals selectedMeal;
  final void Function() onAddNewRecipe;
  final void Function() onAddRecipeToMeal;

  AddToMealController controller = Get.find();

  RecipeTabView(
      {Key? key,
      required this.theme,
      required this.selectedMeal,
      required this.onAddNewRecipe,
      required this.onAddRecipeToMeal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  text: LocaleKeys.add_new_recipe_button_label.tr,
                  backgroundColor: ColorConstants.mainThemeColor,
                  textColor: Colors.white,
                  fontSize: 14,
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 17.75,
                  ),
                  onPressed: onAddNewRecipe,
                ),
              ),
            ],
          ),
          ObxValue((state) {
            return state.value
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: theme.textTheme.labelLarge?.color,
                    ),
                  )
                : Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        right: 17,
                        left: 17,
                        top: 15.6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.research_dropdown_label.tr,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          NeuFormField(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            hintText:
                                LocaleKeys.search_recipes_dropdown_label.tr,
                            controller: controller.searchRecipesController,
                            suffixIcon: Icon(Icons.search),
                            maintainErrorSize: false,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            onChanged: (value) {
                              controller.filterSearchResults(value);
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: ObxValue((state) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: controller.filteredItems.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.selectedRecipe.value =
                                              controller.filteredItems[index];
                                          controller
                                              .initRecipeMeasurementUnits();
                                        },
                                        child: ObxValue((state) {
                                          return RecipeIngredientListItem(
                                            onDeletePressed: () =>
                                                showDeleteConfirmationDialog(
                                                    context, index),
                                            isSelected: controller
                                                    .selectedRecipe.value ==
                                                controller.filteredItems[index],
                                            icon: Icons.restaurant_menu_rounded,
                                            text: controller
                                                    .filteredItems[index]
                                                    .attributes
                                                    ?.name ??
                                                LocaleKeys
                                                    .no_search_result_label.tr,
                                          );
                                        }, controller.selectedRecipe),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, controller.filteredItems),
                          ),
                        ],
                      ),
                    ),
                  );
          }, controller.loading),
          ObxValue((state) {
            return Container(
              height: 200,
              child: AddQuantityWidget(
                theme: theme,
                measurementUnitsItems: controller.measurementUnitsRecipeItems,
                selectedMeasurementUnit:
                    controller.selectedRecipeMeasurementUnit.value,
                quantityValue: controller.recipeQuantity.value,
                onMeasurementUnitChange: (unit) =>
                    controller.selectedRecipeMeasurementUnit.value = unit,
                onQuantityChange: (value) =>
                    controller.recipeQuantity.value = value,
              ),
            );
          }, controller.selectedRecipeMeasurementUnit),
          const SizedBox(
            height: 11,
          ),
          Obx(
            () {
              return Column(
                children: [
                  Container(
                    child: SelectedIngredientRecipeItem(
                      theme: theme,
                      selectedItemName: controller
                              .selectedRecipe.value?.attributes?.name ??
                          LocaleKeys.selected_ingredient_recipe_hint_label.tr,
                      quantityName: controller
                              .selectedRecipeMeasurementUnit.value?.name ??
                          LocaleKeys.quantity_of_selected_item_hint.tr,
                      quantityValue: controller.recipeQuantity.value,
                      isChecked:
                          controller.selectedRecipe.value?.attributes != null &&
                              controller.selectedRecipeMeasurementUnit.value !=
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
                            backgroundColor: controller
                                            .selectedRecipe.value?.attributes !=
                                        null &&
                                    controller.selectedRecipeMeasurementUnit
                                            .value !=
                                        null
                                ? ColorConstants.accentColor
                                : ColorConstants.accentColor.withOpacity(0.4),
                            textColor: Colors.white,
                            onPressed: onAddRecipeToMeal
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

  void showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteAlertDialogWidget(
          itemName: controller.filteredItems[index].attributes!.name!,
          onCancelPressed: () => Get.back(),
          onDeletePressed: () {
            controller.filteredItems.removeAt(index);
            controller.removeRecipe(controller.filteredItems[index]);
            Get.back();
          },
        );
      },
    );
  }
}
