import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/modules/home/views/tab_bar_child.dart';
import 'package:nifty_mobile/app/modules/home/views/tab_bar_view_child.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../utils/size_utils.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Text(
              LocaleKeys.daily_calories_home_title.tr,
              style: theme?.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.toHeight),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.nifty_points_budget_label.tr,
                      style: theme?.textTheme.bodySmall?.copyWith(
                          color: ColorConstants.darkGray,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.toHeight,
                    ),
                    Row(
                      children: [
                        Text(
                          '64',
                          style: theme?.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.black),
                        ),
                        SizedBox(
                          width: 5.toWidth,
                        ),
                        Text(
                          LocaleKeys.nifty_points_measurement.tr,
                          style: theme?.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.black),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.toWidth,
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/budget_indicator.png',
                      width: 290.toWidth,
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      width: 280.toWidth,
                      height: 280.toHeight,
                      decoration: BoxDecoration(
                        color: ColorConstants.lightGray3,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ColorConstants.lightGray2,
                          width: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.remaining_budget_label.tr,
                      style: theme?.textTheme.bodySmall?.copyWith(
                          color: Color(0xffA3B1C6),
                          fontWeight: FontWeight.bold,
                          height: 0),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/arrow_left.png',
                          width: 30.toWidth,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          width: 5.toWidth,
                        ),
                        Text(
                          '0',
                          style: theme?.textTheme.bodyMedium?.copyWith(
                            color: Color(0xffA3B1C6),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 3.toWidth,
                        ),
                        Text(
                          LocaleKeys.nifty_points_measurement.tr,
                          style: theme?.textTheme.bodyMedium?.copyWith(
                            color: Color(0xffA3B1C6),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 35.toHeight),
            Text(
              LocaleKeys.add_something_to_daily_label.tr,
              style: theme?.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25.toHeight),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNeumorphicButton(
                      context: context,
                      text: LocaleKeys.ingredient_tab_label.tr,
                      icon: Icon(
                        Icons.egg,
                        color: theme?.iconTheme.color,
                      ),
                      onPressed: () => Get.toNamed(Routes.ADD_INGREDIENT_MEAL)),
                  SizedBox(
                    width: 10.toWidth,
                  ),
                  _buildNeumorphicButton(
                      context: context,
                      text: LocaleKeys.recipe_tab_label.tr,
                      icon: Icon(
                        Icons.restaurant_menu_rounded,
                        color: theme?.iconTheme.color,
                      ),
                      onPressed: () => Get.toNamed(Routes.ADD_RECIPE_MEAL)),
                  SizedBox(
                    width: 10.toWidth,
                  ),
                  _buildNeumorphicButton(
                      context: context,
                      text: LocaleKeys.sport_budget_label.tr,
                      icon: Icon(
                        Icons.fitness_center_sharp,
                        color: theme?.iconTheme.color,
                      ),
                      onPressed: () => Get.toNamed(Routes.ADD_INGREDIENT_MEAL)),
                ],
              ),
            ),
            SizedBox(
              height: 30.toHeight,
            ),
            Text(
              LocaleKeys.your_meals_label.tr,
              style: theme?.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30.toHeight,
            ),
            DefaultTabController(
              length: controller.mealsList.isNotEmpty
                  ? controller.mealsList.length
                  : 2,
              child: Column(
                children: [
                  Container(
                    height: 100.toHeight,
                    child: ObxValue((state) {
                      return Row(
                        children: controller.mealsList.isNotEmpty
                            ? controller.mealsList
                                .map(
                                  (meal) => TabBarChild(
                                    label: meal,
                                    isSelected: controller.selectedMeal.value ==
                                        controller.mealsList.indexOf(meal),
                                    theme: theme!,
                                    onTap: () => controller.selectedMeal.value =
                                        controller.mealsList.indexOf(meal),
                                  ),
                                )
                                .toList()
                            : [
                                TabBarChild(
                                  label: LocaleKeys.meal_tab_number_label.tr,
                                  isSelected:
                                      controller.selectedMeal.value == 0,
                                  theme: theme!,
                                  onTap: () =>
                                      controller.selectedMeal.value = 0,
                                ),
                                TabBarChild(
                                  label: LocaleKeys.meal_tab_number_label.tr,
                                  isSelected:
                                      controller.selectedMeal.value == 1,
                                  theme: theme,
                                  onTap: () =>
                                      controller.selectedMeal.value = 1,
                                ),
                              ],
                      );
                    }, controller.selectedMeal),
                  ),
                  Container(
                    height: 200.toHeight,
                    child: TabBarView(
                      children: !controller.mealsList.isNotEmpty
                          ? [
                              TabBarViewChild(
                                  label: LocaleKeys.empty_meal_tab_hint.tr,
                                  theme: theme!),
                              TabBarViewChild(
                                  label: LocaleKeys.empty_meal_tab_hint.tr,
                                  theme: theme),
                            ]
                          : controller.mealsList
                              .map(
                                (meal) =>
                                    TabBarViewChild(label: meal, theme: theme!),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.toHeight),
            NeumorphicButton(
                style: NeumorphicStyle(
                  color: theme?.accentColor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                ),
                margin: EdgeInsets.only(left: 100),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.new_meal_button_label.tr,
                      style: theme?.textTheme.bodyMedium?.copyWith(
                        color: ColorConstants.white,
                      ),
                    ),
                    SizedBox(
                      width: 10.toWidth,
                    ),
                    Icon(
                      Icons.add_circle,
                      color: ColorConstants.white,
                    ),
                  ],
                ),
                onPressed: () async {}),
            Expanded(child: Container()),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: theme?.accentColor,
        overlayColor: Colors.black,
        icon: Icons.add,
        activeIcon: Icons.close,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.egg,
              color: theme?.iconTheme.color,
            ),
            label: LocaleKeys.ingredient_tab_label.tr,
            onTap: () => Get.toNamed(Routes.ADD_NEW_INGREDIENT),
          ),
          SpeedDialChild(
            child: Icon(
              Icons.restaurant_menu_rounded,
              color: theme?.iconTheme.color,
            ),
            label: LocaleKeys.recipe_tab_label.tr,
          ),
        ],
      ),
    );
  }

  Widget _buildNeumorphicButton(
      {BuildContext? context,
      String? text,
      Widget? icon,
      VoidCallback? onPressed}) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
      ),
      child: Container(
        width: 150.toWidth,
        child: Column(
          children: [
            icon!,
            SizedBox(
              height: 10.toHeight,
            ),
            Text(text!),
          ],
        ),
      ),
    );
  }
}
