import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/category_model.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/quantity_dropdown_item.dart';
import 'package:nifty_mobile/app/data/models/sub_category_model.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddToMealController extends GetxController {
  String selectedMeal = Get.arguments ?? "";

  final searchIngredientsController = TextEditingController();
  final userIngredientsController = TextEditingController();
  final categoriesController = TextEditingController();
  final subcategoriesController = TextEditingController();
  final ingredientsSubCategoriesController = TextEditingController();

  List<Ingredient> ingredientsList = [];
  List<Ingredient> ingredientsSubcategoryList = [];
  List<SubCategory> subCategoriesList = [];
  List<Category> categoriesList = [];
  RxBool loading = false.obs;
  RxInt selectedCategoryId = 0.obs;
  RxInt selectedSubCategoryId = 0.obs;
  Rx<Ingredient?> selectedIngredient = Rx(null);
  Rx<QuantityDropdownItem?> selectedMeasurementUnit = Rx(null);
  List<QuantityDropdownItem> measurementUnitsItems = [];

  final IngredientProvider provider;

  RxString quantity = "0".obs;

  AddToMealController(this.provider);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
    try {
      loading.value = true;

      var responseIngredientList = await provider.getIngredientList();
      ingredientsList = responseIngredientList?.data ?? [];

      var responseCategories = await provider.getCategoriesList();
      categoriesList = responseCategories?.data ?? [];
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }

  Future getSubcategory(categoryId) async {
    try {
      var responseSubCategories =
          await provider.getSubCategoriesList(categoryId);
      subCategoriesList = responseSubCategories?.data ?? [];
    } catch (err, _) {
      print(err);
    } finally {}
  }

  Future getIngredientsSubcategory(int? subCategoryId) async {
    try {
      var responseIngredientsSubCategories =
          await provider.getIngredientList(subCategoryId: subCategoryId);
      ingredientsSubcategoryList = responseIngredientsSubCategories?.data ?? [];
    } catch (err, stacktrace) {
      print(err);
    } finally {}
  }

  Future<List<Ingredient>> searchIngredients(String searchKeyword) async {
    return ingredientsList.where((ingredient) {
      return ingredient.attributes!.nameEn!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase()) ||
          ingredient.attributes!.nameFr!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase());
    }).toList();
  }

  Future<List<Category>> searchCategory(String searchKeyword) async {
    return categoriesList.where((category) {
      return category.attributes!.nameEn!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase()) ||
          category.attributes!.nameFr!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase());
    }).toList();
  }

  Future<List<SubCategory>> searchSubCategory(String searchKeyword) async {
    return subCategoriesList.where((subCategory) {
      bool matchesKeyword = subCategory.attributes!.nameEn!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase()) ||
          subCategory.attributes!.nameFr!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase());

      return matchesKeyword;
    }).toList();
  }

  Future<List<Ingredient>> searchIngredientsSubCategory(
      String searchKeyword) async {
    return ingredientsSubcategoryList.where((ingredientSubCategory) {
      bool matchesKeyword = ingredientSubCategory.attributes!.nameEn!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase()) ||
          ingredientSubCategory.attributes!.nameFr!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase());

      return matchesKeyword;
    }).toList();
  }

  initMeasurementUnits() {
    selectedMeasurementUnit.value = null;
    quantity.value = '0';
    List<QuantityDropdownItem> items = [
      QuantityDropdownItem(name: LocaleKeys.grams_unit_label.tr, grams: 1),
    ];

    // Add gramsPerCircle if conditions are met
    if (selectedIngredient.value?.attributes?.gramsPerCircle != null &&
        selectedIngredient.value!.attributes!.gramsPerCircle! > 0) {
      items.add(QuantityDropdownItem(
          name: LocaleKeys.circle_unit_label.tr,
          grams: selectedIngredient.value?.attributes!.gramsPerCircle!));
    }

    // Add units if conditions are met
    selectedIngredient.value?.attributes?.units?.forEach((unit) {
      if (unit.grams != null && unit.grams! > 0) {
        items.add(
            QuantityDropdownItem(name: unit.name ?? '', grams: unit.grams!));
      }
    });

    measurementUnitsItems = items;
    selectedMeasurementUnit.value = items[0];
  }
}
