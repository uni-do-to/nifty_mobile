import 'package:collection/collection.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/addToMeal/controllers/add_to_meal_controller.dart';
import 'package:nifty_mobile/app/modules/daily/controllers/daily_controller.dart';
import 'package:nifty_mobile/app/modules/daily/views/custom_tab_view.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/add_ingredient_widget.dart';
import 'package:nifty_mobile/app/widgets/add_quantity_widget.dart';
import 'package:nifty_mobile/app/widgets/daily_list_item.dart';
import 'package:nifty_mobile/app/widgets/selected_ingredient_recipe_item.dart';
import 'dart:collection';

import 'package:nifty_mobile/app/widgets/small_action_button.dart';

class IngredientTabView extends StatelessWidget {
  final NeumorphicThemeData theme;
  final String selectedMeal;

  AddToMealController controller = Get.find();

  IngredientTabView({Key? key, required this.theme, required this.selectedMeal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              right: 20.toWidth,
              left: 20.toWidth,
              top: 40.toHeight,
            ),
            child: Row(
              children: [
                SmallActionButton(
                  text: 'Ajouter un nouvel Ingrédient',
                  backgroundColor: Color(0xff42A4A0),
                  textColor: Colors.white,
                  fontSize: 24.toFont,
                  height: 35.toHeight,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.INGREDIENT);
                  },
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.toHeight,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.toWidth),
            child: ObxValue((state) {
              return state.value
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: theme.textTheme.labelLarge?.color,
                      ),
                    )
                  : Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: AddIngredientFormWidget(
                          theme: theme,
                        ),
                      ),
                    );
            }, controller.loading),
          ),
          ObxValue((state) {
            return Container(
              child: AddQuantityWidget(
                theme: theme,
                measurementUnitsItems: controller.measurementUnitsItems,
                selectedMeasurementUnit:
                    controller.selectedMeasurementUnit.value,
                quantityValue: controller.quantity.value,
                onMeasurementUnitChange: (unit) =>
                    controller.selectedMeasurementUnit.value = unit,
                onQuantityChange: (value) => controller.quantity.value = value,
              ),
            );
          }, controller.selectedMeasurementUnit),
          Obx(
            () {
              return Column(
                children: [
                  Container(
                    child: SelectedIngredientRecipeItem(
                      theme: theme,
                      selectedItemName: Get.locale?.languageCode == 'fr'
                          ? controller.selectedIngredient.value?.attributes
                                  ?.nameFr ??
                              "Choisissez un élément dans la liste"
                          : controller.selectedIngredient.value?.attributes
                                  ?.nameEn ??
                              "Choisissez un élément dans la liste",
                      quantityName:
                          controller.selectedMeasurementUnit.value?.name ??
                              "QTé",
                      quantityValue: controller.quantity.value,
                      isChecked:
                          controller.selectedIngredient.value?.attributes !=
                                  null &&
                              controller.selectedMeasurementUnit.value != null,
                    ),
                  ),
                  SizedBox(
                    height: 15.toHeight,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      SmallActionButton(
                        height: 25,
                        text: 'Ajouter au repas',
                        backgroundColor: controller
                                        .selectedIngredient.value?.attributes !=
                                    null &&
                                controller.selectedMeasurementUnit.value != null
                            ? Color(0xff274C5B)
                            : Color(0xff274C5B).withOpacity(0.4),
                        textColor: Colors.white,
                        onPressed: () {
                          if (controller.selectedIngredient.value != null &&
                              controller.selectedMeasurementUnit.value != null &&
                              controller.quantity.value != "0") {
                            Get.back();
                          }
                          //TODO add your ingredient to ingredient list inside selected meal object
                        },
                        // Optionally, specify width and height
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
