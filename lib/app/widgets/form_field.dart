import 'package:flutter/src/services/text_formatter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class NeuFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
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
  final bool maintainErrorSize  ;
  // final String? initialValue ;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged ;

  NeuFormField({
    required this.hintText,
    this.controller,
    // this.initialValue,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.onTap,
    this.errorText, // Initialize in constructor
    this.maintainErrorSize = true,
    this.readOnly = false,
    this.autocorrect = false,
    this.obscureText = false,
    this.inputFormatters,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle:
                  NeumorphicTheme.of(context)?.current?.textTheme.titleMedium?.copyWith(color: ColorConstants.lightGray),
              filled: true,
              isDense: true,
              fillColor: Colors.transparent,
              // contentPadding: EdgeInsets.symmetric(vertical: 15.toHeight),
              prefixIcon: prefixIcon,
              prefixIconColor: NeumorphicTheme.accentColor(context),
              // prefixIconConstraints: BoxConstraints(
              //   minWidth: 35,
              // ),
              suffixIcon: suffixIcon,
              // suffixIconConstraints: BoxConstraints(
              //   minHeight: 50.toHeight,
              //   minWidth: 50.toWidth,
              // ),
            ),
            textAlignVertical: TextAlignVertical.center,
            style: NeumorphicTheme.of(context)?.current?.textTheme.titleMedium,
            focusNode: focusNode,
            readOnly: readOnly,
            onTap: onTap,
            obscureText: obscureText,
            controller: controller,
            keyboardType: keyboardType,
            autocorrect: autocorrect,
            validator: validator,
            inputFormatters: inputFormatters,
          ),
        ),
        Visibility(
          visible: errorText != null && errorText!.isNotEmpty,
          maintainSize: maintainErrorSize,
          maintainAnimation: maintainErrorSize,
          maintainState: maintainErrorSize,
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
