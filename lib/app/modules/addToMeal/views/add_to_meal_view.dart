import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/config/size_constants.dart';
import 'package:nifty_mobile/app/modules/addToMeal/views/ingredient_teb_view.dart';
import 'package:nifty_mobile/app/modules/addToMeal/views/recipe_tab_view.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/main_tab_bar.dart';

import '../controllers/add_to_meal_controller.dart';

class AddToMealView extends GetView<AddToMealController> {
  const AddToMealView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          child: Text('Ajouter Au Repas'.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge
            ?.copyWith(color: ColorConstants.toolbarTextColor),

        toolbarHeight: 40,
      ),
      body: Container(
        color: ColorConstants.grayBackgroundColor,
        padding: const EdgeInsets.only(top:16),
        child: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MainTabBar(
                    tabs: [
                      MainTab(
                        child: Text(
                          "Ingrédient",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      MainTab(
                        child: Text(
                          "Recette",
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
                          IngredientTabView(
                            selectedMeal: controller.selectedMeal,
                            theme: theme!,
                            onAddIngredientToMealPressed: ()=> controller.onAddIngredientToMeal(),
                          ),
                          RecipeTabView(
                            selectedMeal: controller.selectedMeal,
                            onAddNewRecipe: () async {
                              var result =
                                  await Get.toNamed(Routes.ADD_NEW_RECIPE);
                              if (result == true) controller.loadRecipeList();
                            },
                            onAddRecipeToMeal: () {
                              controller.onAddRecipeToMeal() ;
                              //TODO add your recipe to ingredient list inside selected meal object
                            },
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
      ),
    );
  }
}
