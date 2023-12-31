import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nifty_mobile/app/config/app_constants.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/services/config_service.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    var languageModel = Get.find<ConfigService>().languageModel;
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
          lightSource: LightSource.topLeft,
          accentColor: ColorConstants.accentColor,
          baseColor: ColorConstants.grayBackgroundColor,
          variantColor: NeumorphicColors.variant,
          defaultTextColor: ColorConstants.accentColor,
          borderColor: const Color(0xffD4D4D4),
          appBarTheme: NeumorphicAppBarThemeData(
            buttonStyle: const NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(), depth: 2),
            textStyle:
                TextStyle(color: ColorConstants.accentColor, fontSize: 24),
            iconTheme:
                IconThemeData(color: ColorConstants.accentColor, size: 24),
          ),
          textTheme: GoogleFonts.robotoTextTheme().copyWith(
            labelLarge: TextStyle(
              fontWeight: FontWeight.w800,
              color: ColorConstants.accentColor,
              letterSpacing: 1.2,
              fontSize: 40.toFont,
            ),
            bodySmall: TextStyle(
              color: ColorConstants.accentColor,
              fontWeight: FontWeight.w400,
              fontSize: 24.toFont,
            ),
            bodyMedium: TextStyle(
              color: ColorConstants.accentColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            titleSmall: TextStyle(
              color: ColorConstants.accentColor,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            titleMedium: TextStyle(
              color: ColorConstants.accentColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            //finals
            titleLarge: TextStyle(
              color: ColorConstants.accentColor,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          depth: 1,
          intensity: 0.9,
          buttonStyle: const NeumorphicStyle(
            depth: 3,
            border: NeumorphicBorder(
              width: 0.5,
            ),
            intensity: 0.9,
          ),
          iconTheme: IconThemeData(
            color: ColorConstants.accentColor,
          )),
      darkTheme: const NeumorphicThemeData(
          baseColor: Color(0xFF3E3E3E),
          lightSource: LightSource.topLeft,
          depth: 4,
          intensity: 0.65,
          buttonStyle: NeumorphicStyle(depth: 4)),
      child: GetMaterialApp(
        title: "Application",
        translationsKeys: AppTranslation.translations,
        locale: Locale(languageModel.languageCode, languageModel.countryCode),
        supportedLocales: AppConstants.languages.keys.map((e) => Locale(
            AppConstants.languages[e]!.languageCode,
            AppConstants.languages[e]!.countryCode)),
        fallbackLocale: Locale(languageModel.languageCode, languageModel.countryCode),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }
}
