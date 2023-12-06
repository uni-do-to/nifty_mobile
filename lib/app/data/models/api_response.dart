
class ApiListResponse<T extends ApiDataModel> {
  List<T>? data;
  Meta? meta;

  ApiListResponse.fromJson(Map<String, dynamic> json , ItemCreator<T> creator) {
    if (json['data'] != null) {
      data = <T>[];
      json['data'].forEach((v) {
        data?.add(creator(v));
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

class ApiSingleResponse<T extends ApiDataModel> {
  T? data;

  ApiSingleResponse({this.data});

  ApiSingleResponse.fromJson(Map<String, dynamic> json, ItemCreator<T> creator) {
    data = json['data'] != null ? creator(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (data != null) {
      json['data'] = data?.toJson();
    }
    return json;
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


typedef ItemCreator<S> = S Function(Map<String, dynamic> json);


abstract class ApiDataModel {
  Map<String, dynamic> toJson() ;
}
