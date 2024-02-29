import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/controllers/ingredient_controller.dart';
import 'package:nifty_mobile/app/data/models/api_response.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/recipe_request_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/data/providers/recipe_provider.dart';
import 'package:nifty_mobile/app/widgets/quantity_ingredient_dialog.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddNewRecipeController extends GetxController {
  final GlobalKey<FormState> addNewRecipeFormKey = GlobalKey<FormState>();
  final recipeNameController = TextEditingController();
  final recipeGramsPerCircleController = TextEditingController();

  RxList<RecipeItem> recipeIngredientsList = RxList();

  Rx<Units?> selectedIngredientMeasurementUnit = Rx(null);
  List<Units> measurementUnitsIngredientItems = [];
  List<Units> measurementUnitsRecipeItems = [];

  RxBool loading = false.obs;
  var recipeNameError = ''.obs;
  var recipeGramsPerCircleError = ''.obs;
  var recipeIngredientsListError = ''.obs;
  TextEditingController ingredientQuantityController = TextEditingController();
  RxString ingredientQuantity = "".obs;

  Rx<Ingredient?> selectedIngredient = Rx(null);
  RxBool isFormValid = false.obs;

  RecipeProvider recipeProvider;

  AddNewRecipeController(this.recipeProvider);

  @override
  void onInit() {
    super.onInit();
    recipeNameController.addListener(() {
      validateAddNewRecipeForm();
    });
    recipeGramsPerCircleController.addListener(() {
      validateAddNewRecipeForm();
    });
    recipeIngredientsList.stream.listen((snapShot) {
      validateAddNewRecipeForm();
    });
    ingredientQuantityController.addListener(() {
      ingredientQuantity.value = ingredientQuantityController.text ;
    });
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
    items.addAll(ingredient.attributes?.units ?? []);

    measurementUnitsIngredientItems = items;
    selectedIngredientMeasurementUnit.value = items[0];
  }

  // add ingredients to user recipe to make recipeIngredientList
  void addIngredientsToRecipe() {
    if (selectedIngredient.value == null) return;

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
        onAddClicked: () => addIngredientsToRecipeImpl(),
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

  void addIngredientsToRecipeImpl(){

    var grams = selectedIngredientMeasurementUnit.value!.grams! *
        double.parse(ingredientQuantityController.text.replaceAll(",", "."));

    var calories =
        (this.selectedIngredient.value!.attributes!.caloriesPer100grams! /
            100) *
            grams;

    var recipeItem = RecipeItem(
      ingredient: ApiSingleResponse<Ingredient>(data: selectedIngredient.value),
      grams: grams,
      calories: calories,
    );
    var index = recipeIngredientsList.indexWhere(
            (e) => e.ingredient?.data?.id == recipeItem.ingredient?.data?.id);

    if (index != -1) {
      // Ingredient exists, update quantity and calories
      recipeIngredientsList[index].grams =
          (recipeIngredientsList[index].grams ?? 0) + (recipeItem.grams ?? 0);
      recipeIngredientsList[index].calories =
          (recipeIngredientsList[index].calories ?? 0) +
              (recipeItem.calories ?? 0);
    } else {
      // Ingredient does not exist, add it to the list
      recipeIngredientsList.add(recipeItem);
    }
    Get.back();
  }

  bool validateAddNewRecipeForm() {
    //todo need to be fixed
    if (recipeNameController.text.isEmpty) {
      recipeNameError.value = LocaleKeys.recipe_name_error_message.tr;
    } else {
      recipeNameError.value = '';
    }

    // if (recipeGramsPerCircleController.text.isEmpty) {
    //   recipeGramsPerCircleError.value =
    //       LocaleKeys.recipe_grams_per_circle_error_message.tr;
    // } else {
    //   recipeGramsPerCircleError.value = '';
    // }

    if (recipeIngredientsList.isEmpty) {
      recipeIngredientsListError.value =
          LocaleKeys.recipe_ingredients_length_error_message.tr;
    } else {
      recipeIngredientsListError.value = '';
    }

    var isFormValid = recipeNameError.isEmpty &&
        recipeGramsPerCircleError.isEmpty &&
        recipeIngredientsListError.isEmpty;
    this.isFormValid.value = isFormValid;
    return isFormValid;
  }

  void clearRecipeIngredientForm() {
    //clear the form
    IngredientController ingredientController = Get.find();
    ingredientController.clearIngredientForm();
    ingredientQuantityController.text = '';
    selectedIngredientMeasurementUnit.value = null;
  }

  Future<void> createNewRecipe() async {
    if (validateAddNewRecipeForm() && !loading.value) {
      try {
        loading.value = true;

        //calculate total calories
        double? recipeTotalCalories = recipeIngredientsList
            .map((i) => i.calories)
            .reduce((previousValue, currentValue) =>
                previousValue! + currentValue!) as double?;

        //calculate total weight
        double? recipeTotalWeight = recipeIngredientsList
            .map((i) => i.grams)
            .reduce((previousValue, currentValue) =>
                previousValue! + currentValue!) as double?;

        var caloriesPer100grams = (recipeTotalCalories! / recipeTotalWeight!) * 100;
        //init recipe request
        RecipeRequest request = RecipeRequest(
          name: recipeNameController.text,
          gramsPerCircle: double.tryParse(recipeGramsPerCircleController.text.replaceAll(",", ".")),
          caloriesPer100grams:
              (recipeTotalCalories! / recipeTotalWeight!) * 100,
          niftyPoints: 1,
          ingredients: recipeIngredientsList,
          totalWeight: recipeTotalWeight,
          totalCalories: recipeTotalCalories,
        );

        await recipeProvider.createRecipe(request);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        rethrow;
      } finally {
        loading.value = false;
      }
      addNewRecipeFormKey.currentState!.save();
    } else {
      throw Exception(LocaleKeys.global_error_message.tr);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onIngredientSelected(Ingredient ingredient) {
    selectedIngredient.value = ingredient;
    initIngredientMeasurementUnits(ingredient);
  }
}
