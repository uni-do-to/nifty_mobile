import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
          lightSource: LightSource.topLeft,
          accentColor: Color(0xFF3E3E3E),
          variantColor: NeumorphicColors.variant,
          defaultTextColor: Color(0xff274c5b),
          appBarTheme: const NeumorphicAppBarThemeData(
            buttonStyle: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()  , depth: 2 ),
            textStyle: TextStyle(color: Color(0xff274c5b) , fontSize: 24 ),
            iconTheme: IconThemeData(color: Color(0xff274c5b), size: 24 ),
          ),
          textTheme: GoogleFonts.robotoTextTheme().copyWith(
            labelLarge: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xff274c5b) ,
              letterSpacing: 1.2,
            ),
            bodySmall: const TextStyle(
                color: Color(0xff274c5b) ,
              fontWeight: FontWeight.w400,
            ),
            titleMedium: const TextStyle(
              color: Color(0xff274c5b) ,
                fontWeight: FontWeight.w400,
                fontSize: 16.0
            ),
          ),
          depth: 4,
          intensity: 0.9,
          buttonStyle: const NeumorphicStyle(depth: 4 , intensity: 0.9 , )
      ),

      darkTheme: const NeumorphicThemeData(
          baseColor: Color(0xFF3E3E3E),
          lightSource: LightSource.topLeft,
          depth: 4,
          intensity: 0.65,
          buttonStyle: NeumorphicStyle(depth: 4)),

      child: GetMaterialApp(
        title: "Application",
        translationsKeys: AppTranslation.translations,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
