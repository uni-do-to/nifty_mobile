class SignupRequest {
  String? username;
  String? email;
  String? password;
  String? name;
  String? gender;
  String? birthDate;
  String? height;
  String? weight;
  String? bmi;
  String? targetBmi;
  String? targetWeight;
  double? dailyCalories ;

  SignupRequest(
      {this.username,
      this.email,
      this.password,
      this.name,
      this.gender,
      this.birthDate,
      this.height,
      this.weight,
      this.bmi,
      this.targetBmi,
      this.targetWeight,
      this.dailyCalories});

  SignupRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    height = json['height'];
    weight = json['weight'];
    bmi = json['bmi'];
    targetBmi = json['targetBmi'];
    targetWeight = json['targetWeight'];
    dailyCalories = json['dailyCalories'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
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
