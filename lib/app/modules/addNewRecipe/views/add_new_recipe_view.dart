import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/config/size_constants.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/widgets/empty_list_item.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/recipe_ingredient_list_item.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../controllers/add_new_recipe_controller.dart';

class AddNewRecipeView extends GetView<AddNewRecipeController> {
  const AddNewRecipeView({Key? key}) : super(key: key);

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
          child: Text(LocaleKeys.add_recipe_screen_title.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge
            ?.copyWith(color: ColorConstants.toolbarTextColor),
        toolbarHeight: 40,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Form(
          key: controller.addNewRecipeFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Neumorphic(
                style: NeumorphicStyle(depth: 1.3, intensity: 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.recipe_name_label.tr,
                      style: theme?.textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NeuFormField(
                      padding: const EdgeInsets.symmetric(horizontal: 18 , vertical: 8),
                      hintText: LocaleKeys.recipe_name_hint.tr,
                      keyboardType: TextInputType.text,
                      controller: controller.recipeNameController,
                      autocorrect: false,
                      errorText: controller.recipeNameError.value,
                    ),
                    Text(
                      LocaleKeys.grams_per_circle_label.tr,
                      style: theme?.textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NeuFormField(
                      padding: const EdgeInsets.symmetric(horizontal: 18 , vertical: 8),
                      hintText: '500',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: true , signed: true),                      controller: controller.recipeGramsPerCircleController,
                      autocorrect: false,
                      errorText: controller.recipeGramsPerCircleError.value,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    height: 37.35,
                    child: SmallActionButton(
                      text: LocaleKeys.add_new_ingredient_screen_sub_title.tr,
                      backgroundColor: ColorConstants.mainThemeColor,
                      textColor: Colors.white,
                      fontSize: 14,
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 17.75,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.ADD_NEW_RECIPE +
                            Routes.RECIPE_INGREDIENT_TAB);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 23),
              Expanded(
                child: ObxValue((state) {
                  if (state.isEmpty && state.length == 0) {
                    return EmptyListItem();
                  }
                  return ListView.builder(
                    itemCount: controller.recipeIngredientsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          RecipeIngredientListItem(
                              onDeletePressed: () =>
                                  showDeleteConfirmationDialog(context, index),
                              icon: Icons.egg,
                              text: Get.locale?.languageCode == 'fr'
                                  ? controller
                                          .recipeIngredientsList[index]
                                          .ingredient
                                          ?.data
                                          ?.attributes
                                          ?.nameFr ??
                                      ""
                                  : controller
                                          .recipeIngredientsList[index]
                                          .ingredient
                                          ?.data
                                          ?.attributes
                                          ?.nameEn ??
                                      ""),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  );
                }, controller.recipeIngredientsList),
              ),
              ObxValue((state) {
                return Container(
                  padding: EdgeInsets.only(bottom: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Container()),
                      Container(
                        height: 54,
                        width: 191,
                        child: SmallActionButton(
                          text: LocaleKeys.add_recipe_button_label.tr,
                          backgroundColor: state.value
                              ? ColorConstants.accentColor
                              : ColorConstants.accentColor.withOpacity(0.4),
                          textColor: Colors.white,
                          onPressed: () async {
                            if (state.value) {
                              await controller.createNewRecipe();
                              Get.back(result: true);
                            }
                          },
                          // Optionally, specify width and height
                        ),
                      ),
                    ],
                  ),
                );
              }, controller.isFormValid),
            ],
          ),
        ),
      ),
    );
  }


  void showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.delete_dialog_ingredient_title.tr),
          content: Get.locale?.languageCode == 'fr'
              ? Text(
              '${LocaleKeys.delete_dialog_confirm_label.tr}${controller.recipeIngredientsList[index]..ingredient?.data?.attributes?.nameFr}?')
              : Text(
              '${LocaleKeys.delete_dialog_confirm_label.tr}${controller.recipeIngredientsList[index]..ingredient?.data?.attributes?.nameEn}?'),
          actions: <Widget>[
            SmallActionButton(
              text: LocaleKeys.delete_label.tr,
              backgroundColor: ColorConstants.mainThemeColor,
              textColor: Colors.white,
              fontSize: 20,
              height: 30,
              onPressed: () async {
                controller.recipeIngredientsList.removeAt(index);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            SmallActionButton(
              text: LocaleKeys.cancel_label.tr,
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
