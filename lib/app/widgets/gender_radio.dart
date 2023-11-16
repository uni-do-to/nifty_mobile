import 'package:flutter_neumorphic/flutter_neumorphic.dart'; // Assuming the Neumorphic package is being used
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

    return NeumorphicRadio(
      groupValue: groupValue,
      // padding: EdgeInsets.symmetric( vertical: 36.toHeight),
      style: NeumorphicRadioStyle(
        // boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(16))),
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        selectedColor: Colors.transparent,
        unselectedColor: Colors.transparent,
        border: NeumorphicBorder(
          width: 0.5,
        ),
      ),
      value: value,
      onChanged: onChanged,
      child: SizedBox(
        width: 240.toWidth,
        height: 150.toHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50.toFont,
            ),
            Text(
              label,
              style: theme?.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
