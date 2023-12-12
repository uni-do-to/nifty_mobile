import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/recipe_ingredient_list_item.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../controllers/ingredient_controller.dart';

class IngredientView extends GetView<IngredientController> {
  const IngredientView({Key? key}) : super(key: key);

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
          child: Text('Ingredients'.tr.toUpperCase()),
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
                    text: 'Ajouter un nouvel Ingrédient',
                    backgroundColor: ColorConstants.mainThemeColor,
                    textColor: Colors.white,
                    fontSize: 14,
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 17.75,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.ADD_NEW_INGREDIENT);
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
                                LocaleKeys.search_ingredients_dropdown_label.tr,
                            controller: controller.searchIngredientsController,
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
                                          icon: Icons.egg,
                                          text: Get.locale?.languageCode == 'fr'
                                              ? controller.filteredItems[index]
                                                  .attributes!.nameFr!
                                              : controller.filteredItems[index]
                                                  .attributes!.nameEn!),
                                      const SizedBox(
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
        return AlertDialog(
          title: Text('Confirm Delete Ingredient'),
          content: Get.locale?.languageCode == 'fr'
              ? Text(
                  'Are you sure you want to delete ${controller.filteredItems[index].attributes?.nameFr}?')
              : Text(
                  'Are you sure you want to delete ${controller.filteredItems[index].attributes?.nameEn}?'),
          actions: <Widget>[
            SmallActionButton(
              text: 'Delete',
              backgroundColor: ColorConstants.mainThemeColor,
              textColor: Colors.white,
              fontSize: 20,
              height: 30,
              onPressed: () async{
                await controller.removeIngredient(controller.filteredItems[index]);
                controller.filteredItems.removeAt(index);
                Get.back();
                controller.initData();
              },
            ),
            const SizedBox(
              height: 15,
            ),
            SmallActionButton(
              text: 'Cancel',
              backgroundColor: ColorConstants.grayBackgroundColor,
              textColor: ColorConstants.mainThemeColor,
              fontSize: 20,
              height: 30,
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
