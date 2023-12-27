import 'package:flutter_neumorphic/flutter_neumorphic.dart'; // Assuming the Neumorphic package is being used
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class GenderRadio extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const GenderRadio({
    Key? key,
    required this.label,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    print("GroupValue: $groupValue");
    print("value: $value");
    return NeumorphicRadio(
      groupValue: groupValue,
      // padding: EdgeInsets.symmetric( vertical: 36.toHeight),
      style: NeumorphicRadioStyle(
        // boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(16))),
        unselectedDepth: NeumorphicTheme.embossDepth(context),
        selectedDepth: NeumorphicTheme.embossDepth(context),
        intensity: 1,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(17)),
        selectedColor: ColorConstants.mainThemeColor.withOpacity(0.4),
        unselectedColor: Colors.white,
        border: NeumorphicBorder(
          width: 0.5,
        ),
      ),
      value: value,
      onChanged: onChanged,
      child: SizedBox(
        width: 136,
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              label,
              style: theme?.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
