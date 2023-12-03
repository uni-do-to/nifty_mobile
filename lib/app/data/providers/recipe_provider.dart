import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:nifty_mobile/app/data/models/categories_model.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/ingredients_model.dart';
import 'package:nifty_mobile/app/data/models/recipe_request_model.dart';
import 'package:nifty_mobile/app/data/models/recipes_response_model.dart';
import 'package:nifty_mobile/app/data/models/sub_categories_model.dart';

import '../models/ingredient_request_model.dart';

class RecipeProvider extends BaseProvider {
  Future<RecipeData?> createRecipe(RecipeRequest recipeRequest) async {
    var response = await post(ConfigAPI.recipesUrl, recipeRequest.toJson());

    return decode<RecipeData?>(response, RecipeData.fromJson);
  }

  Future<Response> deleteRecipe(int id) async =>
      await delete(ConfigAPI.recipesUrl + '/$id');

  Future<RecipesResponse> getRecipeList() async {
    final response = await get(ConfigAPI.recipesUrl);

    return decode<RecipesResponse>(response, RecipesResponse.fromJson);
  }
}
