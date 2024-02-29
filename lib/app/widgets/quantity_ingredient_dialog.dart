import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/utils/input_formatters.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/selected_ingredient_recipe_item.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class QuantityIngredientDialogWidget extends StatelessWidget {
  final RxString ingredientQuantity;
  final Rx<Ingredient?> selectedIngredient;
  final List<Units> measurementUnitsItems;
  final Rx<Units?> selectedMeasurementUnit;
  final TextEditingController quantityController;
  final Function(Units?) onMeasurementUnitChange;
  final Function() onCancelClicked;
  final Function() onAddClicked;

  QuantityIngredientDialogWidget({
    Key? key,
    required this.selectedIngredient,
    required this.measurementUnitsItems,
    required this.selectedMeasurementUnit,
    required this.quantityController,
    required this.onMeasurementUnitChange,
    required this.onCancelClicked,
    required this.onAddClicked,
    required this.ingredientQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            LocaleKeys.quantity_text_field_label.tr,
            style: TextStyle(
              color: ColorConstants.accentColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.unit_drop_down_label.tr,
                  style: theme?.textTheme.bodySmall?.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Neumorphic(
                  padding: const EdgeInsets.only(left: 20),
                  style: NeumorphicStyle(
                    depth: NeumorphicTheme.embossDepth(context),
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                    color: Colors.transparent,
                    border: const NeumorphicBorder(
                      width: 0.5,
                    ),
                  ),
                  child: DropdownButtonFormField<Units>(
                    value: selectedMeasurementUnit.value,
                    onChanged: (newValue) {
                      onMeasurementUnitChange(newValue);
                    },
                    items: measurementUnitsItems.map((Units item) {
                      return DropdownMenuItem<Units>(
                        value: item,
                        child: Text(item.name!),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  LocaleKeys.quantity_text_field_label.tr,
                  style: theme?.textTheme.bodySmall?.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                NeuFormField(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  hintText: LocaleKeys.quantity_text_field_label.tr,
                  controller: quantityController,
                  inputFormatters: [
                    DecimalTextInputFormatter(decimalRange: 2),
                  ],
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                  onChanged: (value) {
                    (value) => {};
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  margin: const EdgeInsets.only(bottom: 24),
                  child: SmallActionButton(
                    text: LocaleKeys.cancel_button_label.tr,
                    backgroundColor: selectedIngredient.value?.attributes != null
                        ? ColorConstants.accentColor
                        : ColorConstants.accentColor.withOpacity(0.4),
                    textColor: Colors.white,
                    onPressed: onCancelClicked,
                    // Optionally, specify width and height
                  ),
                ),
                Container(
                  height: 45,
                  margin: const EdgeInsets.only(bottom: 24),
                  child: SmallActionButton(
                    text: LocaleKeys.add_to_meal_button_label.tr,
                    backgroundColor: selectedIngredient.value?.attributes != null
                        ? ColorConstants.accentColor
                        : ColorConstants.accentColor.withOpacity(0.4),
                    textColor: Colors.white,
                    onPressed: onAddClicked,
                    // Optionally, specify width and height
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 61,
            child: Obx(() {
              return SelectedIngredientRecipeItem(
                theme: theme!,
                selectedItemName: Get.locale?.languageCode == 'fr'
                    ? selectedIngredient.value?.attributes?.nameFr ??
                        LocaleKeys.selected_ingredient_recipe_hint_label.tr
                    : selectedIngredient.value?.attributes?.nameEn ??
                        LocaleKeys.selected_ingredient_recipe_hint_label.tr,
                quantityName: selectedMeasurementUnit.value?.name ??
                    LocaleKeys.quantity_of_selected_item_hint.tr,
                quantityValue: ingredientQuantity.value,
                isChecked: selectedIngredient.value?.attributes != null,
              );
            }),
          ),
        ],
      ),
    );
  }
}
