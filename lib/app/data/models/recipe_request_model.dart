import 'package:nifty_mobile/app/data/models/api_response.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';

class RecipeRequest extends ApiDataModel{
  String? name;
  double? caloriesPer100grams;
  double? niftyPoints;
  double? totalWeight;
  double? totalCalories;
  double? gramsPerCircle;
  List<RecipeItem>? ingredients;

  RecipeRequest(
      {this.name,
      this.caloriesPer100grams,
      this.niftyPoints,
      this.totalWeight,
      this.totalCalories,
      this.gramsPerCircle,
      this.ingredients});

  RecipeRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    caloriesPer100grams = json['caloriesPer100grams'];
    niftyPoints = json['niftyPoints'];
    totalWeight = json['totalWeight'];
    totalCalories = json['totalCalories'];
    gramsPerCircle = json['gramsPerCircle'];
    if (json['ingredients'] != null) {
      ingredients = <RecipeItem>[];
      json['ingredients'].forEach((v) {
        ingredients?.add(RecipeItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['caloriesPer100grams'] = caloriesPer100grams;
    data['niftyPoints'] = niftyPoints;
    data['totalWeight'] = totalWeight;
    data['totalCalories'] = totalCalories;
    data['gramsPerCircle'] = gramsPerCircle;
    if (ingredients != null) {
      data['ingredients'] = ingredients?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecipeItem {
  int? id;
  ApiSingleResponse<Ingredient>? ingredient;
  double? grams;
  double? calories;

  RecipeItem({this.id, this.ingredient, this.grams, this.calories});

  RecipeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ingredient = json['ingredient'] != null
        ? ApiSingleResponse.fromJson(
            json['ingredient'], (json) => Ingredient.fromJson(json))
        : null;
    grams = json['grams'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (ingredient != null) {
      data['ingredient'] = ingredient?.toJson();
    }
    data['grams'] = grams;
    data['calories'] = calories;
    return data;
  }
}
