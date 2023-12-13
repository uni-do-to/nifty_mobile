import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../utils/size_utils.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: Routes.DAILY,
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 26.toFont,
          unselectedFontSize: 24.toFont,
          selectedItemColor: ColorConstants.accentColor,
          unselectedItemColor: ColorConstants.accentColor,
          unselectedLabelStyle: theme?.textTheme.bodySmall?.copyWith(
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
          selectedLabelStyle: theme?.textTheme.bodySmall?.copyWith(
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/daily_icon_inactive.svg',
                height: 26.4,
                width: 24.9,
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/daily_icon_active.svg',
                height: 26.4,
                width: 24.9,
              ),
              label: LocaleKeys.daily_bottom_navigation_label.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/recipe_icon_inactive.svg',
                height: 28.18,
                width: 21.72,
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/recipe_icon_active.svg',
                height: 28.18,
                width: 21.72,
              ),
              label: LocaleKeys.recipe_tab_label.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/ingredient_icon_inactive.svg',
                height: 28.3,
                width: 28.5,
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/ingredient_icon_active.svg',
                height: 28.3,
                width: 28.5,
              ),
              label: LocaleKeys.ingredient_bottom_navigation_label.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/profile_icon_inactive.svg',
                height: 26.19,
                width: 26.19,
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/profile_icon_inactive.svg',
                height: 26.19,
                width: 26.19,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: controller.currentIndex.value,
          // selectedItemColor: Colors.pink,
          onTap: controller.changePage,
        ),
      ),
    );
  }
}
