import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/config/size_constants.dart';
import 'package:nifty_mobile/app/config/theme_data.dart';
import 'package:nifty_mobile/app/modules/daily/views/chart_view.dart';
import 'package:nifty_mobile/app/modules/daily/views/meal_tab_view.dart';
import 'package:nifty_mobile/app/modules/daily/views/sport_tab_view.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/main_tab_bar.dart';

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
          child: Text('Daily'.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge
            ?.copyWith(color: ColorConstants.toolbarTextColor),
        toolbarHeight: 86,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 228,
              color: ColorConstants.grayBackgroundColor,
              padding: EdgeInsets.all(20),
              child: ChartView(),
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
                    onTap: () => {},
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
                    onTap: () => {},
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
                    const MainTabBar(
                      tabs: [
                        MainTab(
                          child: Text(
                            "Vos repas",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        MainTab(
                          child: Text(
                            "Sport",
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
                            CustomTabListView(
                              tabCount: controller.mealsList.length,
                              selectedTabIndex:
                                  controller.selectedMealTabIndex.value,
                              onAddTabPressed: () =>
                                  {controller.mealsList.add("New #")},
                              onTapChanged: (index) {
                                controller.selectedMealTabIndex.value = index;
                              },
                              tabBuilder: (index) {
                                return ObxValue( (state) {
                                  return SecondaryTab(
                                    title: 'Repas n°$index',
                                    isSelected: state.value == index,
                                    icon: state.value == index
                                        ? SvgPicture.asset(
                                      'assets/images/meal_icon.svg',
                                      width: 23,
                                      height: 20,
                                      color:
                                      ColorConstants.secondaryTabBarTextColor,
                                    )
                                        : null,
                                  );
                                } , controller.selectedMealTabIndex
                                );
                              },
                              listItemBuilder: (BuildContext context, int index){
                                return DailyListItem(
                                  name: 'Steak tartare',
                                  calories: RichText(
                                    text: TextSpan(
                                      style: theme?.textTheme.titleMedium,
                                      children: const [
                                        TextSpan(text: '150'),
                                        TextSpan(
                                            text: ' kCal',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  action: InkWell(
                                    onTap: () => {},
                                    enableFeedback: true,
                                    child: Icon(
                                      Icons.delete,
                                      color: ColorConstants.accentColor
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SportTabView(
                              sportsList: controller.sportsList,
                              theme: theme!,
                            ),
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
