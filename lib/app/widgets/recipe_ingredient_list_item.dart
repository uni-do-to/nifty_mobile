import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class RecipeIngredientListItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const RecipeIngredientListItem(
      {Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(depth: 1.2, intensity: 1),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: NeumorphicTheme.of(context)?.current?.iconTheme.color,
            size: 20,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: NeumorphicTheme.of(context)
                ?.current
                ?.textTheme
                .bodySmall
                ?.copyWith(
                  fontSize: 16,
                ),
          ),
          Expanded(child: Container()),
          GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.delete,
              color: NeumorphicTheme.of(context)?.current?.iconTheme.color,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }
}