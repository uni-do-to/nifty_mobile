class RecipeRequest {
  Data? data;

  RecipeRequest({this.data});

  RecipeRequest.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (data != null) {
      json['data'] = data?.toJson();
    }
    return json;
  }
}

class Data {
  String? name;
  int? caloriesPer100grams;
  int? niftyPoints;
  int? totalWeight;
  int? totalCalories;
  int? gramsPerCircle;
  String? owner;
  List<Ingredients>? ingredients;

  Data(
      {this.name,
      this.caloriesPer100grams,
      this.niftyPoints,
      this.totalWeight,
      this.totalCalories,
      this.gramsPerCircle,
      this.owner,
      this.ingredients});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    caloriesPer100grams = json['caloriesPer100grams'];
    niftyPoints = json['niftyPoints'];
    totalWeight = json['totalWeight'];
    totalCalories = json['totalCalories'];
    gramsPerCircle = json['gramsPerCircle'];
    owner = json['owner'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients?.add(Ingredients.fromJson(v));
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
    data['owner'] = owner;
    if (ingredients != null) {
      data['ingredients'] = ingredients?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredients {
  int? id;
  int? ingredient;
  int? grams;
  int? calories;

  Ingredients({this.id, this.ingredient, this.grams, this.calories});

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ingredient = json['ingredient'];
    grams = json['grams'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ingredient'] = ingredient;
    data['grams'] = grams;
    data['calories'] = calories;
    return data;
  }
}
