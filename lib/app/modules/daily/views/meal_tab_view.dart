import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/daily/controllers/daily_controller.dart';
import 'package:nifty_mobile/app/widgets/daily_list_item.dart';
import 'package:nifty_mobile/app/widgets/secondary_tab_bar.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';

import '../../../config/color_constants.dart';

class MealTabView extends HookWidget {
  final NeumorphicThemeData theme;
  final RxList<String> mealsList;
  final DailyController controller = Get.find();

  MealTabView({Key? key, required this.mealsList, required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: mealsList.length,
      child: Container(
        padding: EdgeInsets.only(left: 18, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TabView
            ObxValue((state) {
              return SecondaryTabBar(
                onAddPressed: ()=>{},
                tabs: [
                  ...mealsList
                      .mapIndexed(
                        (index, element) => ObxValue((state) {
                          return SecondaryTab(
                            title: 'Repas n°$index',
                            isSelected: state.value == index,
                            icon: state.value == index ? SvgPicture.asset(
                              'assets/images/meal_icon.svg',
                              width: 23,
                              height: 20,
                              color: ColorConstants.secondaryTabBarTextColor,) : null,
                          );
                        }, controller.selectedMealTabIndex),
                      )
                      .toList(),
                ],
              );
            }, mealsList),
            //navigation button to create ingredient/ recipe
            SizedBox(
              height: 9,
            ),
            Row(
              children: [
                Container(
                  height: 46,
                  clipBehavior: Clip.none,
                  child: SmallActionButton(
                    text: 'Ajouter un nouvel élément ',
                    backgroundColor: ColorConstants.secondaryTabBarTextColor,
                    textColor: Colors.white,
                    fontSize: 16,

                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            SizedBox(height: 15,),
            Expanded(
              child: Container(
                color: ColorConstants.grayBackgroundColor,
                padding: EdgeInsets.only(right: 16),
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),

                  children: [

                    ...mealsList
                        .mapIndexed(
                          (index, element) {

                            return ListView.separated(
                                itemCount: mealsList.length*2,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 4,);
                                },
                                padding: EdgeInsets.only(right: 20),
                                itemBuilder: (context, index) {
                                  return DailyListItem(
                                    name: 'Steak tartare',
                                    calories: RichText(
                                      text: TextSpan(
                                        style: theme.textTheme.titleMedium,
                                        children: const [
                                          TextSpan(text: '150'),
                                          TextSpan(text: ' kCal', style: TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    action: InkWell(
                                      onTap: ()=>{},
                                      enableFeedback: true,
                                      child: Icon(
                                        Icons.delete,
                                        color: ColorConstants.accentColor.withOpacity(0.3),
                                      ),
                                    ),
                                  );
                                });
                          },
                        )
                        .toList(),
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
