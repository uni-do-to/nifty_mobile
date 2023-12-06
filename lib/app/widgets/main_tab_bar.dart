import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../config/color_constants.dart';
import '../config/theme_data.dart';

class MainTabBar extends StatelessWidget {
  final List<Widget> tabs ;

  const MainTabBar({required this.tabs ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return TabBar(
      indicator: BoxDecoration(
        color: ColorConstants.grayBackgroundColor,
        borderRadius: ThemeConfig.mainTabsCornerRadius,
        boxShadow: [
          ThemeConfig.mainTabsShadow,
        ],
      ),
      labelColor: ColorConstants.accentColor,
      labelStyle: theme?.textTheme.titleLarge?.copyWith(
        decoration: TextDecoration.underline,
      ),
      unselectedLabelStyle:
      theme?.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.normal,
      ),
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      tabs: tabs ,
    );
  }
}

class MainTab extends StatelessWidget {
  final Widget child ;
  const MainTab({required this.child ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
        height: 36,
        child: SizedBox(
          width: 135,
          child: child,
        ),
      );
  }
}
