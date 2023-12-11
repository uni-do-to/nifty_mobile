class Units {
  int? id;
  String? name;
  double? grams;

  Units({this.id, this.name, this.grams});

  Units.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    grams =  double.tryParse(json['grams'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['grams'] = grams;
    return data;
  }
}