import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/user_permission_model.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/services/auth_service.dart';
import 'package:nifty_mobile/app/services/config_service.dart';

import '../../../locale/language_model.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final Rx<User?> user = Rx(null);
  final ConfigService configService = Get.find() ;
  late Rx<LanguageModel?> language  ;

  @override
  void onInit() {
    super.onInit();
    user.value = Get.find<AuthService>().credentials?.user  ;
    language = Rx(configService.languageModel) ;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  changeLanguage(String key) async{
    var result = await configService.saveLang(key);
    if(result){
      Get.locale = Locale(configService.languageModel.languageCode , configService.languageModel.countryCode) ;
      Get.offAllNamed(Routes.SPLASH) ;
    }
  }

}
