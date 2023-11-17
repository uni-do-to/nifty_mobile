import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class NeuCard extends StatelessWidget {
  final Widget? child;

  const NeuCard({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(8),
        ),
        depth: 1,
        intensity: 1,
        color: theme?.baseColor,
        border: NeumorphicBorder(color: theme?.borderColor, width: 1),
      ),
      child: child,
    );
  }
}
