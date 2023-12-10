import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/widgets/empty_list_item.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/recipe_ingredient_list_item.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';

import '../controllers/add_new_recipe_controller.dart';

class AddNewRecipeView extends GetView<AddNewRecipeController> {
  const AddNewRecipeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 18,
        leading: Container(
          padding: EdgeInsets.only(
            top: 35,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme?.iconTheme.color,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(
            top: 47,
            bottom: 13,
          ),
          child: Text('Add Recipe'.tr.toUpperCase()),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge,
        toolbarHeight: 86,
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
                      'Name',
                      style: theme?.textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NeuFormField(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      hintText: 'My new recipe',
                      keyboardType: TextInputType.text,
                      controller: controller.recipeNameController,
                      autocorrect: false,
                      errorText: controller.recipeNameError.value,
                    ),
                    Text(
                      'Grams per circle',
                      style: theme?.textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    NeuFormField(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      hintText: '500',
                      keyboardType: TextInputType.number,
                      controller: controller.recipeGramsPerCircleController,
                      autocorrect: false,
                      errorText: controller.recipeGramsPerCircleError.value,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 37.35,
                width: 230,
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
                    Get.toNamed(
                        Routes.ADD_NEW_RECIPE + Routes.RECIPE_INGREDIENT_TAB);
                  },
                ),
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
                              onTap: () =>
                                  showDeleteConfirmationDialogc(context, index),
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
                          text: 'Ajouter au repas',
                          backgroundColor:state.value
                              ? ColorConstants.accentColor
                              : ColorConstants.accentColor.withOpacity(0.4),
                          textColor: Colors.white,
                          onPressed: ()async {
                            if (state.value){
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

  void showDeleteConfirmationDialogc(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete Ingredient'),
          content: Get.locale?.languageCode == 'fr'
              ? Text(
                  'Are you sure you want to delete ${controller.recipeIngredientsList[index].ingredient?.data?.attributes?.nameFr}?')
              : Text(
                  'Are you sure you want to delete ${controller.recipeIngredientsList[index].ingredient?.data?.attributes?.nameEn}?'),
          actions: <Widget>[
            SmallActionButton(
              text: 'Delete',
              backgroundColor: ColorConstants.mainThemeColor,
              textColor: Colors.white,
              fontSize: 20,
              height: 30,
              onPressed: () {
                controller.recipeIngredientsList.removeAt(index);
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
