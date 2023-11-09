class BackendError {
  Error? error;

  BackendError({this.error});

  BackendError.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? Error?.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (error != null) {
      data['error'] = error?.toJson();
    }
    return data;
  }
}

class Error {
  int? status;
  String? name;
  String? message;
  Details? details;

  Error({this.status, this.name, this.message, this.details});

  Error.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    message = json['message'];
    details =
        json['details'] != null ? Details?.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['name'] = name;
    data['message'] = message;
    if (details != null) {
      data['details'] = details?.toJson();
    }
    return data;
  }
}

class Details {
  List<Errors>? errors;

  Details({this.errors});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors?.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  List<String>? path;
  String? message;
  String? name;

  Errors({this.path, this.message, this.name});

  Errors.fromJson(Map<String, dynamic> json) {
    path = json['path'].cast<String>();
    message = json['message'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['path'] = path;
    data['message'] = message;
    data['name'] = name;
    return data;
  }
}
