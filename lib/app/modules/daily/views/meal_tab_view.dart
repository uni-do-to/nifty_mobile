import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/daily/controllers/daily_controller.dart';
import 'package:nifty_mobile/app/modules/daily/views/custom_tab_view.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'dart:collection';

import 'package:nifty_mobile/app/widgets/small_action_button.dart';

class MealTabView extends HookWidget {
  final NeumorphicThemeData theme;
  final RxList<String> mealsList;
  final DailyController controller = Get.find();

  MealTabView({Key? key, required this.mealsList, required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealsTabController = useTabController(
      initialLength: mealsList.length + 1,
    );
    mealsTabController.addListener(() {
      if (mealsTabController.index == mealsList.length) {
        //do add
        mealsList.add("new tab");
        mealsTabController.index = controller.selectedMealTabIndex.value;
      } else {
        controller.selectedMealTabIndex.value = mealsTabController.index;
      }
    });

    return DefaultTabController(
      length: mealsList.length,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TabView
            ObxValue((state) {
              return TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.only(right: 20.toWidth),
                labelPadding: EdgeInsets.only(
                  left: 15.toWidth,
                  top: 30.toHeight,
                  bottom: 10.toHeight,
                ),
                indicatorColor: Colors.transparent,
                controller: mealsTabController,
                tabs: [
                  ...mealsList
                      .mapIndexed(
                        (index, element) => ObxValue((state) {
                          return CustomTab(
                            title: 'Repas n°$index',
                            isSelected: state.value == index,
                          );
                        }, controller.selectedMealTabIndex),
                      )
                      .toList(),
                  Container(
                    width: 150.toWidth,
                    height: 90.toHeight,
                    padding: EdgeInsets.only(left: 20.toWidth),
                    decoration: BoxDecoration(
                      color: Color(0xffDEEBEB),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Color(0xff42A4A0),
                    ),
                  ),
                ],
              );
            }, mealsList),
            //navigation button to create ingredient/ recipe
            Row(
              children: [
                SmallActionButton(
                  text: 'Ajouter un nouvel élément ',
                  backgroundColor: Color(0xff42A4A0),
                  textColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF9F8F8),
                ),
                child: TabBarView(
                  controller: mealsTabController,
                  children: [
                    Icon(Icons.flight, size: 89),
                    Icon(Icons.directions_transit, size: 89),
                    Icon(Icons.directions_transit, size: 89),
                    Icon(Icons.directions_transit, size: 89),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
