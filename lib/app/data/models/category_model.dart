import 'package:diacritic/diacritic.dart';
import 'package:nifty_mobile/app/data/models/api_response.dart';


class Category extends ApiDataModel{
  int? id;
  Attributes? attributes;

  Category({this.id, this.attributes});

  Category.fromJson(Map<String, dynamic> json) {
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

  get simpleEnName => removeDiacritics(nameEn?.toLowerCase()??"") ;
  get simpleFrName => removeDiacritics(nameFr?.toLowerCase()??"") ;

  Attributes({this.nameEn, this.nameFr});

  Attributes.fromJson(Map<String, dynamic> json) {
    nameEn = json['nameEn'];
    nameFr = json['nameFr'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nameEn'] = nameEn;
    data['nameFr'] = nameFr;
    return data;
  }
}
