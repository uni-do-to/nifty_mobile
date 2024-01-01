class ChangePasswordRequest {
  String? password;
  String? currentPassword;
  String? passwordConfirmation;

  ChangePasswordRequest(
      {this.password, this.currentPassword, this.passwordConfirmation});

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    currentPassword = json['currentPassword'];
    passwordConfirmation = json['passwordConfirmation'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['password'] = password;
    data['currentPassword'] = currentPassword;
    data['passwordConfirmation'] = passwordConfirmation;
    return data;
  }
}
