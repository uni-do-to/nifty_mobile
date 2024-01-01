import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/addToMeal/controllers/add_to_meal_controller.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/generated/locales.g.dart';
import '../data/models/unit_model.dart';

class AddQuantityWidget extends StatelessWidget {
  final NeumorphicThemeData theme;
  final List<Units> measurementUnitsItems;
  final Units? selectedMeasurementUnit;
  final TextEditingController quantityController;
  final Function(Units?) onMeasurementUnitChange;
  final Function(String) onQuantityChange;

  AddQuantityWidget({
    Key? key,
    required this.theme,
    required this.selectedMeasurementUnit,
    required this.measurementUnitsItems,
    required this.quantityController,
    required this.onMeasurementUnitChange,
    required this.onQuantityChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Neumorphic(
            style: NeumorphicStyle(depth: 1.3, intensity: 1),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.unit_drop_down_label.tr,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Neumorphic(
                  padding: EdgeInsets.only(left: 20),
                  style: NeumorphicStyle(
                    depth: NeumorphicTheme.embossDepth(context),
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                    color: Colors.transparent,
                    border: NeumorphicBorder(
                      width: 0.5,
                    ),
                  ),
                  child: DropdownButtonFormField<Units>(

                    value: selectedMeasurementUnit,
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
                SizedBox(
                  height: 8,
                ),
                Text(
                  selectedMeasurementUnit?.name ==
                          LocaleKeys.circle_unit_label.tr
                      ? LocaleKeys.circle_unit_label.tr
                      : selectedMeasurementUnit?.name ==
                              LocaleKeys.quantity_text_field_label.tr
                          ? LocaleKeys.quantity_text_field_label.tr
                          : selectedMeasurementUnit?.name ==
                                  LocaleKeys.minutes_unit_label.tr
                              ? LocaleKeys.duration_label.tr
                              : LocaleKeys.calories_burned_unit_label.tr,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                NeuFormField(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  hintText: LocaleKeys.quantity_text_field_label.tr,
                  controller: quantityController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true , signed: true),                  onChanged: (value) {
                    onQuantityChange(value);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
