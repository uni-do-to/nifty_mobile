import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nifty_mobile/app/config/app_constants.dart';
import 'package:nifty_mobile/app/locale/language_model.dart';

class ConfigService extends GetxService {

  late LanguageModel languageModel;
  late GetStorage configBox ;
  late String displayUnit ;

  @override
  void onInit() {
    super.onInit();
    initConfig() ;
  }

  initConfig() async {
    configBox = GetStorage(AppConstants.CONFIG_KEY);
    languageModel = loadLanguage();
    displayUnit = loadDisplayUnit() ;
  }

  LanguageModel loadLanguage()  {
    var lang = configBox.read<String>(AppConstants.LANG_KEY);

    if(lang != null && AppConstants.languages.keys.contains(lang)) {
      return AppConstants.languages[lang]! ;
    }

    saveLang(AppConstants.DEFAULT_LANGUAGE) ;

    return AppConstants.languages[AppConstants.DEFAULT_LANGUAGE]! ;
  }

  Future<bool> saveLang(String lang) async {
    if(!AppConstants.languages.keys.contains(lang)) {
      return false;
    }

    await configBox.write(AppConstants.LANG_KEY , lang);
    languageModel = AppConstants.languages[lang]!;
    return true;
  }

  String loadDisplayUnit()  {
    var unit = configBox.read<String>(AppConstants.UNIT_KEY);

    if(unit != null && AppConstants.displayUnits.contains(unit)) {
      return unit ;
    }

    saveDisplayUnit(AppConstants.DEFAULT_DISPLAY_UNIT) ;

    return AppConstants.DEFAULT_DISPLAY_UNIT ;

  }

  Future<bool> saveDisplayUnit(String unit) async {
    if(!AppConstants.displayUnits.contains(unit)) {
      return false;
    }

    await configBox.write(AppConstants.DEFAULT_DISPLAY_UNIT , unit);
    displayUnit = unit;
    return true;
  }

}