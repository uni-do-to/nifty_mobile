import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/category_model.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/sub_category_model.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/loading_overlay.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../controllers/add_ingredient_meal_controller.dart';

class AddIngredientMealView extends GetView<AddIngredientMealController> {
  const AddIngredientMealView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: theme?.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        titleSpacing: 20,
        title: Row(
          children: [
            Icon(Icons.egg),
            SizedBox(
              width: 30.toWidth,
            ),
            Text(
              LocaleKeys.ingredient_tab_label.tr,
            ),
          ],
        ),
        iconTheme: theme?.iconTheme,
      ),
      body: ObxValue((state) {
        return state.value
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: theme?.textTheme.labelLarge?.color,
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 50.toWidth, vertical: 10.toHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Neumorphic(
                              style: NeumorphicStyle(depth: 1.2, intensity: 1),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.toWidth,
                                  vertical: 30.toHeight),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 90.toWidth,
                                  vertical: 10.toHeight),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '1',
                                    style:
                                        theme?.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.toWidth,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.choose_title.tr,
                                        style: theme?.textTheme.bodyMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.toFont,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.toHeight,
                                      ),
                                      Text(
                                        LocaleKeys.choose_sub_title.tr,
                                        style: theme?.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.toHeight,
                            ),
                            Text(
                              LocaleKeys.find_my_ingredient_hint.tr,
                              style: theme?.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20.toHeight,
                            ),
                            Text(
                              LocaleKeys
                                  .find_ingredient_searchbar_or_categories_hint
                                  .tr,
                              style: theme?.textTheme.bodySmall
                                  ?.copyWith(height: 1.8),
                            ),
                            SizedBox(
                              height: 30.toHeight,
                            ),

                            //search in admin ingredients
                            Text(
                              LocaleKeys.research_dropdown_label.tr,
                              style: theme?.textTheme.bodySmall,
                            ),
                            SizedBox(
                              height: 20.toHeight,
                            ),
                            TypeAheadField<Ingredient>(
                              controller:
                                  controller.searchIngredientsController,
                              suggestionsCallback: (search) =>
                                  controller.searchIngredients(search),
                              builder: (context, controller, focusNode) {
                                return NeuFormField(
                                  hintText: LocaleKeys
                                      .search_ingredients_dropdown_label.tr,
                                  controller: controller,
                                  focusNode: focusNode,
                                  suffixIcon: Icon(Icons.search),
                                );
                              },
                              itemBuilder: (context, ingredient) {
                                return ListTile(
                                  title: Text(
                                    Get.locale?.languageCode == 'fr'
                                        ? ingredient.attributes!.nameFr!
                                        : ingredient.attributes!.nameEn!,
                                  ),
                                );
                              },
                              onSelected: (ingredient) {
                                controller.selectedCategoryId.value = 0;
                                controller.selectedSubCategoryId.value = 0;
                                controller.selectedIngredient = ingredient;
                                controller.userIngredientsController.text = "";
                                controller.categoriesController.text = "";
                                controller.subcategoriesController.text = "";
                                controller.ingredientsSubCategoriesController
                                    .text = "";
                                controller.searchIngredientsController.text =
                                    Get.locale?.languageCode == 'fr'
                                        ? ingredient.attributes!.nameFr!
                                        : ingredient.attributes!.nameEn!;
                              },
                            ),
                            SizedBox(
                              height: 10.toHeight,
                            ),

                            //search in user ingredient
                            Text(
                              LocaleKeys.personal_ingredient_dropdown_label.tr,
                              style: theme?.textTheme.bodySmall,
                            ),
                            SizedBox(
                              height: 20.toHeight,
                            ),
                            TypeAheadField<Ingredient>(
                              controller: controller.userIngredientsController,
                              suggestionsCallback: (search) =>
                                  controller.searchIngredients(search),
                              builder: (context, controller, focusNode) {
                                return NeuFormField(
                                  hintText: LocaleKeys
                                      .choose_ingredient_dropdown_label.tr,
                                  controller: controller,
                                  focusNode: focusNode,
                                  suffixIcon:
                                      Icon(Icons.keyboard_arrow_down_sharp),
                                );
                              },
                              itemBuilder: (context, ingredient) {
                                return ListTile(
                                  title: Text(
                                    Get.locale?.languageCode == 'fr'
                                        ? ingredient.attributes!.nameFr!
                                        : ingredient.attributes!.nameEn!,
                                  ),
                                );
                              },
                              onSelected: (ingredient) {
                                controller.selectedCategoryId.value = 0;
                                controller.selectedSubCategoryId.value = 0;
                                controller.selectedIngredient = ingredient;
                                controller.categoriesController.text = "";
                                controller.subcategoriesController.text = "";
                                controller.ingredientsSubCategoriesController
                                    .text = "";
                                controller.searchIngredientsController.text =
                                    "";
                                controller.userIngredientsController.text =
                                    Get.locale?.languageCode == 'fr'
                                        ? ingredient.attributes!.nameFr!
                                        : ingredient.attributes!.nameEn!;
                              },
                            ),

                            //search in categories
                            Text(
                              LocaleKeys.categories_dropdown_label.tr,
                              style: theme?.textTheme.bodySmall,
                            ),
                            SizedBox(
                              height: 10.toHeight,
                            ),
                            TypeAheadField<Category>(
                              controller: controller.categoriesController,
                              suggestionsCallback: (search) =>
                                  controller.searchCategory(search),
                              builder: (context, controller, focusNode) {
                                return NeuFormField(
                                  hintText: LocaleKeys
                                      .choose_category_dropdown_label.tr,
                                  controller: controller,
                                  focusNode: focusNode,
                                  suffixIcon:
                                      Icon(Icons.keyboard_arrow_down_sharp),
                                );
                              },
                              itemBuilder: (context, categoryData) {
                                return ListTile(
                                  title: Text(
                                    Get.locale?.languageCode == 'fr'
                                        ? categoryData.attributes!.nameFr!
                                        : categoryData.attributes!.nameEn!,
                                  ),
                                );
                              },
                              onSelected: (categoryData) {
                                controller.selectedCategoryId.value =
                                    categoryData.id!;
                                controller.getSubcategory(categoryData.id);
                                controller.searchIngredientsController.text =
                                    "";
                                controller.userIngredientsController.text = "";
                                controller.subcategoriesController.text = "";
                                controller.ingredientsSubCategoriesController
                                    .text = "";
                                controller.categoriesController.text =
                                    Get.locale?.languageCode == 'fr'
                                        ? categoryData.attributes!.nameFr!
                                        : categoryData.attributes!.nameEn!;
                              },
                            ),

                            //search in subcategories
                            ObxValue((state) {
                              return Visibility(
                                visible: state.value > 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys
                                          .sub_categories_dropdown_label.tr,
                                      style: theme?.textTheme.bodySmall,
                                    ),
                                    SizedBox(
                                      height: 10.toHeight,
                                    ),
                                    TypeAheadField<SubCategory>(
                                      controller:
                                          controller.subcategoriesController,
                                      suggestionsCallback: (search) =>
                                          controller.searchSubCategory(search),
                                      builder:
                                          (context, controller, focusNode) {
                                        return NeuFormField(
                                          hintText: LocaleKeys
                                              .choose_sub_category_dropdown_label
                                              .tr,
                                          controller: controller,
                                          focusNode: focusNode,
                                          suffixIcon: Icon(
                                              Icons.keyboard_arrow_down_sharp),
                                        );
                                      },
                                      itemBuilder: (context, subcategory) {
                                        return ListTile(
                                          title: Text(
                                            Get.locale?.languageCode == 'fr'
                                                ? subcategory
                                                    .attributes!.nameFr!
                                                : subcategory
                                                    .attributes!.nameEn!,
                                          ),
                                        );
                                      },
                                      onSelected: (subcategory) {
                                        controller.selectedSubCategoryId.value =
                                            subcategory.id!;
                                        controller.getIngredientsSubcategory(
                                            subcategory.id);

                                        controller.searchIngredientsController
                                            .text = "";
                                        controller.userIngredientsController
                                            .text = "";
                                        controller
                                            .ingredientsSubCategoriesController
                                            .text = "";
                                        controller.subcategoriesController
                                            .text = Get.locale?.languageCode ==
                                                'fr'
                                            ? subcategory.attributes!.nameFr!
                                            : subcategory.attributes!.nameEn!;
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }, controller.selectedCategoryId),

                            //search in ingredients of subcategories
                            ObxValue((state) {
                              return Visibility(
                                visible: state.value > 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.ingredient_tab_label.tr,
                                      style: theme?.textTheme.bodySmall,
                                    ),
                                    SizedBox(
                                      height: 10.toHeight,
                                    ),
                                    TypeAheadField<Ingredient>(
                                      controller: controller
                                          .ingredientsSubCategoriesController,
                                      suggestionsCallback: (search) =>
                                          controller
                                              .searchIngredientsSubCategory(
                                                  search),
                                      builder:
                                          (context, controller, focusNode) {
                                        return NeuFormField(
                                          hintText: LocaleKeys
                                              .choose_ingredient_dropdown_label
                                              .tr,
                                          controller: controller,
                                          focusNode: focusNode,
                                          suffixIcon: Icon(
                                              Icons.keyboard_arrow_down_sharp),
                                        );
                                      },
                                      itemBuilder: (context, ingredient) {
                                        return ListTile(
                                          title: Text(
                                            Get.locale?.languageCode == 'fr'
                                                ? ingredient.attributes!.nameFr!
                                                : ingredient
                                                    .attributes!.nameEn!,
                                          ),
                                        );
                                      },
                                      onSelected: (ingredient) {
                                        controller.selectedIngredient =
                                            ingredient;

                                        controller.searchIngredientsController
                                            .text = "";
                                        controller.userIngredientsController
                                            .text = "";
                                        controller
                                            .ingredientsSubCategoriesController
                                            .text = Get.locale?.languageCode ==
                                                'fr'
                                            ? ingredient.attributes!.nameFr!
                                            : ingredient.attributes!.nameEn!;
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }, controller.selectedSubCategoryId),
                          ],
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        color: theme?.accentColor,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 300.toWidth),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.continue_button_label.tr,
                            style: theme?.textTheme.bodyMedium?.copyWith(
                              color: ColorConstants.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.toWidth,
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: ColorConstants.white,
                          ),
                        ],
                      ),
                      onPressed: () async {
                        if (controller.selectedIngredient.id! > 0) {
                          controller.initMeasurementUnits();
                          Get.toNamed(Routes.ADD_INGREDIENT_MEAL +
                              Routes.ADD_QUANTITY_MEAL);
                        }
                      },
                    ),
                    SizedBox(height: 20.toHeight),
                  ],
                ),
              );
      }, controller.loading),
    );
  }
}
