import 'dart:html';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

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
  final FocusNode? focusNode; // Add an errorText property

  const NeuFormField({
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
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
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
            color: Colors.transparent,
            border: NeumorphicBorder(
              width: 0.5,
            ),
          ),
          padding: padding,
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle:
                  NeumorphicTheme.of(context)?.current?.textTheme.bodySmall,
              filled: true,
              isDense: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(vertical: 15.toHeight),
              prefixIcon: prefixIcon,
              prefixIconColor: NeumorphicTheme.accentColor(context),
              prefixIconConstraints: BoxConstraints(
                minHeight: 50.toHeight,
                minWidth: 50.toWidth,
              ),
              suffixIcon: suffixIcon,
              suffixIconConstraints: BoxConstraints(
                minHeight: 50.toHeight,
                minWidth: 50.toWidth,
              ),
            ),
            style: NeumorphicTheme.of(context)?.current?.textTheme.bodyMedium,
            focusNode: focusNode,
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
          visible: errorText != null && errorText!.isNotEmpty,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 14),
            // Adjust the padding as needed
            child: Text(
              errorText ?? "",
              style: NeumorphicTheme.of(context)
                  ?.current
                  ?.textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
