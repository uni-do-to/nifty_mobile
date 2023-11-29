import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

import '../../../config/color_constants.dart';

class TabBarViewChild extends StatelessWidget {
  final String label;
  final bool isSelected;
  final NeumorphicThemeData theme;

  TabBarViewChild(
      {Key? key,
      required this.label,
      this.isSelected = false,
      required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        depth: -1.5,
        intensity: 0.8,
      ),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(25),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.accentColor,
          height: 1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
