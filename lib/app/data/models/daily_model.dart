import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/recipe_model.dart';
import 'package:nifty_mobile/app/data/models/sports_model.dart';

import 'api_response.dart';
import 'ingredient_model.dart';


class Daily extends ApiDataModel {
  int? id;
  Attributes? attributes;

  Daily({this.id, this.attributes});

  Daily.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? Attributes?.fromJson(json['attributes'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes?.toJson();
    }
    return data;
  }
}

class Attributes {
  String? date;
  double? dailyCalories;
  double? consumedCalories;
  double? calorieBurned;
  List<Meals>? meals;
  List<Sports>? sports;

  Attributes(
      {this.date,
      this.dailyCalories,
      this.consumedCalories,
      this.calorieBurned,
      this.meals,
      this.sports});

  Attributes.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dailyCalories = json['dailyCalories'];
    consumedCalories = json['consumedCalories'];
    calorieBurned = json['calorieBurned'];
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals?.add(Meals.fromJson(v));
      });
    }
    if (json['sports'] != null) {
      sports = <Sports>[];
      json['sports'].forEach((v) {
        sports?.add(Sports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['dailyCalories'] = dailyCalories;
    data['consumedCalories'] = consumedCalories;
    data['calorieBurned'] = calorieBurned;
    if (meals != null) {
      data['meals'] = meals?.map((v) => v.toJson()).toList();
    }
    if (sports != null) {
      data['sports'] = sports?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {
  int? id;
  int? index;
  String? title;
  double? calories;
  double? weight;
  List<MealItem>? items;

  Meals(
      {this.id,
      this.index,
      this.title,
      this.calories,
      this.weight,
      this.items});

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    index = json['index'];
    title = json['title'];
    calories = json['calories'];
    weight = json['weight'];
    if (json['items'] != null) {
      items = <MealItem>[];
      json['items'].forEach((v) {
        items?.add(MealItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['index'] = index;
    data['title'] = title;
    data['calories'] = calories;
    data['weight'] = weight;
    if (items != null) {
      data['items'] = items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MealItem {
  int? id;
  int? calories;
  double? weight;
  ApiSingleResponse<Ingredient>? ingredient;
  ApiSingleResponse<Recipe>? recipe;

  MealItem({this.id, this.calories, this.weight, this.ingredient, this.recipe});

  MealItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calories = json['calories'];
    weight = json['weight'];
    ingredient = json['ingredient'] != null
        ? ApiSingleResponse.fromJson(json['ingredient'], (json) => Ingredient.fromJson(json))
        : null;
    recipe = json['recipe'] != null
        ? ApiSingleResponse.fromJson(json['recipe'], (json) => Recipe?.fromJson(json))
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['calories'] = calories;
    data['weight'] = weight;
    if (ingredient != null) {
      data['ingredient'] = ingredient?.toJson();
    }
    if (recipe != null) {
      data['recipe'] = recipe?.toJson();
    }
    return data;
  }

  bool isIngredient () {
    return ingredient?.data != null ;
  }
  String? getName () {
    if(isIngredient()){
      var attributes = ingredient?.data?.attributes ;
      return Get.locale?.languageCode == 'fr' ? attributes?.nameFr : attributes?.nameEn ;
    }else {
      var attributes = recipe?.data?.attributes ;
      return attributes?.name ;
    }
  }
}


class Sports {
  int? id;
  int? index;
  String? title;
  double? calories;
  List<SportItem>? items;

  Sports({this.id, this.index, this.title, this.calories, this.items});

  Sports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    index = json['index'];
    title = json['title'];
    calories = json['calories'];
    if (json['items'] != null) {
      items = <SportItem>[];
      json['items'].forEach((v) {
        items?.add(SportItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['index'] = index;
    data['title'] = title;
    data['calories'] = calories;
    if (items != null) {
      data['items'] = items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SportItem {
  int? id;
  double? calories;
  int? minutes;
  ApiSingleResponse<Sport>? sport;

  SportItem({this.id, this.calories, this.minutes, this.sport});

  SportItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calories = json['calories'];
    minutes = json['minutes'];
    sport = json['sport'] != null
        ? ApiSingleResponse.fromJson(json['sport'], (json) => Sport?.fromJson(json))
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['calories'] = calories;
    data['minutes'] = minutes;
    if (sport != null) {
      data['sport'] = sport?.toJson();
    }
    return data;
  }
}
