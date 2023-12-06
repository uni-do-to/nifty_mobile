import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/modules/daily/views/chart_view.dart';
import 'package:nifty_mobile/app/modules/daily/views/meal_tab_view.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

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
          padding: EdgeInsets.only(
            top: 100.toHeight,
            bottom: 50.toHeight,
            right: 40.toWidth,
          ),
          child: const Text('Daily'),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        toolbarHeight: 120.toHeight,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 400.toHeight,
              color: Color(0xffF9F8F8),
              padding: EdgeInsets.all(20),
              child: ChartView(),
            ),
            Container(
              height: 130.toHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 6.0,
                    offset: Offset(0.0, -5.0),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => {},
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: theme?.iconTheme.color,
                      size: theme?.iconTheme.size,
                    ),
                  ),
                  SizedBox(
                    width: 30.toWidth,
                  ),
                  ObxValue((state) {
                    return Text(
                      state.value,
                      style: theme?.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    );
                  }, controller.day),
                  SizedBox(
                    width: 30.toWidth,
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: Icon(Icons.arrow_forward_ios_sharp,
                        color: theme?.iconTheme.color),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Container(
                  child: Column(
                    children: [
                      TabBar(
                        indicator: BoxDecoration(
                          color: Color(0xffF9F8F8),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffDDDDDD),
                              blurRadius: 8.0,
                              offset: Offset(0.0, 3.0),
                            ),
                          ],
                        ),
                        labelColor: ColorConstants.accentColor,
                        labelStyle: theme?.textTheme.bodyMedium?.copyWith(
                          fontSize: 28.toFont,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                          color: ColorConstants.accentColor,
                        ),
                        unselectedLabelStyle:
                            theme?.textTheme.bodyMedium?.copyWith(
                          fontSize: 28.toFont,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          color: ColorConstants.accentColor,
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              "Vos repas",
                            ),
                            height: 70.toHeight,
                          ),
                          Tab(
                            child: Text(
                              "Sport",
                            ),
                            height: 70.toHeight,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF9F8F8),
                          ),
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              MealTabView(
                                mealsList: controller.mealsList,
                                theme: theme!,
                              ),
                              Icon(Icons.directions_transit, size: 30),
                            ],
                          ),
                        ),
                      ),
                    ],
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
