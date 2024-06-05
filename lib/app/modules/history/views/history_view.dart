import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/history/views/summery_view.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/color_constants.dart';
import '../../../config/theme_data.dart';
import '../../../widgets/main_tab_bar.dart';
import '../controllers/history_controller.dart';
import 'history_list_item.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 30,
        leading: Container(
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme?.iconTheme.color,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        title: Container(
          child: Text(LocaleKeys.history.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge
            ?.copyWith(color: ColorConstants.toolbarTextColor),
        toolbarHeight: 40,
      ),
      body: Container(
        color: ColorConstants.grayBackgroundColor,
        padding: const EdgeInsets.only(top: 16),
        child: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MainTabBar(
                    isScrollable: false,
                    tabs: [
                      MainTab(
                        child: Text(
                          LocaleKeys.days.tr,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      MainTab(
                        child: Text(
                          LocaleKeys.week.tr,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      MainTab(
                        child: Text(
                          LocaleKeys.months.tr,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 290,
                    decoration: BoxDecoration(
                      color: ColorConstants.grayBackgroundColor,
                    ),
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ObxValue((state) {
                          if (state.isEmpty) return Container();
                          var old = state.last.attributes?.weight ?? 0.0;
                          var current = state.first.attributes?.weight ?? 0.0;

                          return SummaryView(
                            old: old,
                            current: current,
                            historyList: controller.aggregateByDate(state),
                            timeFrame: "days",
                          );
                        }, controller.pastWeekList),
                        ObxValue((state) {
                          if (state.isEmpty) return Container();
                          var old = state.last.attributes?.weight ?? 0.0;
                          var current = state.first.attributes?.weight ?? 0.0;

                          return SummaryView(
                            old: old,
                            current: current,
                            historyList: controller.aggregateByDate(state),
                            timeFrame: "weeks",
                          );
                        }, controller.pastMonthList),
                        ObxValue((state) {
                          if (state.isEmpty) return Container();
                          var old = state.last.attributes?.weight ?? 0.0;
                          var current = state.first.attributes?.weight ?? 0.0;

                          return SummaryView(
                            old: old,
                            current: current,
                            historyList: controller.aggregateByDate(state),
                            timeFrame: "months",
                          );
                        }, controller.pastYearList),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorConstants.grayBackgroundColor,
                      boxShadow: [ThemeConfig.topShadow],
                    ),
                    child: Text(
                      LocaleKeys.updates.tr, // Display weight with 'kg' suffix
                      style: theme?.textTheme.titleLarge,
                    ),
                  ),
                  Expanded(
                    child: ObxValue((state) {
                      return ListView.builder(
                        itemCount: state.length,
                        // Your list of History instances
                        itemBuilder: (context, index) {
                          return HistoryListItem(history: state[index]);
                        },
                      );
                    }, controller.historyList),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
