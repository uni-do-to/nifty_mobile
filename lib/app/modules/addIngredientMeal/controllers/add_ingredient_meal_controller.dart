import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/data/models/category_model.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/sub_category_model.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';
import 'package:nifty_mobile/app/widgets/loading_overlay.dart';

class AddIngredientMealController extends GetxController {

  final searchIngredientsController = TextEditingController();
  final userIngredientsController = TextEditingController();
  final categoriesController = TextEditingController();
  final subcategoriesController = TextEditingController();
  final ingredientsSubCategoriesController = TextEditingController();

  List<IngredientsData> ingredientsList = [];
  List<IngredientsData> ingredientsSubcategoryList = [];
  List<SubCategoryData> subCategoriesList = [];
  List<CategoryData> categoriesList = [];
  RxBool loading = false.obs;
  RxInt selectedCategoryId = 0.obs;
  RxInt selectedSubCategoryId = 0.obs;
  IngredientsData selectedIngredient= IngredientsData();

  final IngredientProvider provider;

  AddIngredientMealController(this.provider);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
    try {
      loading.value = true;

      var responseIngredientList = await provider.getIngredientList();
      this.ingredientsList = responseIngredientList.data ?? [];

      var responseCategories = await provider.getCategoriesList();
      this.categoriesList = responseCategories.data ?? [];
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
      this.subCategoriesList = responseSubCategories.data ?? [];
    } catch (err, _) {
      print(err);
    } finally {
    }
  }

  Future getIngredientsSubcategory(int? subCategoryId) async {
    try {
      var responseIngredientsSubCategories =
          await provider.getIngredientList(subCategoryId: subCategoryId);
      this.ingredientsSubcategoryList =
          responseIngredientsSubCategories.data ?? [];
    } catch (err, stacktrace) {
      print(err);
    } finally {
    }
  }

  Future<List<IngredientsData>> searchIngredients(String searchKeyword) async {
    return ingredientsList.where((ingredient) {
      return ingredient.attributes!.nameEn!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase()) ||
          ingredient.attributes!.nameFr!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase());
    }).toList();
  }

  Future<List<CategoryData>> searchCategory(String searchKeyword) async {
    return categoriesList.where((category) {
      return category.attributes!.nameEn!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase()) ||
          category.attributes!.nameFr!
              .toLowerCase()
              .contains(searchKeyword.toLowerCase());
    }).toList();
  }

  Future<List<SubCategoryData>> searchSubCategory(String searchKeyword) async {
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

  Future<List<IngredientsData>> searchIngredientsSubCategory(
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
}
