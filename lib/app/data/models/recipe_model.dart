import 'package:nifty_mobile/app/data/models/api_response.dart';

class Recipe extends ApiDataModel {
  int? id;
  Attributes? attributes;

  Recipe({this.id, this.attributes});

  Recipe.fromJson(Map<String, dynamic> json) {
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
  String? name;
  double? caloriesPer100grams;
  double? niftyPoints;
  double? totalWeight;
  double? totalCalories;
  double? gramsPerCircle;

  Attributes(
      {this.name,
      this.caloriesPer100grams,
      this.niftyPoints,
      this.totalWeight,
      this.totalCalories,
      this.gramsPerCircle});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    caloriesPer100grams = json['caloriesPer100grams'];
    niftyPoints = json['niftyPoints'];
    totalWeight = json['totalWeight'];
    totalCalories = json['totalCalories'];
    gramsPerCircle = json['gramsPerCircle'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['caloriesPer100grams'] = caloriesPer100grams;
    data['niftyPoints'] = niftyPoints;
    data['totalWeight'] = totalWeight;
    data['totalCalories'] = totalCalories;
    data['gramsPerCircle'] = gramsPerCircle;
    return data;
  }
}

