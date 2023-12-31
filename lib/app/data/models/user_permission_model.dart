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
  String? name;
  String? gender;
  String? birthDate;
  int? height;
  int? weight;
  double? bmi;
  double? targetBmi;
  double? targetWeight;
  double? dailyCalories;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.name,
      this.gender,
      this.birthDate,
      this.height,
      this.weight,
      this.bmi,
      this.targetBmi,
      this.targetWeight,
      this.dailyCalories});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    name = json['name'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    height = json['height'];
    weight = json['weight'];
    bmi = double.tryParse(json['bmi'].toString());
    targetBmi = double.tryParse(json['targetBmi'].toString());
    targetWeight = double.tryParse(json['targetWeight'].toString());
    dailyCalories = double.tryParse(json['dailyCalories'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['provider'] = provider;
    data['confirmed'] = confirmed;
    data['blocked'] = blocked;
    data['name'] = name;
    data['gender'] = gender;
    data['birthDate'] = birthDate;
    data['height'] = height;
    data['weight'] = weight;
    data['bmi'] = bmi;
    data['targetBmi'] = targetBmi;
    data['targetWeight'] = targetWeight;
    data['dailyCalories'] = dailyCalories;
    return data;
  }
}
