import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/src/theme/theme.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/ingredient_model.dart';
import 'package:nifty_mobile/app/data/models/quantity_dropdown_item.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class SelectedIngredientRecipeItem extends StatelessWidget {
  final NeumorphicThemeData theme;
  final String selectedItemName;
  final String quantityName;
  final String quantityValue;
  final bool isChecked;

  SelectedIngredientRecipeItem({
    Key? key,
    required this.theme,
    required this.selectedItemName,
    required this.quantityName,
    required this.quantityValue,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 21),
      color: ColorConstants.mainThemeColor.withOpacity(0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              selectedItemName,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 18,
                color: isChecked
                    ? ColorConstants.accentColor
                    : ColorConstants.accentColor.withOpacity(0.22),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            quantityValue != 0 ? quantityValue.toString() : "",
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isChecked
                  ? ColorConstants.accentColor
                  : ColorConstants.accentColor.withOpacity(0.22),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            quantityName,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isChecked
                  ? ColorConstants.accentColor
                  : ColorConstants.accentColor.withOpacity(0.22),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Icon(
            Icons.check_circle,
            size: 25.02,
            color: isChecked
                ? ColorConstants.accentColor
                : ColorConstants.accentColor.withOpacity(0.22),
          )
        ],
      ),
    );
  }
}
