import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/modules/addSport/views/sport_tab_view.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/main_tab_bar.dart';
import 'package:nifty_mobile/app/widgets/sport_list_item.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../controllers/add_sport_controller.dart';

class AddSportView extends GetView<AddSportController> {
  const AddSportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 25,
        leading: Container(
          padding: EdgeInsets.only(
            top: 35,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme?.iconTheme.color,
              size: 20,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(
            top: 47,
            bottom: 13,
          ),
          child: Text('Ajouter Au sport'.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge,
        toolbarHeight: 86,
      ),
      body: Container(
        color: ColorConstants.grayBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 30.toHeight),
        child: DefaultTabController(
          length: 1,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainTabBar(
                  tabs: [
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
                        SportTabView(
                          selectedSport: controller.selectedSportDaily,
                          theme: theme!,
                          onAddSportToDaily: () {
                            controller.onAddSportToSports() ;
                            //TODO add your sport to sports list inside selected sport object
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
