class UserPermission {
  String? jwt;
  User? user;

  UserPermission({this.jwt, this.user});

  UserPermission.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jwt'] = jwt;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['provider'] = provider;
    data['confirmed'] = confirmed;
    data['blocked'] = blocked;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
