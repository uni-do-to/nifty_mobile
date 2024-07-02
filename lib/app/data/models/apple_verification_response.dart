class AppleVerificationResponse {
  String? message;
  String? status;

  AppleVerificationResponse({this.message, this.status});

  AppleVerificationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
