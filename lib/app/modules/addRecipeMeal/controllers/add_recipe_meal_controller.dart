import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/quantity_dropdown_item.dart';
import 'package:nifty_mobile/app/data/models/recipe_model.dart';
import 'package:nifty_mobile/app/data/providers/recipe_provider.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddRecipeMealController extends GetxController {
  final searchRecipesController = TextEditingController();
  final measurementUnitGramsController = TextEditingController();

  List<Recipe> recipesList = [];

  RxBool isRecipeSelected = false.obs;
  RxBool loading = false.obs;
  Recipe selectedRecipe = Recipe();
  Rx<QuantityDropdownItem?> selectedMeasurementUnit = Rx(null);
  List<QuantityDropdownItem> measurementUnitsItems = [];

  final RecipeProvider provider;

  AddRecipeMealController(this.provider);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
    try {
      loading.value = true;

      var responseRecipeList = await provider.getRecipeList();
      this.recipesList = responseRecipeList?.data ?? [];
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }

  Future<List<Recipe>> searchRecipes(String searchKeyword) async {
    return recipesList.where((recipe) {
      return recipe.attributes!.name!
          .toLowerCase()
          .contains(searchKeyword.toLowerCase());
    }).toList();
  }

  initMeasurementUnits() {
    List<QuantityDropdownItem> items = [
      QuantityDropdownItem(name: LocaleKeys.grams_unit_label.tr, grams: 1),
    ];

    // Add gramsPerCircle if conditions are met
    if (selectedRecipe.attributes?.gramsPerCircle != null &&
        selectedRecipe.attributes!.gramsPerCircle! > 0) {
      items.add(QuantityDropdownItem(
          name: LocaleKeys.circle_unit_label.tr,
          grams: selectedRecipe.attributes!.gramsPerCircle!));
    }
    measurementUnitsItems = items;
    selectedMeasurementUnit.value = items[0];
  }
}
