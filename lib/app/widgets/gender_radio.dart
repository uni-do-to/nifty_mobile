import 'package:flutter_neumorphic/flutter_neumorphic.dart'; // Assuming the Neumorphic package is being used

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
    return NeumorphicRadio(
      groupValue: groupValue,
      padding: const EdgeInsets.all(20),
      style: NeumorphicRadioStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(16))),
      ),
      value: value,
      onChanged: onChanged,
      child: SizedBox(
        width: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon),
            Text(label),
          ],
        ),
      ),
    );
  }
}