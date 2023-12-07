import 'package:collection/collection.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/recipe_model.dart';
import 'package:nifty_mobile/app/modules/addToMeal/controllers/add_to_meal_controller.dart';
import 'package:nifty_mobile/app/modules/daily/controllers/daily_controller.dart';
import 'package:nifty_mobile/app/modules/daily/views/custom_tab_view.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/add_ingredient_widget.dart';
import 'package:nifty_mobile/app/widgets/add_quantity_widget.dart';
import 'package:nifty_mobile/app/widgets/daily_list_item.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/selected_ingredient_recipe_item.dart';
import 'dart:collection';

import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class RecipeTabView extends StatelessWidget {
  final NeumorphicThemeData theme;
  final String selectedMeal;

  AddToMealController controller = Get.find();

  RecipeTabView({Key? key, required this.theme, required this.selectedMeal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 37.35,
            width: 250,
            margin: const EdgeInsets.only(
              left: 21,
              top: 21,
            ),
            child: SmallActionButton(
              text: 'Ajouter une nouvelle recite ',
              backgroundColor: ColorConstants.mainThemeColor,
              textColor: Colors.white,
              fontSize: 14,
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 17.75,
              ),
              onPressed: () {
                Get.toNamed(Routes.INGREDIENT);
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
                          right: 17,
                          left: 17,
                          top: 15.6,
                        ),
                        child: Column(
                          children: [
                            //search in user recipes
                            Text(
                              LocaleKeys.research_dropdown_label.tr,
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            TypeAheadField<Recipe>(
                              controller: controller.searchIngredientsController,
                              suggestionsCallback: (search) =>
                                  controller.searchRecipes(search),
                              builder: (context, controller, focusNode) {
                                return NeuFormField(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 18),
                                  hintText:
                                      LocaleKeys.search_recipes_dropdown_label.tr,
                                  controller: controller,
                                  focusNode: focusNode,
                                  suffixIcon: Icon(Icons.search),
                                  maintainErrorSize: false,
                                );
                              },
                              itemBuilder: (context, recipe) {
                                return ListTile(
                                  title: Text(
                                    recipe.attributes!.name!,
                                  ),
                                );
                              },
                              onSelected: (recipe) {
                                controller.selectedRecipe.value = recipe;
                                controller.searchRecipesController.text =
                                    recipe.attributes!.name!;
                                controller.initRecipeMeasurementUnits();
                              },
                            ),
                          ],
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
                measurementUnitsItems: controller.measurementUnitsRecipeItems,
                selectedMeasurementUnit:
                    controller.selectedRecipeMeasurementUnit.value,
                quantityValue: controller.recipeQuantity.value,
                onMeasurementUnitChange: (unit) =>
                    controller.selectedRecipeMeasurementUnit.value = unit,
                onQuantityChange: (value) =>
                    controller.ingredientQuantity.value = value,
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
                      selectedItemName:
                          controller.selectedRecipe.value?.attributes?.name ??
                              "Choisissez un élément dans la liste",
                      quantityName: controller
                              .selectedRecipeMeasurementUnit.value?.name ??
                          "QTé",
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
                          text: 'Ajouter au repas',
                          backgroundColor:
                              controller.selectedRecipe.value?.attributes !=
                                          null &&
                                      controller.selectedRecipeMeasurementUnit
                                              .value !=
                                          null
                                  ? ColorConstants.accentColor
                                  : ColorConstants.accentColor.withOpacity(0.4),
                          textColor: Colors.white,
                          onPressed: () {
                            if (controller.selectedRecipe.value != null &&
                                controller
                                        .selectedRecipeMeasurementUnit.value !=
                                    null &&
                                controller.recipeQuantity.value != "0") {
                              Get.back();
                            }
                            //TODO add your recipe to ingredient list inside selected meal object
                          },
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
