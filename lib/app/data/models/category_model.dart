class Category {
  Data? data;

  Category({this.data});

  Category.fromJson(Map<String, dynamic> json) {
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
  AttributesB? attributesB;

  Data({this.id, this.attributesB});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributesB = json['attributesB'] != null
        ? AttributesB?.fromJson(json['attributesB'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (attributesB != null) {
      data['attributesB'] = attributesB?.toJson();
    }
    return data;
  }
}

class AttributesB {
  String? nameEn;
  String? nameFr;

  AttributesB({this.nameEn, this.nameFr});

  AttributesB.fromJson(Map<String, dynamic> json) {
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
