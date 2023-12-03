import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class RecipeListItem extends StatelessWidget {
  final String text;

  const RecipeListItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(depth: 1.2, intensity: 1),
      padding:
      EdgeInsets.symmetric(horizontal: 50.toWidth, vertical: 30.toHeight),
      child: Row(
        children: [
          Icon(
            Icons.restaurant_menu_rounded,
            color: NeumorphicTheme.of(context)?.current?.iconTheme.color,
            size: 30.toWidth,
          ),
          SizedBox(
            width: 20.toWidth,
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
            size: 30.toWidth,
          ),
        ],
      ),
    );
  }
}
