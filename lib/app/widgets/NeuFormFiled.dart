import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuFormFiled extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final EdgeInsets padding ;
  final bool autocorrect ;
  final bool obscureText ;
  final bool readOnly ;
  final GestureTapCallback? onTap ;
  final Widget? prefixIcon ;
  final Widget? suffixIcon ;

  const NeuFormFiled({
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.autocorrect = false,
    this.obscureText = false,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
    Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: NeumorphicTheme.embossDepth(context),
        boxShape: NeumorphicBoxShape.stadium(),
      ),
      padding: padding,
      child: TextFormField(
        decoration: InputDecoration(
          // labelText: 'Email address',
          border: InputBorder.none,
          hintText: hintText,
          filled: true,
          isDense: true,
          fillColor: Colors.transparent,
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
              maxHeight: 16,
            minWidth: 24
          ),
          suffixIcon: suffixIcon,
          suffixIconConstraints: const BoxConstraints(
              maxHeight: 16,
              minWidth: 24
          ),
          // isCollapsed: true,
        ),
        readOnly: readOnly,
        onTap: onTap,
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        autocorrect: autocorrect,
        validator: validator,
      ),
    );

  }
}
