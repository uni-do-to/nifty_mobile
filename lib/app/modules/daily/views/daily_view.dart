import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/config/size_constants.dart';
import 'package:nifty_mobile/app/config/theme_data.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/modules/daily/views/chart_view.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/extentions.dart';
import 'package:nifty_mobile/app/widgets/custom_tab_list_view.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/main_tab_bar.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../widgets/daily_list_item.dart';
import '../../../widgets/secondary_tab_bar.dart';
import '../controllers/daily_controller.dart';

class DailyView extends GetView<DailyController> {
  const DailyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: SizeConstants.toolBarPadding,
          child:
              Text(LocaleKeys.daily_bottom_navigation_label.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge
            ?.copyWith(color: ColorConstants.toolbarTextColor),
        toolbarHeight: 40,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 228,
              clipBehavior: Clip.none,
              color: ColorConstants.grayBackgroundColor,
              padding:
                  EdgeInsets.only(top: 7.5, bottom: 7.5, left: 20, right: 20),
              child: ObxValue((state) {
                var daily = state.value?.attributes;
                return BudgetChart(
                  dailyBudget: daily?.dailyCalories ?? 1,
                  // Your total budget here
                  sportBudget: daily?.calorieBurned ?? 1,
                  // The amount spent here
                  consumedBudget: daily?.consumedCalories ?? 1,
                );
              }, controller.daily),
            ),
            Container(
              height: 51,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [ThemeConfig.topShadow],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => {controller.getPreviousDay()},
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: theme?.iconTheme.color,
                      size: SizeConstants.backIconSize,
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  ObxValue((state) {
                    return Text(
                      state.value.toUpperCase(),
                      style: theme?.textTheme.titleLarge,
                    );
                  }, controller.day),
                  const SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                    onTap: () => {controller.getNextDay()},
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: theme?.iconTheme.color,
                      size: SizeConstants.backIconSize,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainTabBar(
                      tabs: [
                        MainTab(
                          child: Text(
                            LocaleKeys.your_meals_label.tr,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        MainTab(
                          child: Text(
                            LocaleKeys.sport_budget_label.tr,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.grayBackgroundColor,
                        ),
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            ObxValue((state) {
                              return CustomTabListView(
                                tabCount: state.length,
                                addNewTitle:
                                    LocaleKeys.add_meal_item_button_label.tr,
                                selectedTabIndex:
                                    controller.selectedMealTabIndex.value,
                                getTapItemCount: (tabIndex) {
                                  return controller
                                          .meals[tabIndex].items?.length ??
                                      0;
                                },
                                onAddTabPressed: () {
                                  controller.addMeal();
                                },
                                onTapChanged: (index) {
                                  controller.selectedMealTabIndex.value = index;
                                },
                                onAddNewItem: () async {
                                  var currentMeal =
                                      controller.getSelectedMeal();
                                  if (currentMeal != null) {
                                    var results = await Get.toNamed(
                                        Routes.ADD_TO_MEAL,
                                        arguments: currentMeal);
                                    if (results != null &&
                                        results is MealItem) {
                                      controller.addToMeal(results);
                                    }
                                  }
                                },
                                tabBuilder: (index) {
                                  return ObxValue((state) {
                                    return SecondaryTab(
                                      title:
                                          '${LocaleKeys.meal_tab_number_label.tr}${index + 1}',
                                      isSelected: state.value == index,
                                      icon: state.value == index
                                          ? SvgPicture.asset(
                                              'assets/images/meal_icon.svg',
                                              width: 23,
                                              height: 20,
                                              color: ColorConstants
                                                  .secondaryTabBarTextColor,
                                            )
                                          : null,
                                    );
                                  }, controller.selectedMealTabIndex);
                                },
                                listItemBuilder: (BuildContext context,
                                    int tabIndex, int itemIndex) {
                                  var item = state[tabIndex].items?[itemIndex];
                                  return DailyListItem(
                                    name: item?.getName() ?? "No name",
                                    calories: RichText(
                                      text: TextSpan(
                                        style: theme?.textTheme.titleMedium,
                                        children: [
                                          TextSpan(
                                              text: (item?.calories?.displayUnit
                                                      .toString() ??
                                                  "")),
                                          TextSpan(
                                              text: " ${displayUnit}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    action: InkWell(
                                      onTap: () => {
                                        controller.deleteItemFromMeal(
                                            tabIndex, itemIndex)
                                      },
                                      enableFeedback: true,
                                      child: Icon(
                                        Icons.delete,
                                        color: ColorConstants.accentColor
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }, controller.meals),
                            ObxValue((state) {
                              return CustomTabListView(
                                tabCount: state.length,
                                addNewTitle:
                                    LocaleKeys.add_meal_item_button_label.tr,
                                selectedTabIndex:
                                    controller.selectedSportTabIndex.value,
                                getTapItemCount: (tabIndex) {
                                  return controller
                                          .sports[tabIndex].items?.length ??
                                      0;
                                },
                                onAddTabPressed: () {
                                  controller.addSport();
                                },
                                onTapChanged: (index) {
                                  controller.selectedSportTabIndex.value =
                                      index;
                                },
                                onAddNewItem: () async {
                                  var currentSport =
                                      controller.getSelectedSport();
                                  if (currentSport != null) {
                                    var results = await Get.toNamed(
                                        Routes.ADD_SPORT,
                                        arguments: currentSport);

                                    if (results != null &&
                                        results is SportItem) {
                                      controller.addToSport(results);
                                    }
                                  }
                                },
                                tabBuilder: (index) {
                                  return ObxValue((state) {
                                    return SecondaryTab(
                                      title:
                                          '${LocaleKeys.sport_tab_number_label.tr}${index + 1}',
                                      isSelected: state.value == index,
                                      icon: state.value == index
                                          ? Icon(Icons.fitness_center_sharp,
                                              size: 23,
                                              color: ColorConstants
                                                  .secondaryTabBarTextColor)
                                          : null,
                                    );
                                  }, controller.selectedSportTabIndex);
                                },
                                listItemBuilder: (BuildContext context,
                                    int tabIndex, int itemIndex) {
                                  var item = state[tabIndex].items?[itemIndex];
                                  return DailyListItem(
                                    name: item?.getName() ?? "No name",
                                    calories: RichText(
                                      text: TextSpan(
                                        style: theme?.textTheme.titleMedium,
                                        children: [
                                          TextSpan(
                                              text: (item
                                                      ?.calories?.displayUnit ??
                                                  "")),
                                          TextSpan(
                                              text: " ${displayUnit}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    action: InkWell(
                                      onTap: () => {
                                        controller.deleteItemFromSport(
                                            tabIndex, itemIndex)
                                      },
                                      enableFeedback: true,
                                      child: Icon(
                                        Icons.delete,
                                        color: ColorConstants.accentColor
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }, controller.sports),
                          ],
                        ),
                      ),
                    ),
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
