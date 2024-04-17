import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IconRenderer extends charts.CustomSymbolRenderer {
  final IconData iconData;

  IconRenderer(this.iconData);

  @override
  Widget build(BuildContext context,
      {Size? size, Color? color, bool enabled = true}) {
    // Lighten the color if the symbol is not enabled
    // Example: If user has tapped on a Series deselecting it.
    if (color != null && !enabled) {
      color = color.withOpacity(0.26);
    }

    return new SizedBox.fromSize(
        size: size, child: new Icon(iconData, color: Colors.black, size: 12.0));
  }
}


class LocalizedDateTimeFactory extends charts.LocalDateTimeFactory {
  final Locale locale;

  @override
  DateFormat createDateFormat(String? pattern) {
    return DateFormat(pattern, locale.languageCode);
  }

  LocalizedDateTimeFactory(this.locale);
}