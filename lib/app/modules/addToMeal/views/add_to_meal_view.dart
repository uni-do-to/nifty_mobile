import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/modules/addToMeal/views/ingredient_teb_view.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

import '../controllers/add_to_meal_controller.dart';

class AddToMealView extends GetView<AddToMealController> {
  const AddToMealView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25.toWidth,
        leading: Container(
          padding: EdgeInsets.only(
            top: 30.toHeight,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme?.iconTheme.color,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(
            top: 80.toHeight,
            bottom: 50.toHeight,
          ),
          child: const Text('Ajouter Au Repas'),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        toolbarHeight: 120.toHeight,
      ),
      body: Container(
        color: Color(0xffF9F8F8),
        padding: EdgeInsets.symmetric(vertical: 30.toHeight),
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
                        color: Color(0xff707070),
                        blurRadius: 8.0,
                        offset: Offset(0.0, 3.0),
                      ),
                    ],
                  ),
                  labelColor: ColorConstants.accentColor,
                  labelStyle: theme?.textTheme.bodyMedium?.copyWith(
                    fontSize: 32.toFont,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,
                    color: ColorConstants.accentColor,
                  ),
                  unselectedLabelStyle: theme?.textTheme.bodyMedium?.copyWith(
                    fontSize: 32.toFont,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    color: ColorConstants.accentColor,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        "Ingrédient",
                      ),
                      height: 70.toHeight,
                    ),
                    Tab(
                      child: Text(
                        "Recette",
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
                        IngredientTabView(
                          selectedMeal: controller.selectedMeal,
                          theme: theme!,
                        ),
                        IngredientTabView(
                          selectedMeal: controller.selectedMeal,
                          theme: theme,
                        ),
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
