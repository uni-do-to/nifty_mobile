class CustomerPortalSessionResponse {
  String? id;
  String? object;
  String? configuration;
  int? created;
  String? customer;
  dynamic flow;
  bool? livemode;
  dynamic locale;
  dynamic onBehalfOf;
  dynamic returnUrl;
  String? url;

  CustomerPortalSessionResponse(
      {this.id,
      this.object,
      this.configuration,
      this.created,
      this.customer,
      this.flow,
      this.livemode,
      this.locale,
      this.onBehalfOf,
      this.returnUrl,
      this.url});

  CustomerPortalSessionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    configuration = json['configuration'];
    created = json['created'];
    customer = json['customer'];
    flow = json['flow'];
    livemode = json['livemode'];
    locale = json['locale'];
    onBehalfOf = json['on_behalf_of'];
    returnUrl = json['return_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['configuration'] = configuration;
    data['created'] = created;
    data['customer'] = customer;
    data['flow'] = flow;
    data['livemode'] = livemode;
    data['locale'] = locale;
    data['on_behalf_of'] = onBehalfOf;
    data['return_url'] = returnUrl;
    data['url'] = url;
    return data;
  }
}
