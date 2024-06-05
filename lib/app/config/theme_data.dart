import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nifty_mobile/app/config/size_constants.dart';

import 'color_constants.dart';

class ThemeConfig {

  static BoxShadow topShadow = BoxShadow(
    color: ColorConstants.shadowColor,
    blurRadius: SizeConstants.shadowBlurRadius,
    offset: SizeConstants.shadowTopOffset,
  ) ;

  static const mainTabsCornerRadius = BorderRadius.only(
  topRight: Radius.circular(10),
  topLeft: Radius.circular(10),
  );

  static BoxShadow mainTabsShadow = BoxShadow(
    color: ColorConstants.shadowColor.withOpacity(0.6),
    blurRadius: 8.0,
    offset: Offset(0.0, 3.0),
  );

  static BoxShadow secondaryTabShadow = BoxShadow(
    color: Color(0xffDDDDDD),
    blurRadius: SizeConstants.shadowBlurRadius,
    offset: Offset(3.0, 3.0),
  );

  static const secondaryTabsAddCornerRadius = BorderRadius.only(
    bottomLeft: Radius.circular(5),
    topLeft: Radius.circular(5),
  );

}
