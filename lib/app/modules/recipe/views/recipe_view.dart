import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/widgets/delete_alert_dialog.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/recipe_ingredient_list_item.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../controllers/recipe_controller.dart';

class RecipeView extends GetView<RecipeController> {
  RecipeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 47,
            left: 19,
            bottom: 13,
          ),
          child: Text('Recipes'.tr.toUpperCase()),
        ),
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.bodySmall?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        toolbarHeight: 86,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 37.35,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: SmallActionButton(
                    text: 'Ajouter une nouvelle recite ',
                    backgroundColor: ColorConstants.mainThemeColor,
                    textColor: Colors.white,
                    fontSize: 14,
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 17.75,
                    ),
                    onPressed: () async {
                      var result = await Get.toNamed(Routes.ADD_NEW_RECIPE);
                      if (result == true) controller.initData();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ObxValue((state) {
              return state.value
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: theme?.textTheme.labelLarge?.color,
                      ),
                    )
                  : Expanded(
                      child: Column(
                        children: [
                          NeuFormField(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            hintText:
                                LocaleKeys.search_recipes_dropdown_label.tr,
                            controller: controller.searchRecipesController,
                            suffixIcon: Icon(Icons.search),
                            maintainErrorSize: false,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            onChanged: (value) {
                              controller.filterSearchResults(value);
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: ObxValue((state) {
                              return ListView.builder(
                                itemCount: controller.filteredItems.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      RecipeIngredientListItem(
                                        onDeletePressed: () =>
                                            showDeleteConfirmationDialog(
                                                context, index),
                                        icon: Icons.restaurant_menu_rounded,
                                        text: controller.filteredItems[index]
                                                .attributes?.name ??
                                            "no search result",
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, controller.filteredItems),
                          ),
                        ],
                      ),
                    );
            }, controller.loading),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteAlertDialogWidget(
          itemName: controller.filteredItems[index].attributes!.name!,
          onCancelPressed: () => Get.back(),
          onDeletePressed: () async {
            await controller.removeRecipe(controller.filteredItems[index]);
            controller.filteredItems.removeAt(index);
            Get.back();
            controller.initData();
          },
        );
      },
    );
  }
}
