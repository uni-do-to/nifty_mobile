import 'dart:convert';

import 'package:nifty_mobile/app/base/base_provider.dart';
import 'package:nifty_mobile/app/config/api_constants.dart';
import 'package:nifty_mobile/app/data/models/change_password_request_model.dart';
import 'package:nifty_mobile/app/data/models/edit_health_profile_request_model.dart';
import 'package:nifty_mobile/app/data/models/edit_personal_info_request_model.dart';
import 'package:nifty_mobile/app/data/models/checkout_url_response_model.dart';
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

  Future<UserPermission?> getMe() async {
    final response = await get(ConfigAPI.meUrl);

    return decode<UserPermission?>(response, UserPermission.fromJson);
  }

  Future<UserPermission?> changePassword(ChangePasswordRequest reqBody) async {
    final response = await post(ConfigAPI.changePasswordUrl, reqBody.toJson());

    return decode<UserPermission?>(response, UserPermission.fromJson);
  }

  Future<User?> editUserInfo(EditPersonalInfoRequest reqBody) async {
    final response = await put(ConfigAPI.meUrl, reqBody.toJson());

    return decode<User?>(response, User.fromJson);
  }

  Future<User?> editUserHealthProfile(EditHealthProfileRequest reqBody) async {
    final response = await put(ConfigAPI.meUrl, reqBody.toJson());

    return decode<User?>(response, User.fromJson);
  }
}
