import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/color_constants.dart';

class TabBarChild extends StatelessWidget {
  final String label;
  final bool isSelected;
  final NeumorphicThemeData theme;
  final VoidCallback onTap;

  TabBarChild(
      {Key? key,
      required this.label,
      this.isSelected = false,
      required this.theme,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: isSelected ? -1.5 : 1.5,
          intensity: 0.8,
        ),
        margin: const EdgeInsets.only(right: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isSelected
                  ? ColorConstants.lightGreen
                  : theme.accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
