import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class CustomTab extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CustomTab({Key? key, required this.title, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return Tab(
        child: isSelected
            ? Container(
                padding: EdgeInsets.symmetric(
                    vertical: 10.toHeight, horizontal: 20.toWidth),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffDDDDDD),
                      blurRadius: 6.0,
                      offset: Offset(3.0, 3.0), // changes position of shadow
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/meal_icon.svg',
                      width: 23,
                      height: 20,
                      color: Color(0xff42a4a0),
                    ),
                    SizedBox(
                      width: 10.toWidth,
                    ),
                    Text(
                      title,
                      style: theme?.textTheme.bodySmall?.copyWith(
                        color: Color(0xff42A4A0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(
                    vertical: 10.toHeight, horizontal: 20.toWidth),
                decoration: BoxDecoration(
                  color: Color(0xffDEEBEB),
                  border: Border.all(
                    color: Color(0xff42A4A0),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: theme?.textTheme.bodySmall?.copyWith(
                    color: Color(0xff42A4A0),
                  ),
                ),
              ));
  }
}
