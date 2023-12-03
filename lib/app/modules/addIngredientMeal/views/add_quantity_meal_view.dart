import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/quantity_dropdown_item.dart';
import 'package:nifty_mobile/app/modules/addIngredientMeal/controllers/add_ingredient_meal_controller.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/ingredient_list_item.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddQuantityMealView extends GetView<AddIngredientMealController> {
  const AddQuantityMealView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;
    print(controller.selectedIngredient.toJson());
    print(controller.measurementUnitsItems.length);
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 70.toWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Neumorphic(
              style: NeumorphicStyle(depth: 1.2, intensity: 1),
              padding: EdgeInsets.symmetric(
                  horizontal: 90.toWidth, vertical: 30.toHeight),
              margin: EdgeInsets.symmetric(
                  horizontal: 20.toWidth, vertical: 30.toHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '2',
                        style: theme?.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 25.toWidth,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.quantity_screen_title.tr,
                            style: theme?.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.toHeight,
                          ),
                          Text(
                            LocaleKeys.quantity_screen_sub_title.tr,
                            style: theme?.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.toHeight,
                  ),
                  Text(
                    LocaleKeys.unit_drop_down_label.tr,
                    style: theme?.textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 10.toHeight,
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      depth: NeumorphicTheme.embossDepth(context),
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                      color: Colors.transparent,
                      border: NeumorphicBorder(
                        width: 0.5,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.toWidth),
                    child: DropdownButtonFormField<QuantityDropdownItem>(
                      value: controller.selectedMeasurementUnit.value,
                      onChanged: (newValue) {
                        controller.selectedMeasurementUnit.value = newValue;
                      },
                      items: controller.measurementUnitsItems
                          .map((QuantityDropdownItem item) {
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
                  ObxValue((state) {
                    return Text(
                      state.value?.name == LocaleKeys.circle_unit_label.tr
                          ? LocaleKeys.circle_unit_label.tr
                          : LocaleKeys.quantity_text_field_label.tr,
                      style: theme?.textTheme.bodySmall,
                    );
                  }, controller.selectedMeasurementUnit),
                  SizedBox(
                    height: 10.toHeight,
                  ),
                  NeuFormField(
                    hintText: LocaleKeys.quantity_text_field_label.tr,
                    controller: controller.measurementUnitGramsController,
                    keyboardType: TextInputType.number,
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              LocaleKeys.your_ingredient_label.tr,
              style: theme?.textTheme.labelLarge,
            ),
            SizedBox(height: 20),
            IngredientListItem(
              text: Get.locale?.languageCode == 'fr'
                  ? controller.selectedIngredient.attributes!.nameFr!
                  : controller.selectedIngredient.attributes!.nameEn!,
            ),
            Expanded(child: Container()),
            NeumorphicButton(
              style: NeumorphicStyle(
                color: theme?.accentColor,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(8),
                ),
              ),
              margin: EdgeInsets.only(left: 300.toWidth),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                if (controller.selectedMeasurementUnit.value?.grams != null &&
                    controller.selectedMeasurementUnit.value!.grams! > 0) {
                  Get.offNamed(Routes.HOME, arguments: [
                    controller.selectedIngredient,
                    controller.selectedMeasurementUnit
                  ]);
                }
              },
            ),
            SizedBox(height: 20.toHeight),
          ],
        ),
      ),
    );
  }
}
