import 'package:nifty_mobile/app/data/models/unit_model.dart';

class IngredientRequest {
  Data? data;

  IngredientRequest({this.data});

  IngredientRequest.fromJson(Map<String, dynamic> json) {
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
  String? nameEn;
  String? nameFr;
  String? subCategory;
  int? caloriesPer100grams;
  int? niftyPoints;
  int? gramsPerCircle;
  List<Units>? units;

  Data(
      {this.nameEn,
      this.nameFr,
      this.subCategory,
      this.caloriesPer100grams,
      this.niftyPoints,
      this.gramsPerCircle,
      this.units});

  Data.fromJson(Map<String, dynamic> json) {
    nameEn = json['nameEn'];
    nameFr = json['nameFr'];
    subCategory = json['sub_category'];
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
    data['sub_category'] = subCategory;
    data['caloriesPer100grams'] = caloriesPer100grams;
    data['niftyPoints'] = niftyPoints;
    data['gramsPerCircle'] = gramsPerCircle;
    if (units != null) {
      data['units'] = units?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

