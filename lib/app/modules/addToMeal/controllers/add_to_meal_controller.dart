import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/api_response.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/recipe_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/data/providers/recipe_provider.dart';
import 'package:nifty_mobile/app/widgets/quantity_ingredient_dialog.dart';
import 'package:nifty_mobile/app/widgets/quantity_recipe_dialog.dart';
import 'package:nifty_mobile/app/widgets/selected_ingredient_recipe_item.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddToMealController extends GetxController {
  Meals selectedMeal = Get.arguments ?? "";

  final searchRecipesController = TextEditingController();

  List<Recipe> recipesList = [];
  RxList<Recipe> filteredItems = RxList();

  RxBool loading = false.obs;
  RxBool isRecipeSelected = false.obs;
  Rx<Recipe?> selectedRecipe = Rx(null);
  Rx<Ingredient?> selectedIngredient = Rx(null);
  Rx<Units?> selectedIngredientMeasurementUnit = Rx(null);
  Rx<Units?> selectedRecipeMeasurementUnit = Rx(null);
  List<Units> measurementUnitsIngredientItems = [];
  List<Units> measurementUnitsRecipeItems = [];

  final RecipeProvider recipeProvider;

  TextEditingController ingredientQuantityController = TextEditingController();
  TextEditingController recipeQuantityController = TextEditingController();

  RxString ingredientQuantity = "".obs;
  RxString recipeQuantity = "".obs;

  RxBool isValidAddRecipe = false.obs;
  RxBool isValidAddIngredient = false.obs;

  AddToMealController(this.recipeProvider);

  @override
  void onInit() {
    super.onInit();
    initData();
    recipeQuantityController.addListener(() {
      isValidRecipeForm();
      recipeQuantity.value = recipeQuantityController.text;
    });

    ingredientQuantityController.addListener(() {
      isValidRecipeForm();
      ingredientQuantity.value = ingredientQuantityController.text;
    });

    selectedRecipeMeasurementUnit.listen((p0) {
      isValidRecipeForm();
    });

    selectedRecipe.listen((p0) {
      isValidRecipeForm();
    });
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
      filteredItems.value = recipesList; // Initially, all items are visible
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
    ingredientQuantityController.text = '';
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
    recipeQuantityController.text = '';
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

  void filterSearchResults(String query) {
    List<Recipe> dummySearchList = [];
    dummySearchList.addAll(recipesList);

    if (query.isNotEmpty) {
      List<Recipe> dummyListData = [];
      dummySearchList.forEach((recipe) {
        if (recipe.attributes!.name!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dummyListData.add(recipe);
        }
      });
      filteredItems.value = dummyListData;
      return;
    } else {
      filteredItems.value = recipesList;
    }
  }

  Future removeRecipe(Recipe recipeItem) async {
    try {
      loading.value = true;
      var response = await recipeProvider.deleteRecipe(recipeItem.id!);
      recipesList.remove(recipeItem);
      print(response);
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }

  bool isValidRecipeForm() {
    var result = true;
    if (selectedRecipe.value == null) {
      // Handle the case when no recipe is selected
      print("No recipe selected");
      result = false;
    }

    if (selectedRecipeMeasurementUnit.value == null) {
      // Handle the case when no measurement unit is selected for the recipe
      print("No recipe measurement unit selected");
      result = false;
    }

    if (recipeQuantityController.text.isEmpty) {
      // Handle the case when recipe quantity is not entered
      print("Recipe quantity not entered");
      result = false;
    }

    double quantity;
    try {
      quantity =
          double.parse(recipeQuantityController.text.replaceAll(",", "."));
      // Add further processing if needed
    } catch (e) {
      // Handle the case when the entered quantity is not a valid number
      print("Invalid number for recipe quantity");
      result = false;
    }
    isValidAddRecipe.value = result;
    return result;
  }

  void onAddRecipeToMeal() {
    if (selectedRecipe.value == null) return;

    Get.bottomSheet(
      QuantityRecipeDialogWidget(
        selectedRecipe: selectedRecipe,
        recipeQuantity: recipeQuantity,
        measurementUnitsItems: measurementUnitsRecipeItems,
        selectedMeasurementUnit: selectedRecipeMeasurementUnit,
        quantityController: recipeQuantityController,
        onMeasurementUnitChange: (unit) =>
            selectedRecipeMeasurementUnit.value = unit,
        onCancelClicked: () {
          recipeQuantityController.text = '';
          initRecipeMeasurementUnits();
          Get.back();
        },
        onAddClicked: () => addRecipeToMealImpl(),
      ),
      clipBehavior: Clip.none,
      backgroundColor: ColorConstants.grayBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  void addRecipeToMealImpl() {
    if (!isValidRecipeForm()) return;

    var grams = selectedRecipeMeasurementUnit.value!.grams! *
        double.parse(recipeQuantityController.text.replaceAll(",", "."));

    var calories =
        (this.selectedRecipe.value!.attributes!.caloriesPer100grams! / 100) *
            grams;

    MealItem mealItem = MealItem(
      recipe: ApiSingleResponse<Recipe>(data: selectedRecipe.value),
      calories: calories,
      weight: grams,
    );
    //to close dialog
    Get.back();
    // back to add to meal view
    Get.back(result: mealItem);
  }

  bool isValidIngredientForm() {
    var result = true;
    if (selectedIngredient.value == null) {
      print("No ingredient selected");
      result = false;
    }

    if (selectedIngredientMeasurementUnit.value == null) {
      print("No ingredient measurement unit selected");
      result = false;
    }

    if (ingredientQuantityController.text.isEmpty) {
      print("Ingredient quantity not entered");
      result = false;
    }

    double quantity;
    try {
      quantity =
          double.parse(ingredientQuantityController.text.replaceAll(",", "."));
    } catch (e) {
      print("Invalid number for ingredient quantity");
      result = false;
    }
    // Here you can set a RxBool similar to isValidAddRecipe if needed
    isValidAddIngredient.value = result;
    return result;
  }

  void onAddIngredientToMeal() {
    Get.bottomSheet(
      QuantityIngredientDialogWidget(
        selectedIngredient: selectedIngredient,
        ingredientQuantity: ingredientQuantity,
        measurementUnitsItems: measurementUnitsIngredientItems,
        selectedMeasurementUnit: selectedIngredientMeasurementUnit,
        quantityController: ingredientQuantityController,
        onMeasurementUnitChange: (unit) =>
            selectedIngredientMeasurementUnit.value = unit,
        onCancelClicked: () {
          ingredientQuantityController.text = '';
          initIngredientMeasurementUnits(selectedIngredient.value!);
          Get.back();
        },
        onAddClicked: () => addIngredientToMealImpl(),
      ),
      clipBehavior: Clip.none,
      backgroundColor: ColorConstants.grayBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  addIngredientToMealImpl() {
    if (!isValidIngredientForm()) return;

    var grams = selectedIngredientMeasurementUnit.value!.grams! *
        double.parse(ingredientQuantityController.text.replaceAll(",", "."));

    // Assuming you have a way to calculate calories for the ingredient
    var calories =
        (selectedIngredient.value!.attributes!.caloriesPer100grams! / 100) *
            grams;

    // Assuming MealItem or a similar class is applicable for ingredients as well
    MealItem mealItem = MealItem(
      ingredient: ApiSingleResponse<Ingredient>(data: selectedIngredient.value),
      calories: calories,
      weight: grams,
    );
    //to close dialog
    Get.back();
    // back to add to meal view
    Get.back(result: mealItem);
  }
}
