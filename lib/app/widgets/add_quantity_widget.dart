import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/addToMeal/controllers/add_to_meal_controller.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../data/models/quantity_dropdown_item.dart';

class AddQuantityWidget extends StatelessWidget {
  final NeumorphicThemeData theme;
  final List<QuantityDropdownItem> measurementUnitsItems;
  QuantityDropdownItem? selectedMeasurementUnit;
  final String quantityValue;
  final Function(QuantityDropdownItem?) onMeasurementUnitChange;
  final Function(String) onQuantityChange;

  AddQuantityWidget({
    Key? key,
    required this.theme,
    required this.selectedMeasurementUnit,
    required this.measurementUnitsItems,
    required this.quantityValue,
    required this.onMeasurementUnitChange,
    required this.onQuantityChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.toWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Neumorphic(
            style: NeumorphicStyle(depth: 1.3, intensity: 1),
            padding: EdgeInsets.symmetric(
                horizontal: 30.toWidth, vertical: 10.toHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.unit_drop_down_label.tr,
                  style: theme.textTheme.bodySmall,
                ),
                SizedBox(
                  height: 10.toHeight,
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                    depth: NeumorphicTheme.embossDepth(context),
                    boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                    color: Colors.transparent,
                    border: NeumorphicBorder(
                      width: 0.5,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.toWidth),
                  child: DropdownButtonFormField<QuantityDropdownItem>(
                    value: selectedMeasurementUnit,
                    onChanged: (newValue) {
                      onMeasurementUnitChange(newValue);
                    },
                    items:
                    measurementUnitsItems.map((QuantityDropdownItem item) {
                      return DropdownMenuItem<QuantityDropdownItem>(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10.toHeight,
                ),
                Text(
                  selectedMeasurementUnit?.name ==
                      LocaleKeys.circle_unit_label.tr
                      ? LocaleKeys.circle_unit_label.tr
                      : LocaleKeys.quantity_text_field_label.tr,
                  style: theme.textTheme.bodySmall,
                ),
                SizedBox(
                  height: 10.toHeight,
                ),
                NeuFormField(
                  hintText: LocaleKeys.quantity_text_field_label.tr,
                  initialValue: quantityValue,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    onQuantityChange(value);
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 20.toHeight),
        ],
      ),
    );
  }
}
