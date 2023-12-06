import 'package:nifty_mobile/app/data/models/sub_category_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';

class Ingredient {
  IngredientsData? data;

  Ingredient({this.data});

  Ingredient.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? IngredientsData?.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (data != null) {
      json['data'] = data?.toJson();
    }
    return json;
  }
}

class IngredientsData {
  int? id;
  Attributes? attributes;

  IngredientsData({this.id, this.attributes});

  IngredientsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? Attributes?.fromJson(json['attributes'])
        : null;
  }

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
  String? nameEn;
  String? nameFr;
  SubCategory? subCategory;
  double? caloriesPer100grams;
  double? niftyPoints;
  double? gramsPerCircle;
  List<Units>? units;

  Attributes(
      {this.nameEn,
      this.nameFr,
      this.subCategory,
      this.caloriesPer100grams,
      this.niftyPoints,
      this.gramsPerCircle,
      this.units});

  Attributes.fromJson(Map<String, dynamic> json) {
    nameEn = json['nameEn'];
    nameFr = json['nameFr'];
    subCategory = json['sub_category'] != null
        ? SubCategory?.fromJson(json['sub_category'])
        : null;
    caloriesPer100grams = json['caloriesPer100grams'];
    niftyPoints = json['niftyPoints'];
    gramsPerCircle = json['gramsPerCircle'];
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units?.add(Units.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nameEn'] = nameEn;
    data['nameFr'] = nameFr;
    if (subCategory != null) {
      data['sub_category'] = subCategory?.toJson();
    }
    data['caloriesPer100grams'] = caloriesPer100grams;
    data['niftyPoints'] = niftyPoints;
    data['gramsPerCircle'] = gramsPerCircle;
    if (units != null) {
      data['units'] = units?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

