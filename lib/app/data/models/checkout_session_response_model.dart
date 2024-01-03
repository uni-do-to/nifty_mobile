class CheckoutSessionResponse {
  String? id;
  String? object;
  int? amountTotal;
  String? currency;
  CustomerDetails? customerDetails;
  String? paymentStatus;
  Metadata? metadata;

  CheckoutSessionResponse(
      {this.id,
      this.object,
      this.amountTotal,
      this.currency,
      this.customerDetails,
      this.paymentStatus,
      this.metadata});

  CheckoutSessionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    amountTotal = json['amount_total'];
    currency = json['currency'];
    customerDetails = json['customer_details'] != null
        ? CustomerDetails?.fromJson(json['customer_details'])
        : null;
    paymentStatus = json['payment_status'];
    metadata =
        json['metadata'] != null ? Metadata?.fromJson(json['metadata']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['amount_total'] = amountTotal;
    data['currency'] = currency;
    if (customerDetails != null) {
      data['customer_details'] = customerDetails?.toJson();
    }
    data['payment_status'] = paymentStatus;
    if (metadata != null) {
      data['metadata'] = metadata?.toJson();
    }
    return data;
  }
}

class CustomerDetails {
  String? email;
  String? name;
  dynamic phone;
  String? taxExempt;

  CustomerDetails({this.email, this.name, this.phone, this.taxExempt});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    taxExempt = json['tax_exempt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['tax_exempt'] = taxExempt;
    return data;
  }
}

class Metadata {
  String? productId;
  String? productName;

  Metadata({this.productId, this.productName});

  Metadata.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    return data;
  }
}
