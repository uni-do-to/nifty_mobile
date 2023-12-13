import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_scaled_box.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

class ScaleWidget extends StatelessWidget {
  final TransitionBuilder builder;
  final Widget child;

  const ScaleWidget({required this.builder, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}


scaleWidgetBuilder(BuildContext context,Widget child , {bool withBouncingScroll = true}) {
  return MaxWidthBox(
    maxWidth: 450,
    background: Container(color: const Color(0xFFF5F5F5)),
    child: ResponsiveScaledBox(

        width: ResponsiveValue<double>(context, conditionalValues: [
          Condition.equals(name: MOBILE, value: 430),
          // Condition.between(start: 800, end: 1100, value: 800),
          // Condition.between(start: 1000, end: 1200, value: 1000),

        ]).value,
        child: withBouncingScroll
            ? BouncingScrollWrapper.builder(context, child, dragWithMouse: true)
            : child),
  );
}