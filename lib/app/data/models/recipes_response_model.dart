class RecipesResponse {
  List<RecipeData>? data;
  Meta? meta;

  RecipesResponse({this.data, this.meta});

  RecipesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RecipeData>[];
      json['data'].forEach((v) {
        data?.add(RecipeData.fromJson(v));
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

class RecipeData {
  int? id;
  Attributes? attributes;

  RecipeData({this.id, this.attributes});

  RecipeData.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? caloriesPer100grams;
  int? niftyPoints;
  int? totalWeight;
  int? totalCalories;
  int? gramsPerCircle;

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
