import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../utils/size_utils.dart';

class RegisterViewsTitle extends StatelessWidget {
  final String text;

  const RegisterViewsTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: NeumorphicTheme.of(context)?.current?.textTheme.labelLarge,
      textAlign: TextAlign.center,
    );
  }
}
