import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SelectableCard extends StatelessWidget {
  final Widget content;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableCard({
    Key? key,
    required this.content,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Neumorphic(
        style: NeumorphicStyle(
          color: isSelected ? Colors.blue : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: content,
        ),
      ),
    );
  }
}
