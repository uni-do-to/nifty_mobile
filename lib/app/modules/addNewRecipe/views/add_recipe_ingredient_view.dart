import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/config/size_constants.dart';
import 'package:nifty_mobile/app/modules/addNewRecipe/controllers/add_new_recipe_controller.dart';
import 'package:nifty_mobile/app/modules/addNewRecipe/views/recipe_ingredient_tab.dart';
import 'package:nifty_mobile/app/widgets/main_tab_bar.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddRecipeIngredientView extends GetView<AddNewRecipeController> {
  const AddRecipeIngredientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 30,
        leading: Container(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme?.iconTheme.color,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        title: Container(
          // padding: SizeConstants.toolBarPadding,
          child: Text(
              LocaleKeys.add_ingredient_to_recipe_title_page.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge
            ?.copyWith(color: ColorConstants.toolbarTextColor),
        toolbarHeight: 40,
      ),
      body: Container(
        color: ColorConstants.grayBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 18),
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
                        LocaleKeys.ingredient_bottom_navigation_label.tr,
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
                        RecipeIngredientTab(),
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
