class EditPersonalInfoRequest {
  String? name;
  String? gender;
  String? birthDate;

  EditPersonalInfoRequest({this.name, this.gender, this.birthDate});

  EditPersonalInfoRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['gender'] = gender;
    data['birthDate'] = birthDate;
    return data;
  }
}
