import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/category_model.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/recipe_model.dart';
import 'package:nifty_mobile/app/data/models/sub_category_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';
import 'package:nifty_mobile/app/data/providers/recipe_provider.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddToMealController extends GetxController {
  Meals selectedMeal = Get.arguments ?? "";

  final searchRecipesController = TextEditingController();

  List<Recipe> recipesList = [];

  RxBool loading = false.obs;
  RxBool isRecipeSelected = false.obs;
  Rx<Recipe?> selectedRecipe = Rx(null);
  Rx<Ingredient?> selectedIngredient = Rx(null);
  Rx<Units?> selectedIngredientMeasurementUnit = Rx(null);
  Rx<Units?> selectedRecipeMeasurementUnit = Rx(null);
  List<Units> measurementUnitsIngredientItems = [];
  List<Units> measurementUnitsRecipeItems = [];

  final RecipeProvider recipeProvider;

  RxString ingredientQuantity = "0".obs;
  RxString recipeQuantity = "0".obs;

  AddToMealController(this.recipeProvider);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
    try {
      loadRecipeList();
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }

  Future loadRecipeList() async {
    try {
      loading.value = true;

      var responseRecipeList = await recipeProvider.getRecipeList();
      recipesList = responseRecipeList?.data ?? [];
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

  initIngredientMeasurementUnits(Ingredient ingredient) {
    selectedIngredientMeasurementUnit.value = null;
    ingredientQuantity.value = '0';
    List<Units> items = [
      Units(name: LocaleKeys.grams_unit_label.tr, grams: 1),
    ];

    // Add gramsPerCircle if conditions are met
    if (ingredient.attributes?.gramsPerCircle != null &&
        ingredient.attributes!.gramsPerCircle! > 0) {
      items.add(Units(
          name: LocaleKeys.circle_unit_label.tr,
          grams: ingredient.attributes!.gramsPerCircle!));
    }

    // Add units if conditions are met
    // Add units if conditions are met
    items.addAll(ingredient.attributes?.units ?? []);


    measurementUnitsIngredientItems = items;
    selectedIngredientMeasurementUnit.value = items[0];
  }

  initRecipeMeasurementUnits() {
    selectedRecipeMeasurementUnit.value = null;
    recipeQuantity.value = '0';
    List<Units> items = [
      Units(name: LocaleKeys.grams_unit_label.tr, grams: 1),
    ];

    // Add gramsPerCircle if conditions are met
    if (selectedRecipe.value?.attributes?.gramsPerCircle != null &&
        selectedRecipe.value!.attributes!.gramsPerCircle! > 0) {
      items.add(Units(
          name: LocaleKeys.circle_unit_label.tr,
          grams: selectedRecipe.value?.attributes!.gramsPerCircle!));
    }

    measurementUnitsRecipeItems = items;
    selectedRecipeMeasurementUnit.value = items[0];
  }

  void onIngredientSelected(Ingredient ingredient) {
    selectedIngredient.value = ingredient;
    initIngredientMeasurementUnits(ingredient);
  }
}
