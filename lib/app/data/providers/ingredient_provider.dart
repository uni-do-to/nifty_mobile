import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:nifty_mobile/app/data/models/categories_model.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/ingredients_model.dart';
import 'package:nifty_mobile/app/data/models/sub_categories_model.dart';

import '../models/ingredient_request_model.dart';

class IngredientProvider extends BaseProvider {
  Future<Ingredient?> getIngredient(int id) async {
    final response = await get('ingredients/$id');
    return decode<Ingredient?>(response, Ingredient.fromJson);
  }

  Future<Ingredient?> createIngredient(
      IngredientRequest ingredientRequest) async {
    var response =
        await post(ConfigAPI.ingredientsUrl, ingredientRequest.toJson());

    return decode<Ingredient?>(response, Ingredient.fromJson);
  }

  Future<Response> deleteIngredientRequest(int id) async =>
      await delete('ingredients/$id');

  Future<IngredientsResponse> getIngredientList({int? subCategoryId}) async {
    final response = await get(ConfigAPI.ingredientsUrl,
        query: {'filters[sub_category]': subCategoryId?.toString()}
          ..removeWhere((key, value) => value == null));

    return decode<IngredientsResponse>(response, IngredientsResponse.fromJson);
  }

  Future<SubCategoriesResponse> getSubCategoriesList(int categoryId) async {
    final response = await get(ConfigAPI.subCategoriesUrl,
        query: {'filters[category]': categoryId.toString()}
          ..removeWhere((key, value) => value == null));

    return decode<SubCategoriesResponse>(
        response, SubCategoriesResponse.fromJson);
  }

  Future<CategoriesResponse> getCategoriesList() async {
    final response = await get(ConfigAPI.categoriesUrl);

    return decode<CategoriesResponse>(response, CategoriesResponse.fromJson);
  }
}
