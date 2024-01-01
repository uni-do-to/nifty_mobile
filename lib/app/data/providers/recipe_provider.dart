import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:nifty_mobile/app/data/models/recipe_request_model.dart';
import 'package:nifty_mobile/app/data/models/recipe_model.dart';
import 'package:nifty_mobile/app/utils/extensions.dart';

import '../models/api_response.dart';

class RecipeProvider extends BaseProvider {
  Future<ApiSingleResponse<Recipe>?> createRecipe(
      RecipeRequest recipeRequest) async {
    var response = await post(
      ConfigAPI.recipesUrl,
      removeNull(
        ApiSingleResponse<RecipeRequest>(data: recipeRequest).toJson(),
      ),
    );

    print("request done");
    return decode<ApiSingleResponse<Recipe>?>(
        response,
        (data) =>
            ApiSingleResponse.fromJson(data, (data) => Recipe.fromJson(data)));
  }

  Future<Response> deleteRecipe(int id) async =>
      await delete('${ConfigAPI.recipesUrl}/$id');

  Future<ApiListResponse<Recipe>?> getRecipeList() async {
    final response = await get(ConfigAPI.recipesUrl);

    return decode<ApiListResponse<Recipe>?>(
        response,
        (data) =>
            ApiListResponse.fromJson(data, (data) => Recipe.fromJson(data)));
  }
}
