import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';

import '../models/ingredient_request_model.dart';

class IngredientProvider extends BaseProvider {

  Future<Ingredient?> getIngredient(int id) async {
    final response = await get('ingredients/$id');
    return decode<Ingredient?>(response, Ingredient.fromJson);
  }

  Future<Ingredient?> createIngredient(
          IngredientRequest ingredientRequest) async {

    var response = await post( ConfigAPI.ingredientsUrl, ingredientRequest.toJson() );

    return decode<Ingredient?>(response, Ingredient.fromJson);
  }

  Future<Response> deleteIngredientRequest(int id) async =>
      await delete('ingredients/$id');
}
