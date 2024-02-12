
import 'package:nifty_mobile/generated/locales.g.dart';

import '../locale/language_model.dart';

class AppConstants {
  static const String CONFIG_KEY = 'config';
  static const String LANG_KEY = 'lang';
  static const String UNIT_KEY = 'unit';
  static const String DEFAULT_LANGUAGE = 'fr';
  static const String DEFAULT_DISPLAY_UNIT = "Nifty";


  static Map<String,LanguageModel> languages = {
    "en": LanguageModel(imageUrl: "🇺🇸", languageName: 'English',
      countryCode: 'US', languageCode: 'en',),
    "fr": LanguageModel(imageUrl: "fr", languageName: 'French',
      countryCode: 'FR', languageCode: 'fr',),
  };

  static List<String> displayUnits = [LocaleKeys.settings_nifty_points , LocaleKeys.settings_calories];
}