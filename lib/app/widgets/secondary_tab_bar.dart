import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/config/size_constants.dart';
import 'package:nifty_mobile/app/config/theme_data.dart';

class SecondaryTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final VoidCallback? onAddPressed;
  final EdgeInsets padding ;
  final void Function(int)? onTap;

  SecondaryTabBar(
      {Key? key, required this.tabs, this.onAddPressed, this.onTap , this.padding = const EdgeInsets.only(left: 18, bottom: 6 , right: SizeConstants.secondaryTabBarAddContainerWidth)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        TabBar(
          onTap: onTap,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: const EdgeInsets.only(right: 6.6),
          padding: padding,
          tabs: [
            ...tabs,
          ],
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(top: 2),
          child: GestureDetector(
            // Using GestureDetector to detect taps on the Container
            onTap: onAddPressed,
            // Execute the callback when the Container (Add icon) is tapped
            child: Container(
              width: SizeConstants.secondaryTabBarAddContainerWidth,
              height: SizeConstants.secondaryTabBarAddContainerHeight,
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  color: ColorConstants.secondaryTabBarContainerColor,
                  borderRadius:
                  ThemeConfig.secondaryTabsAddCornerRadius,
                  boxShadow: [
                    ThemeConfig.secondaryTabShadow,
                  ]),
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.add,
                size: SizeConstants.secondaryTabBarAddIconSize,
                color: ColorConstants.secondaryTabBarTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SecondaryTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Widget? icon; // Make the icon parameter nullable
  const SecondaryTab({
    Key? key,
    required this.title,
    required this.isSelected,
    this.icon, // No longer required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuild secondary tabs") ;

    var theme = NeumorphicTheme.of(context)?.current;

    // Style adjustments based on the isSelected flag
    Color backgroundColor = isSelected
        ? Colors.white
        : ColorConstants.secondaryTabBarContainerColor;
    Color borderColor = isSelected
        ? Colors.transparent
        : ColorConstants.secondaryTabBarTextColor;
    double horizontalPadding = isSelected ? 14 : 14;
    double textFontSize = isSelected ? 16 : 16;
    Color textColor = isSelected
        ? ColorConstants.accentColor
        : ColorConstants.secondaryTabBarTextColor;
    FontWeight textFontWeight =
        isSelected ? FontWeight.bold : FontWeight.normal;

    return Tab(
      child: Container(
        height: 39,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(5),
          boxShadow: isSelected
              ? [
                  ThemeConfig.secondaryTabShadow,
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              // Only add icon and SizedBox if icon is not null
              icon!,
              const SizedBox(width: 10),
            ],
            Text(
              title,
              style: theme?.textTheme.titleMedium?.copyWith(
                color: textColor,
                fontWeight: textFontWeight,
                fontSize: textFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
