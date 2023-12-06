import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/modules/daily/controllers/daily_controller.dart';
import 'package:nifty_mobile/app/modules/daily/views/custom_tab_view.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/daily_list_item.dart';

import 'package:nifty_mobile/app/widgets/small_action_button.dart';

class SportTabView extends HookWidget {
  final NeumorphicThemeData theme;
  final RxList<String> sportsList;
  final DailyController controller = Get.find();

  SportTabView({Key? key, required this.sportsList, required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sportsTabController = useTabController(
      initialLength: sportsList.length + 1,
    );
    sportsTabController.addListener(() {
      if (sportsTabController.index == sportsList.length) {
        //do add
        sportsList.add("sport tab");
        sportsTabController.index = controller.selectedMealTabIndex.value;
      } else {
        controller.selectedMealTabIndex.value = sportsTabController.index;
      }
    });

    return DefaultTabController(
      length: sportsList.length,
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
                controller: sportsTabController,
                tabs: [
                  ...sportsList
                      .mapIndexed(
                        (index, element) => ObxValue((state) {
                          return CustomTab(
                            title: 'Sport n°$index',
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
            }, sportsList),
            //navigation button to create ingredient/ recipe
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.toWidth),
                  child: SmallActionButton(
                    text: 'Ajouter un nouvel élément ',
                    backgroundColor: Color(0xff42A4A0),
                    textColor: Colors.white,
                    fontSize: 24.toFont,
                    height: 35.toHeight,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
            Expanded(
              child: Container(
                color: ColorConstants.grayBackgroundColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 15.toWidth,
                  vertical: 10.toHeight,
                ),
                child: TabBarView(
                  controller: sportsTabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ...sportsList
                        .mapIndexed(
                          (index, element) => Container(
                            child: Column(
                              children: [
                                ...sportsList.mapIndexed(
                                  (index, element) => Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.toHeight,
                                    ),
                                    child: DailyListItem(
                                        text: 'Activité physique intensive',
                                        calories: 190,
                                        type: 'sport'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    Container(),
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
