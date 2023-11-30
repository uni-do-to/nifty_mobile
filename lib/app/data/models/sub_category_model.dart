import 'category_model.dart';

class SubCategory {
  Data? data;

  SubCategory({this.data});

  SubCategory.fromJson(Map<String, dynamic> json) {
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
  int? id;
  Attributes? attributes;

  Data({this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
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
  Category? category;

  Attributes({this.nameEn, this.nameFr, this.category});

  Attributes.fromJson(Map<String, dynamic> json) {
    nameEn = json['nameEn'];
    nameFr = json['nameFr'];
    category =
    json['category'] != null ? Category?.fromJson(json['category']) : null;
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
