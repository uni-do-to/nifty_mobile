import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nifty_mobile/app/data/models/user_permission_model.dart';

class AuthService extends GetxService {

  UserPermission? credentials;
  late GetStorage authBox ;
  @override
  void onInit() {
    super.onInit();
    initCredentials() ;
  }

  initCredentials() async {
    authBox = GetStorage("auth");
    credentials = await loadCredentials();
  }

  Future<UserPermission?> loadCredentials() async {
    var exists = authBox.hasData("credentials");
    // return null;
    log('${exists.isBlank}');

    return exists
        ? UserPermission.fromJson(json.decode(await authBox.read("credentials")))
        : null;
  }

  Future<bool> saveCredentials(UserPermission? credentials) async {
    await authBox.write("credentials" , json.encode(credentials!.toJson()));
    this.credentials = credentials;
    return true;
  }

  Future<bool> removeCredentials() async {
    await authBox.erase();
    credentials = null;
    return true;
  }

  bool sessionIsEmpty() {
    if (credentials == null) return true;
    return false;
  }
}