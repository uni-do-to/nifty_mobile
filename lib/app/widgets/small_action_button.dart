import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SmallActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;

  const SmallActionButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width , // Defaults to expand to the available width
    this.height = 32.0, // Default height of the button
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Text(
          text,
          style: NeumorphicTheme.of(context)?.current?.textTheme.labelLarge
        ),
      ),
    );
  }
}