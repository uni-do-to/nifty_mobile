import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/widgets/secondary_tab_bar.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';

import '../config/color_constants.dart';

class CustomTabListView extends StatelessWidget {
  final int selectedTabIndex;
  final String addNewTitle ;
  final void Function(int)? onTapChanged;
  final void Function()? onAddTabPressed;
  final int tabCount;
  final Widget Function(int index) tabBuilder;
  final void Function()? onAddNewItem;
  final int Function(int index) getTapItemCount;
  final Widget Function(BuildContext context, int tabIndex, int listIndex)
      listItemBuilder;

  const CustomTabListView({
    Key? key,
    required this.selectedTabIndex,
    required this.addNewTitle ,
    required this.tabCount,
    required this.tabBuilder,
    required this.listItemBuilder,
    required this.getTapItemCount,
    this.onTapChanged,
    this.onAddTabPressed,
    this.onAddNewItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuild widget");

    return DefaultTabController(
      length: tabCount,
      initialIndex: selectedTabIndex,
      child: Container(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SecondaryTabBar(
              onAddPressed: onAddTabPressed,
              onTap: onTapChanged,
              tabs: List.generate(
                tabCount,
                (index) => tabBuilder(index),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Container(
              padding: const EdgeInsets.only(left: 18),
              child: Row(
                children: [
                  Container(
                    height: 46,
                    clipBehavior: Clip.none,
                    child: SmallActionButton(
                      text: addNewTitle,
                      backgroundColor: ColorConstants.secondaryTabBarTextColor,
                      textColor: Colors.white,
                      fontSize: 16,
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: onAddNewItem,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                color: ColorConstants.grayBackgroundColor,
                padding: const EdgeInsets.only(right: 16, left: 18),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    tabCount,
                    (index) => ListView.separated(
                      itemCount: getTapItemCount(index),
                      // Adjust this as needed
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      padding: const EdgeInsets.only(right: 20),
                      itemBuilder: (context, itemIndex) =>
                          listItemBuilder(context, index, itemIndex),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
