
import 'api_response.dart';

class History extends ApiDataModel{
  int? id;
  Attributes? attributes;

  History({this.id, this.attributes});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? Attributes?.fromJson(json['attributes'])
        : null;
  }

  @override
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
  String? date;
  double? weight;
  double? height;

  DateTime get dateTime => DateTime.parse(date ?? '');

  Attributes({this.date, this.weight, this.height});

  Attributes.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    weight = double.tryParse(json['weight'].toString());
    height = double.tryParse(json['height'].toString());
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['weight'] = weight;
    data['height'] = height;
    return data;
  }
}
