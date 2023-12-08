import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';

class IngredientController extends GetxController {
  final searchIngredientsController = TextEditingController();
  List<Ingredient> ingredientsList = []; // Your list of items
  RxList<Ingredient> filteredItems = RxList();
  RxBool loading = false.obs;

  IngredientProvider provider;

  IngredientController(this.provider);

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
      filteredItems.value = ingredientsList; // Initially, all items are visible
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }

  void filterSearchResults(String query) {
    List<Ingredient> dummySearchList = [];
    dummySearchList.addAll(ingredientsList);

    if (query.isNotEmpty) {
      filteredItems.value = dummySearchList.where((ingredient) {
        bool matchesKeyword = ingredient.attributes!.nameEn!
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            ingredient.attributes!.nameFr!
                .toLowerCase()
                .contains(query.toLowerCase());

        return matchesKeyword;
      }).toList();
      return;
    } else {
      filteredItems.value = ingredientsList;
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

  Future removeIngredient(Ingredient ingredientItem) async {
    try {
      loading.value = true;
      var response = await provider.deleteIngredientRequest(ingredientItem.id!);
      print(response);
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }
}
