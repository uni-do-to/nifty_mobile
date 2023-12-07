import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/src/theme/theme.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/category_model.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/sub_category_model.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../modules/addToMeal/controllers/add_to_meal_controller.dart';

class AddIngredientFormWidget extends StatelessWidget {
  final NeumorphicThemeData theme;

  AddIngredientFormWidget({Key? key, required this.theme}) : super(key: key);
  AddToMealController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //search in admin ingredients
        Text(
          LocaleKeys.research_dropdown_label.tr,
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 6,
        ),
        TypeAheadField<Ingredient>(
          controller: controller.searchIngredientsController,
          suggestionsCallback: (search) => controller.searchIngredients(search),
          builder: (context, controller, focusNode) {
            return NeuFormField(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
              hintText: LocaleKeys.search_ingredients_dropdown_label.tr,
              controller: controller,
              focusNode: focusNode,
              suffixIcon: Icon(Icons.search),
              maintainErrorSize: false,
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
            controller.selectedIngredient.value = ingredient;
            controller.userIngredientsController.text = "";
            controller.categoriesController.text = "";
            controller.subcategoriesController.text = "";
            controller.ingredientsSubCategoriesController.text = "";
            controller.searchIngredientsController.text =
                Get.locale?.languageCode == 'fr'
                    ? ingredient.attributes!.nameFr!
                    : ingredient.attributes!.nameEn!;
            controller.initMeasurementUnits();
          },
        ),

        const SizedBox(
          height: 6,
        ),
        //search in user ingredient
        Text(
          LocaleKeys.personal_ingredient_dropdown_label.tr,
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 6,
        ),
        TypeAheadField<Ingredient>(
          controller: controller.userIngredientsController,
          suggestionsCallback: (search) => controller.searchIngredients(search),
          builder: (context, controller, focusNode) {
            return NeuFormField(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
              hintText: LocaleKeys.choose_ingredient_dropdown_label.tr,
              controller: controller,
              focusNode: focusNode,
              suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
              maintainErrorSize: false,
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
            controller.selectedIngredient.value = ingredient;
            controller.categoriesController.text = "";
            controller.subcategoriesController.text = "";
            controller.ingredientsSubCategoriesController.text = "";
            controller.searchIngredientsController.text = "";
            controller.userIngredientsController.text =
                Get.locale?.languageCode == 'fr'
                    ? ingredient.attributes!.nameFr!
                    : ingredient.attributes!.nameEn!;
            controller.initMeasurementUnits();
          },
        ),

        const SizedBox(height: 6),

        //search in categories
        Text(
          LocaleKeys.categories_dropdown_label.tr,
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
        ),
        const SizedBox(
          height: 6,
        ),
        TypeAheadField<Category>(
          controller: controller.categoriesController,
          suggestionsCallback: (search) => controller.searchCategory(search),
          builder: (context, controller, focusNode) {
            return NeuFormField(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
              hintText: LocaleKeys.choose_category_dropdown_label.tr,
              controller: controller,
              focusNode: focusNode,
              suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
              maintainErrorSize: false,
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
            controller.selectedCategoryId.value = categoryData.id!;
            controller.getSubcategory(categoryData.id);
            controller.searchIngredientsController.text = "";
            controller.userIngredientsController.text = "";
            controller.subcategoriesController.text = "";
            controller.ingredientsSubCategoriesController.text = "";
            controller.categoriesController.text =
                Get.locale?.languageCode == 'fr'
                    ? categoryData.attributes!.nameFr!
                    : categoryData.attributes!.nameEn!;
          },
        ),

        const SizedBox(
          height: 6,
        ),

        //search in subcategories
        ObxValue((state) {
          return Visibility(
            visible: state.value > 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.sub_categories_dropdown_label.tr,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 6),
                TypeAheadField<SubCategory>(
                  controller: controller.subcategoriesController,
                  suggestionsCallback: (search) =>
                      controller.searchSubCategory(search),
                  builder: (context, controller, focusNode) {
                    return NeuFormField(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                      hintText:
                          LocaleKeys.choose_sub_category_dropdown_label.tr,
                      controller: controller,
                      focusNode: focusNode,
                      suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      maintainErrorSize: false,
                    );
                  },
                  itemBuilder: (context, subcategory) {
                    return ListTile(
                      title: Text(
                        Get.locale?.languageCode == 'fr'
                            ? subcategory.attributes!.nameFr!
                            : subcategory.attributes!.nameEn!,
                      ),
                    );
                  },
                  onSelected: (subcategory) {
                    controller.selectedSubCategoryId.value = subcategory.id!;
                    controller.getIngredientsSubcategory(subcategory.id);

                    controller.searchIngredientsController.text = "";
                    controller.userIngredientsController.text = "";
                    controller.ingredientsSubCategoriesController.text = "";
                    controller.subcategoriesController.text =
                        Get.locale?.languageCode == 'fr'
                            ? subcategory.attributes!.nameFr!
                            : subcategory.attributes!.nameEn!;
                  },
                ),
              ],
            ),
          );
        }, controller.selectedCategoryId),

        const SizedBox(
          height: 6,
        ),

        //search in ingredients of subcategories
        ObxValue((state) {
          return Visibility(
            visible: state.value > 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.ingredient_tab_label.tr,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 6,
                ),
                TypeAheadField<Ingredient>(
                  controller: controller.ingredientsSubCategoriesController,
                  suggestionsCallback: (search) =>
                      controller.searchIngredientsSubCategory(search),
                  builder: (context, controller, focusNode) {
                    return NeuFormField(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                      hintText: LocaleKeys.choose_ingredient_dropdown_label.tr,
                      controller: controller,
                      focusNode: focusNode,
                      suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      maintainErrorSize: false,
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
                    controller.selectedIngredient.value = ingredient;

                    controller.searchIngredientsController.text = "";
                    controller.userIngredientsController.text = "";
                    controller.ingredientsSubCategoriesController.text =
                        Get.locale?.languageCode == 'fr'
                            ? ingredient.attributes!.nameFr!
                            : ingredient.attributes!.nameEn!;
                    controller.initMeasurementUnits();
                  },
                ),
              ],
            ),
          );
        }, controller.selectedSubCategoryId),
        SizedBox(
          height: 6,
        ),
      ],
    );
  }
}
