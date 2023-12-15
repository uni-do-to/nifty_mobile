import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nifty_mobile/app/config/app_constants.dart';
import 'package:nifty_mobile/app/services/config_service.dart';
import 'app.dart';
import 'app/data/auth_provider.dart';
import 'app/services/auth_service.dart';

void main() async{
  await GetStorage.init("auth");
  await GetStorage.init(AppConstants.CONFIG_KEY);
  Get.put(AuthService());
  Get.put(AuthProvider()) ;
  Get.put(ConfigService()) ;
  runApp(const App());
}
