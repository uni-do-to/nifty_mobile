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
      height: 90.toHeight,
      padding:
          EdgeInsets.symmetric(vertical: 20.toHeight, horizontal: 20.toWidth),
      color: Color(0xff42A4A0).withOpacity(0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              selectedItemName,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 30.toFont,
                color: isChecked
                    ? ColorConstants.accentColor
                    : ColorConstants.accentColor.withOpacity(0.22),
              ),
            ),
          ),
          SizedBox(
            width: 20.toWidth,
          ),
          Text(
            quantityValue != 0 ? quantityValue.toString() : "",
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 30.toFont,
              fontWeight: FontWeight.bold,
              color: isChecked
                  ? ColorConstants.accentColor
                  : ColorConstants.accentColor.withOpacity(0.22),
            ),
          ),
          Text(
            quantityName,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 30.toFont,
              fontWeight: FontWeight.bold,
              color: isChecked
                  ? ColorConstants.accentColor
                  : ColorConstants.accentColor.withOpacity(0.22),
            ),
          ),
          SizedBox(
            width: 20.toWidth,
          ),
          Icon(
            Icons.check_circle,
            size: 25,
            color: isChecked
                ? ColorConstants.accentColor
                : ColorConstants.accentColor.withOpacity(0.22),
          )
        ],
      ),
    );
  }
}
