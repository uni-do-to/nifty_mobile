import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:nifty_mobile/app/data/models/api_response.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/sub_category_model.dart';

import '../models/category_model.dart';
import '../models/ingredient_request_model.dart';

class IngredientProvider extends BaseProvider {
  Future<Ingredient?> getIngredient(int id) async {
    final response = await get('ingredients/$id');
    return decode<Ingredient?>(response, Ingredient.fromJson);
  }

  Future<ApiSingleResponse<Ingredient>?> createIngredient(
      IngredientRequest ingredientRequest) async {
    var response =
        await post(ConfigAPI.ingredientsUrl, ingredientRequest.toJson());

    return decode<ApiSingleResponse<Ingredient>?>(
        response,
        (data) => ApiSingleResponse.fromJson(
            data, (data) => Ingredient.fromJson(data)));
  }

  Future<Response> deleteIngredientRequest(int id) async =>
      await delete('${ConfigAPI.ingredientsUrl}/$id');

  Future<ApiListResponse<Ingredient>?> getIngredientList(
      {int? subCategoryId}) async {
    final response = await get(ConfigAPI.ingredientsUrl,
        query: {
          'filters[sub_category]': subCategoryId?.toString(),
          'filters[isAdmin]': "true",
        }..removeWhere((key, value) => value == null));

    return decode<ApiListResponse<Ingredient>?>(
        response,
        (data) => ApiListResponse.fromJson(
            data, (data) => Ingredient.fromJson(data)));
  }

  Future<ApiListResponse<Ingredient>?> getMyIngredientsList() async {
    final response = await get(ConfigAPI.ingredientsUrl,
        query: {'filters[isAdmin]': "false"}
          ..removeWhere((key, value) => value == null));

    return decode<ApiListResponse<Ingredient>?>(
        response,
        (data) => ApiListResponse.fromJson(
            data, (data) => Ingredient.fromJson(data)));
  }

  Future<ApiListResponse<SubCategory>?> getSubCategoriesList(
      int categoryId) async {
    final response = await get(ConfigAPI.subCategoriesUrl,
        query: {'filters[category]': categoryId.toString()}
          ..removeWhere((key, value) => value == null));

    return decode<ApiListResponse<SubCategory>?>(
        response,
        (data) => ApiListResponse.fromJson(
            data, (data) => SubCategory.fromJson(data)));
  }

  Future<ApiListResponse<Category>?> getCategoriesList() async {
    final response = await get(ConfigAPI.categoriesUrl);

    return decode<ApiListResponse<Category>?>(
        response,
        (data) =>
            ApiListResponse.fromJson(data, (data) => Category.fromJson(data)));
  }
}
