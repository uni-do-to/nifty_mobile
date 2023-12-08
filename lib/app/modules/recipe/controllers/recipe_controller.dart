import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/recipe_model.dart';
import 'package:nifty_mobile/app/data/providers/recipe_provider.dart';

class RecipeController extends GetxController {
  final searchRecipesController = TextEditingController();
  List<Recipe> recipesList = []; // Your list of items
  RxList<Recipe> filteredItems = RxList();
  RxBool loading = false.obs;

  final RecipeProvider recipeProvider;

  RecipeController(this.recipeProvider);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future removeRecipe(Recipe recipeItem) async {
    try {
      loading.value = true;
      var response = await recipeProvider.deleteRecipe(recipeItem.id!);
      print(response);
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }
}
