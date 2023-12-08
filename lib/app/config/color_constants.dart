import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color accentColor = const Color(0xff274c5b);
  static Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = hexToColor('#5E92F3');
  static Color secondaryDarkAppColor = Colors.white;
  static Color targetBMiColor = hexToColor('#7EB693');
  static Color lightGray = hexToColor('#D4D4D4');
  static Color lightGray2 = hexToColor('#E4E4E4');
  static Color lightGray3 = hexToColor('#e8ebef');
  static Color darkGray = hexToColor('#6a6f75');
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color selectedTabColor = hexToColor('#7EB693');
  static Color toolbarTextColor = const Color(0xff707070);
  static Color shadowColor = const Color(0xff000000).withOpacity(0.09) ;
  static Color grayBackgroundColor = const Color(0xffF9F8F8) ;
  static Color mainThemeColor = const Color(0xff42A4A0) ;

  static Color secondaryTabBarContainerColor = Color(0xffDEEBEB);
  static Color secondaryTabBarTextColor = Color(0xff42A4A0);
}
