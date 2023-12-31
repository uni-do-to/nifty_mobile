class CheckoutUrlResponse {
  String? id;
  String? object;
  String? successUrl;
  String? url;

  CheckoutUrlResponse({this.id, this.object, this.successUrl, this.url});

  CheckoutUrlResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    successUrl = json['success_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['success_url'] = successUrl;
    data['url'] = url;
    return data;
  }
}
