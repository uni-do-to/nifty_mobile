import 'package:diacritic/diacritic.dart';
import 'package:nifty_mobile/app/data/models/api_response.dart';
import 'package:nifty_mobile/app/data/models/sub_category_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';


class Ingredient extends ApiDataModel {
  int? id;
  Attributes? attributes;

  Ingredient({this.id, this.attributes});

  Ingredient.fromJson(Map<String, dynamic> json) {
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
  String? nameEn;
  String? nameFr;
  ApiSingleResponse<SubCategory>? subCategory;
  double? caloriesPer100grams;
  double? niftyPoints;
  double? gramsPerCircle;
  List<Units>? units;

  get simpleEnName => removeDiacritics(nameEn?.toLowerCase()??"") ;
  get simpleFrName => removeDiacritics(nameFr?.toLowerCase()??"") ;

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
        ? ApiSingleResponse.fromJson(json['sub_category'], (json) => SubCategory?.fromJson(json))
        : null;
    caloriesPer100grams = double.tryParse(json['caloriesPer100grams'].toString());
    niftyPoints =  double.tryParse(json['niftyPoints'].toString());
    gramsPerCircle =  double.tryParse(json['gramsPerCircle'].toString());
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

