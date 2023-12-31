import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SmallActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final Widget? icon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;

  const SmallActionButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width, // Defaults to expand to the available width
    this.height = 32.0, // Default height of the button
    this.icon,
    this.prefixIcon,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
          color: backgroundColor,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(4))),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) prefixIcon!,
            if (prefixIcon != null)
              const SizedBox(
                width: 3,
              ),
            Text(
              text,
              style: NeumorphicTheme.of(context)
                  ?.current
                  ?.textTheme
                  .titleMedium
                  ?.copyWith(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w900),
            ),
            if (icon != null)
              const SizedBox(
                width: 5,
              ),
            if (icon != null) icon!
          ],
        ),
      ),
    );
  }
}
