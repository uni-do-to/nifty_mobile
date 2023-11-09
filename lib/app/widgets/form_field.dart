import 'dart:html';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final EdgeInsets padding;
  final bool autocorrect;
  final bool obscureText;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText; // Add an errorText property

  const NeuFormField({
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.errorText, // Initialize in constructor
    this.readOnly = false,
    this.autocorrect = false,
    this.obscureText = false,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Align the text to the start of the column
      children: [
        Neumorphic(
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: NeumorphicBoxShape.stadium(),
          ),
          padding: padding,
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              filled: true,
              isDense: true,
              fillColor: Colors.transparent,
              prefixIcon: prefixIcon,
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 16,
                minWidth: 24,
              ),
              suffixIcon: suffixIcon,
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 16,
                minWidth: 24,
              ),
            ),
            readOnly: readOnly,
            onTap: onTap,
            obscureText: obscureText,
            controller: controller,
            keyboardType: keyboardType,
            autocorrect: autocorrect,
            validator: validator,
          ),
        ),
          Visibility(
            visible: errorText != null &&
                errorText!
                    .isNotEmpty,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 14),
              // Adjust the padding as needed
              child: Text(
                errorText ?? "",
                style: NeumorphicTheme.of(context)?.current?.textTheme.bodySmall?.copyWith(color: Colors.red),
              ),
            ),
          ),
      ],
    );
  }
}
