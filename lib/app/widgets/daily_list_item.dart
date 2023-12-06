import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class DailyListItem extends StatelessWidget {
  final String text;
  final int calories;
  final String type;

  const DailyListItem(
      {Key? key,
      required this.text,
      required this.calories,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    return Container(
        height: 70.toHeight,
        padding:
            EdgeInsets.symmetric(vertical: 10.toHeight, horizontal: 10.toWidth),
        decoration: BoxDecoration(
          color: Color(0xff274C5B).withOpacity(0.1),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          children: [
            type == 'ingredient'
                ? Icon(
                    Icons.egg,
                    color: theme?.iconTheme.color,
                    size: 18,
                  )
                : Icon(
                    Icons.menu_book_rounded,
                    color: theme?.iconTheme.color,
                    size: 18,
                  ),
            SizedBox(
              width: 15.toWidth,
            ),
            Expanded(
              child: Text(
                text,
                style: theme?.textTheme.bodySmall,
              ),
            ),
            Text(
              calories.toString(),
              style: theme?.textTheme.bodySmall,
            ),
            SizedBox(
              width: 5.toWidth,
            ),
            Text(
              "Kcal",
              style: theme?.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              width: 10.toWidth,
            ),
            Icon(
              Icons.delete,
              color: theme?.iconTheme.color,
              size: 18,
            ),
          ],
        ));
  }
}
