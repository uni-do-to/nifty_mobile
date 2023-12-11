import 'package:get/get.dart';
import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:nifty_mobile/app/data/models/recipe_request_model.dart';
import 'package:nifty_mobile/app/data/models/recipe_model.dart';
import 'package:nifty_mobile/app/data/models/sports_model.dart';
import 'package:nifty_mobile/app/utils/extentions.dart';

import '../models/api_response.dart';
import '../models/daily_model.dart' ;

class DailyProvider extends BaseProvider {
  Future<Recipe?> createRecipe(RecipeRequest recipeRequest) async {
    var response = await post(ConfigAPI.dailyUrl, recipeRequest.toJson());

    return decode<Recipe?>(response, Recipe.fromJson);
  }

  Future<Response> deleteRecipe(int id) async =>
      await delete('${ConfigAPI.dailyUrl}/$id');

  Future<ApiListResponse<Daily>?> getDaily(String date) async {
    final response = await get(ConfigAPI.dailyUrl , query: {
      "populate" : "meals,sports,meals.items,sports.items,meals.items.ingredient,meals.items.recipe,sports.items.sport" ,
      "filters[date]" : date
    });

    return decode<ApiListResponse<Daily>?>(
        response,
            (data) => ApiListResponse.fromJson(
            data, (data) => Daily.fromJson(data)));
  }

  Future<ApiSingleResponse<Daily>?> editDaily(Daily daily) async{

    final response = await put('${ConfigAPI.dailyUrl}/${daily.id}' ,{
      "data" : removeNull(daily.attributes?.toJson())
    }, query: {
      "populate" : "meals,sports,meals.items,sports.items,meals.items.ingredient,meals.items.recipe,sports.items.sport" ,
    });

    return decode<ApiSingleResponse<Daily>?>(
        response,
            (data) => ApiSingleResponse.fromJson(
            data, (data) => Daily.fromJson(data)));
  }

  Future<ApiSingleResponse<Daily>?> createDaily(String date) async {
    final response = await post(ConfigAPI.dailyUrl ,ApiSingleResponse<DailyAttributes>(
      data: DailyAttributes(
        date: date,
        calorieBurned: 0,
        consumedCalories: 0,
        dailyCalories: 0,
        meals: [
          Meals(
            index: 0,
            title: "Meal 0" ,
            calories: 0,
            weight: 0
          )
        ],
        sports: [
          Sports(
            index: 0,
            title: "sport 0",
            calories: 0,

          )
        ]
        )
    ).toJson() ,query: {
      "populate" : "meals,sports,meals.items,sports.items,meals.items.ingredient,meals.items.recipe,sports.items.sport" ,
      "filters[date]" : date
    });

    return decode<ApiSingleResponse<Daily>?>(
        response,
            (data) => ApiSingleResponse.fromJson(
            data, (data) => Daily.fromJson(data)));
  }
}
