import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/utils/extensions.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class BudgetChart extends StatelessWidget {
  final double dailyBudget;
  final double sportBudget;
  final double consumedBudget;
  final double viewHeight ;

  final boxDecoration =  BoxDecoration(
  borderRadius: BorderRadius.circular(7.0)
  ) ;

  BudgetChart({
    Key? key,
    required this.dailyBudget,
    required this.sportBudget,
    required this.consumedBudget,
    this.viewHeight = 151.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print(dailyBudget) ;
    print(sportBudget) ;
    print(consumedBudget) ;
    print("-------------------------------") ;

    var theme = NeumorphicTheme.of(context)?.current;

    // Calculate percentages
    final double vegetablesPercent = 5 ;
    final double vegetablesBudget = dailyBudget * vegetablesPercent / 100 ;
    final fullBudget = dailyBudget + vegetablesBudget + sportBudget ;
    final double sportPercent = (sportBudget / fullBudget) * 100;
    final double consumedPercent = ((consumedBudget + vegetablesBudget) / fullBudget) * 100;
    final double overBudgetPercent = (consumedPercent + vegetablesPercent) - 100 ;

    // Calculate box heights
    final double consumedHeight = viewHeight * (consumedPercent) / 100;
    final double sportHeight = viewHeight * sportPercent / 100;
    final double? overBudgetHeight = overBudgetPercent > 0 ? viewHeight * overBudgetPercent / 100 : null ;

    final double vegetablesHeight = viewHeight * vegetablesPercent /100;

    print(vegetablesPercent) ;
    print(vegetablesBudget) ;
    print(fullBudget) ;
    print(sportPercent) ;
    print(consumedPercent) ;
    print(overBudgetPercent) ;


    print("-------------------------------") ;


    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            // Daily budget box
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: viewHeight,
                width: 171,
                clipBehavior: Clip.hardEdge,

                decoration: boxDecoration.copyWith(
                    border: Border.all(
                        color: ColorConstants.lightGreen,
                        width: 1
                    )
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: viewHeight,
                        width: 171,
                        decoration: boxDecoration.copyWith(
                          color: ColorConstants.lightGreen.withOpacity(0.1),
                        ),
                      ),
                    ),
                    //consumed calaroies
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 171,
                        height: consumedHeight,
                        decoration: boxDecoration.copyWith(
                          color: ColorConstants.mainThemeColor.withOpacity(0.32),
                        ),
                      ),
                    ),
                    //vigatables 5%
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 171,
                        height: vegetablesHeight,
                        decoration: boxDecoration.copyWith(
                          color: ColorConstants.mainThemeColor.withOpacity(0.50),
                        ),
                      ),
                    ),

                    //sport
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 171,
                        height: sportHeight,
                        decoration: boxDecoration.copyWith(
                          color: Color(0xffEDCD67).withOpacity(0.20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if(overBudgetHeight != null)
              Positioned(
                bottom: viewHeight + 2.5,
                width: 171,
                left: 0,
                child: Container(
                  height: 3,
                  color: ColorConstants.accentColor,
                ),
              ),

            // Over budget box
            if(overBudgetHeight != null)
            Positioned(
              bottom: viewHeight + 8,
              left: 0,
              child: Container(
                width: 171,
                decoration: boxDecoration.copyWith(
                  color: Color(0xffEBC5C4),
                  border: Border.all(
                    color: Color(0xff9D0600),
                    width: 1,
                  )
                ),
                height: overBudgetHeight,
              ),
            ),


            //vegetables indicator
            Positioned(
              bottom: vegetablesHeight,
              left: 171,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 141,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.vegetables_chart_label.tr,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: theme?.textTheme.bodySmall?.copyWith(
                            fontSize: 13 , color: ColorConstants.accentColor.withOpacity(0.5)),
                      ),
                      Text(
                        "5%",
                        style: theme?.textTheme.bodySmall?.copyWith(fontSize: 20 ,fontWeight: FontWeight.w900, color: ColorConstants.accentColor.withOpacity(0.5)),
                      )
                    ],
                  )
                ],
              ),
            ),

            //Consumed calories
            if(overBudgetHeight == null)
              Positioned(
              bottom: max( 0 , consumedHeight -10),
              left: 170,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_left,
                    size: 26,
                    color: ColorConstants.accentColor,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.remaining_budget_label.tr,
                        style: theme?.textTheme.bodySmall?.copyWith(fontSize: 13 , color: ColorConstants.accentColor),
                      ),
                      Text(
                        (consumedBudget + vegetablesBudget).displayUnit,
                        style: theme?.textTheme.bodySmall?.copyWith(fontSize: 24 ,fontWeight: FontWeight.w900, color: ColorConstants.accentColor),
                      )
                    ],
                  )
                ],
              ),
            )
            else
              Positioned(
                bottom: viewHeight+4,
                left: 170,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_left,
                      size: 26,
                      color: Color(0xff9D0600),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.remaining_budget_label.tr,
                          style: theme?.textTheme.bodySmall?.copyWith(fontSize: 13 , color: Color(0xff9D0600)),
                        ),
                        Text(
                          (consumedBudget + vegetablesBudget).displayUnit,
                          style: theme?.textTheme.bodySmall?.copyWith(fontSize: 24 ,fontWeight: FontWeight.w900, color: Color(0xff9D0600)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            //limit indicator
            Positioned(
              bottom: viewHeight + 4,
              left: 181,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 131,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.nifty_points_budget_label.tr,
                        style: theme?.textTheme.bodySmall?.copyWith(fontSize: 14 , color: ColorConstants.mainThemeColor),
                      ),
                      Text(
                        fullBudget.displayUnit,
                        style: theme?.textTheme.bodySmall?.copyWith(fontSize: 24 ,fontWeight: FontWeight.w900, color: ColorConstants.mainThemeColor),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}