import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
          lightSource: LightSource.topLeft,
          accentColor: Color(0xFF3E3E3E),
          baseColor: Color(0xffF9F8F8),
          variantColor: NeumorphicColors.variant,
          defaultTextColor: Color(0xff274c5b),
          borderColor: Color(0xffD4D4D4),
          appBarTheme: const NeumorphicAppBarThemeData(
            buttonStyle: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(), depth: 2),
            textStyle: TextStyle(color: Color(0xff274c5b), fontSize: 24),
            iconTheme: IconThemeData(color: Color(0xff274c5b), size: 24),
          ),
          textTheme: GoogleFonts.robotoTextTheme().copyWith(
            labelLarge: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xff274c5b),
              letterSpacing: 1.2,
              fontSize: 45.toFont,
            ),
            bodySmall: TextStyle(
              color: Color(0xff274c5b),
              fontWeight: FontWeight.w400,
              fontSize: 24.toFont,
            ),
            bodyMedium: TextStyle(
              color: Color(0xff274c5b),
              fontWeight: FontWeight.w400,
              fontSize: 35.toFont,
            ),
            titleMedium: TextStyle(
              color: Color(0xff274c5b),
              fontWeight: FontWeight.w400,
              fontSize: 16.toFont,
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
        locale: const Locale('fr', 'FR'),
        fallbackLocale: const Locale('fr', 'FR'),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
