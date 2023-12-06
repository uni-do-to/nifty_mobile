import 'package:nifty_mobile/app/data/models/api_response.dart';

class Sport extends ApiDataModel {
  int? id;
  Attributes? attributes;

  Sport({this.id, this.attributes});

  Sport.fromJson(Map<String, dynamic> json) {
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
  double? caloriesPerMinute;

  Attributes({this.nameEn, this.nameFr, this.caloriesPerMinute});

  Attributes.fromJson(Map<String, dynamic> json) {
    nameEn = json['nameEn'];
    nameFr = json['nameFr'];
    caloriesPerMinute = json['caloriesPerMinute'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nameEn'] = nameEn;
    data['nameFr'] = nameFr;
    data['caloriesPerMinute'] = caloriesPerMinute;
    return data;
  }
}