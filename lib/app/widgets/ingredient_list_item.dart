import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class IngredientListItem extends StatelessWidget {
  final String text;

  const IngredientListItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(depth: 1.2, intensity: 1),
      padding:
          EdgeInsets.symmetric(horizontal: 30, vertical: 18),
      child: Row(
        children: [
          Icon(
            Icons.egg,
            color: NeumorphicTheme.of(context)?.current?.iconTheme.color,
            size: 18,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            text,
            style: NeumorphicTheme.of(context)
                ?.current
                ?.textTheme
                .bodySmall,
          ),
          Expanded(child: Container()),
          Icon(
            Icons.check_circle,
            color: NeumorphicTheme.of(context)?.current?.iconTheme.color,
            size: 18,
          ),
        ],
      ),
    );
  }
}
