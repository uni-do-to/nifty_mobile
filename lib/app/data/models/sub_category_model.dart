import 'package:nifty_mobile/app/data/models/api_response.dart';

import 'category_model.dart';
class SubCategory extends ApiDataModel {
  int? id;
  Attributes? attributes;

  SubCategory({this.id, this.attributes});

  SubCategory.fromJson(Map<String, dynamic> json) {
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
  ApiSingleResponse<Category>? category;

  Attributes({this.nameEn, this.nameFr, this.category});

  Attributes.fromJson(Map<String, dynamic> json) {
    nameEn = json['nameEn'];
    nameFr = json['nameFr'];
    category =
    json['category'] != null ? ApiSingleResponse.fromJson(json['category'], (json) => Category?.fromJson(json)) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nameEn'] = nameEn;
    data['nameFr'] = nameFr;
    if (category != null) {
      data['category'] = category?.toJson();
    }
    return data;
  }
}
