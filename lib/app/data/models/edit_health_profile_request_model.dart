class EditHealthProfileRequest {
  String? height;
  String? weight;
  String? bmi;
  String? targetBmi;
  String? targetWeight;
  String? dailyCalories;

  EditHealthProfileRequest(
      {this.height,
      this.weight,
      this.bmi,
      this.targetBmi,
      this.targetWeight,
      this.dailyCalories});

  EditHealthProfileRequest.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    bmi = json['bmi'];
    targetBmi = json['targetBmi'];
    targetWeight = json['targetWeight'];
    dailyCalories = json['dailyCalories'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['height'] = height;
    data['weight'] = weight;
    data['bmi'] = bmi;
    data['targetBmi'] = targetBmi;
    data['targetWeight'] = targetWeight;
    data['dailyCalories'] = dailyCalories;
    return data;
  }
}
