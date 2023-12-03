class SportsResponse {
  List<SportData>? data;
  Meta? meta;

  SportsResponse({this.data, this.meta});

  SportsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SportData>[];
      json['data'].forEach((v) {
        data?.add(SportData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta?.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (data != null) {
      json['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      json['meta'] = meta?.toJson();
    }
    return json;
  }
}

class SportData {
  int? id;
  Attributes? attributes;

  SportData({this.id, this.attributes});

  SportData.fromJson(Map<String, dynamic> json) {
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
  int? caloriesPerMinute;

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

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination?.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination?.toJson();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({this.page, this.pageSize, this.pageCount, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['pageCount'] = pageCount;
    data['total'] = total;
    return data;
  }
}
