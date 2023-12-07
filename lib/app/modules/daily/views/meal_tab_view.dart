import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/widgets/secondary_tab_bar.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';

import '../../../config/color_constants.dart';

class CustomTabListView extends HookWidget {
  final int selectedTabIndex;
  final void Function(int)? onTapChanged;
  final void Function()? onAddTabPressed;
  final int tabCount;
  final Widget Function(int index) tabBuilder;
  final Widget Function(BuildContext context, int index) listItemBuilder;

  CustomTabListView({
    Key? key,
    required this.selectedTabIndex,
    required this.tabCount,
    required this.tabBuilder,
    required this.listItemBuilder,
    this.onTapChanged,
    this.onAddTabPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuild widget");

    return DefaultTabController(
      length: tabCount,
      initialIndex: selectedTabIndex,
      child: Container(
        padding: EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
/*            Builder(
              builder: (context) {
                print("rebuild builder");
                RxInt selectedIndex = selectedTabIndex.obs;
                var tabController = DefaultTabController.of(context);
                tabController.addListener(() {
                  if (tabController.indexIsChanging)
                    selectedIndex.value = tabController.index;
                });
                return*/
                  SecondaryTabBar(
                  onAddPressed: onAddTabPressed,
                  onTap: onTapChanged,
                  tabs: List.generate(
                    tabCount,
                    (index) => tabBuilder(index),
                  ),
                )
    // ;
    //           },
    //         )
                    ,
            //navigation button to create ingredient/ recipe
            SizedBox(
              height: 9,
            ),
            Container(
              padding: EdgeInsets.only(left: 18),
              child: Row(
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
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                color: ColorConstants.grayBackgroundColor,
                padding: EdgeInsets.only(right: 16, left: 18),
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                    tabCount,
                    (index) => ListView.separated(
                      itemCount: tabCount * 2, // Adjust this as needed
                      separatorBuilder: (context, index) => SizedBox(height: 4),
                      padding: EdgeInsets.only(right: 20),
                      itemBuilder: (context, itemIndex) =>
                          listItemBuilder(context, itemIndex),
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
