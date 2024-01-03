class SubscriptionPlansResponse {
  List<SubscriptionPlan>? subscriptionPlans;

  SubscriptionPlansResponse({this.subscriptionPlans});

  SubscriptionPlansResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      subscriptionPlans = <SubscriptionPlan>[];
      json['data'].forEach((v) {
        subscriptionPlans?.add(SubscriptionPlan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (subscriptionPlans != null) {
      data['data'] = subscriptionPlans?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionPlan {
  int? id;
  String? title;
  String? description;
  double? price;
  String? currency;
  bool? isSubscription;
  String? interval;
  int? trialPeriodDays;
  String? stripeProductId;
  String? stripePriceId;
  String? stripePlanId;
  dynamic slug;

  SubscriptionPlan(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.currency,
      this.isSubscription,
      this.interval,
      this.trialPeriodDays,
      this.stripeProductId,
      this.stripePriceId,
      this.stripePlanId,
      this.slug});

  SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = double.tryParse(json['price'].toString());
    currency = json['currency'];
    isSubscription = json['isSubscription'];
    interval = json['interval'];
    trialPeriodDays = json['trialPeriodDays'];
    stripeProductId = json['stripeProductId'];
    stripePriceId = json['stripePriceId'];
    stripePlanId = json['stripePlanId'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['currency'] = currency;
    data['isSubscription'] = isSubscription;
    data['interval'] = interval;
    data['trialPeriodDays'] = trialPeriodDays;
    data['stripeProductId'] = stripeProductId;
    data['stripePriceId'] = stripePriceId;
    data['stripePlanId'] = stripePlanId;
    data['slug'] = slug;
    return data;
  }
}
