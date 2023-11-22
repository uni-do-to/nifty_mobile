import 'dart:convert';

import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:nifty_mobile/app/modules/register/signup_request_model.dart';

import 'models/user_permission_model.dart';

class AuthProvider extends BaseProvider {
  Future<UserPermission?> loginLocal(String identifier, String password) async {
    final response = await post(
        ConfigAPI.signInUrl, {"identifier": identifier, "password": password});

    return decode<UserPermission?>(response, UserPermission.fromJson);
  }

  Future<UserPermission?> registerLocal(SignupRequest reqBody) async {
    final response = await post(ConfigAPI.signUpUrl, reqBody.toJson());

    return decode<UserPermission?>(response, UserPermission.fromJson);
  }
}
