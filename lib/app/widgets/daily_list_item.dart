import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class DailyListItem extends StatelessWidget {
  final String name;
  final Widget calories;
  final Widget? action ;

  const DailyListItem(
      {Key? key, required this.name, required this.calories, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    return Container(
        height: 47,
        padding:
            const EdgeInsets.only(left: 27 , right: 13),
        decoration: BoxDecoration(
          color: ColorConstants.accentColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                name,
                style: theme?.textTheme.titleMedium,
              ),
            ),
            calories,
            SizedBox(width: 21,),
            if(action != null) action!,
          ],
        ));
  }
}
