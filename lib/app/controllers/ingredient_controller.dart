import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/category_model.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/sub_category_model.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';

class IngredientController extends GetxController {

  final searchIngredientsController = TextEditingController();
  final userIngredientsController = TextEditingController();
  final categoriesController = TextEditingController();
  final subcategoriesController = TextEditingController();
  final ingredientsSubCategoriesController = TextEditingController();

  List<Ingredient> myIngredientsList = [];
  List<Ingredient> ingredientsList = [];
  List<Ingredient> ingredientsSubcategoryList = [];
  List<SubCategory> subCategoriesList = [];
  List<Category> categoriesList = [];

  RxBool loading = false.obs;
  RxInt selectedCategoryId = 0.obs;
  RxInt selectedSubCategoryId = 0.obs;
  Rx<Ingredient?> selectedIngredient = Rx(null);

  final IngredientProvider ingredientProvider;


  IngredientController(this.ingredientProvider);

  @override
  void onInit() {
    print("init ingredient controller data") ;
    super.onInit();
    initData();
  }

  Future initData() async {
    try {
      loading.value = true;

      var responseUserIngredientList = await ingredientProvider.getMyIngredientsList();
      myIngredientsList = responseUserIngredientList?.data ?? [];

      var responseIngredientList = await ingredientProvider.getIngredientList();
      ingredientsList = responseIngredientList?.data ?? [];

      var responseCategories = await ingredientProvider.getCategoriesList();
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
      await ingredientProvider.getSubCategoriesList(categoryId);
      subCategoriesList = responseSubCategories?.data ?? [];
    } catch (err, _) {
      print(err);
    } finally {}
  }

  Future getIngredientsSubcategory(int? subCategoryId) async {
    try {
      var responseIngredientsSubCategories = await ingredientProvider
          .getIngredientList(subCategoryId: subCategoryId);
      ingredientsSubcategoryList = responseIngredientsSubCategories?.data ?? [];

      selectedSubCategoryId.value = subCategoryId!;

    } catch (err, stacktrace) {
      print(err);
    } finally {}
  }

  Future<List<Ingredient>> searchIngredients(String searchKeyword) async {
    return ingredientsList.where((ingredient) {
      return ingredient.attributes?.nameEn?.toLowerCase()
          .contains(searchKeyword.toLowerCase()) == true ||
          ingredient.attributes?.nameFr?.toLowerCase()
              .contains(searchKeyword.toLowerCase()) == true;
    }).toList();
  }

  Future<List<Category>> searchCategory(String searchKeyword) async {
    return categoriesList.where((category) {
      return category.attributes?.nameEn?.toLowerCase()
          .contains(searchKeyword.toLowerCase()) == true ||
          category.attributes?.nameFr?.toLowerCase()
              .contains(searchKeyword.toLowerCase()) == true;
    }).toList();
  }

  Future<List<SubCategory>> searchSubCategory(String searchKeyword) async {
    return subCategoriesList.where((subCategory) {
      return subCategory.attributes?.nameEn?.toLowerCase()
          .contains(searchKeyword.toLowerCase()) == true ||
          subCategory.attributes?.nameFr?.toLowerCase()
              .contains(searchKeyword.toLowerCase()) == true;
    }).toList();
  }

  Future<List<Ingredient>> searchIngredientsSubCategory(
      String searchKeyword) async {
    return ingredientsSubcategoryList.where((ingredientSubCategory) {
      return ingredientSubCategory.attributes?.nameEn?.toLowerCase()
          .contains(searchKeyword.toLowerCase()) == true ||
          ingredientSubCategory.attributes?.nameFr?.toLowerCase()
              .contains(searchKeyword.toLowerCase()) == true;
    }).toList();
  }

  Future<List<Ingredient>> searchMyIngredients(String searchKeyword) async {
    return myIngredientsList.where((ingredient) {
      return ingredient.attributes?.nameEn?.toLowerCase()
          .contains(searchKeyword.toLowerCase()) == true ||
          ingredient.attributes?.nameFr?.toLowerCase()
              .contains(searchKeyword.toLowerCase()) == true;
    }).toList();
  }

  void clearIngredientForm(){
    selectedCategoryId.value = 0;
    selectedSubCategoryId.value = 0;
    selectedIngredient.value = null;
    searchIngredientsController.text = "";
    userIngredientsController.text = "";
    categoriesController.text = "";
    subcategoriesController.text = "";
    ingredientsSubCategoriesController.text = "";
  }

}
