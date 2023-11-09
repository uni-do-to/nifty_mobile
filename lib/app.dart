import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
          lightSource: LightSource.topLeft,
          accentColor: NeumorphicColors.accent,
          variantColor: NeumorphicColors.variant,
          defaultTextColor: NeumorphicColors.defaultTextColor,
          appBarTheme: NeumorphicAppBarThemeData(
            buttonStyle: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()  , depth: 2 ),
            textStyle: TextStyle(color: Colors.black54 , fontSize: 24 ),
            iconTheme: IconThemeData(color: Colors.black54, size: 24 ),
          ),
          textTheme: TextTheme(
            labelLarge: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black54 ,
              letterSpacing: 1.5
            ),
            bodySmall: TextStyle(
                color: Colors.black54 ,
            )
          ),
          depth: 4,
          intensity: 0.9,
          buttonStyle: NeumorphicStyle(depth: 4 , intensity: 0.9)
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
