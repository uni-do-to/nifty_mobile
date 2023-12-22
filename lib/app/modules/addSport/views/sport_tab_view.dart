import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/modules/addSport/controllers/add_sport_controller.dart';
import 'package:nifty_mobile/app/widgets/add_quantity_widget.dart';
import 'package:nifty_mobile/app/widgets/delete_alert_dialog.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/recipe_ingredient_list_item.dart';
import 'package:nifty_mobile/app/widgets/selected_ingredient_recipe_item.dart';

import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class SportTabView extends StatelessWidget {
  final NeumorphicThemeData theme;
  final Sports selectedSport;
  final void Function() onAddSportToDaily;

  AddSportController controller = Get.find();

  SportTabView(
      {Key? key,
      required this.theme,
      required this.selectedSport,
      required this.onAddSportToDaily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ObxValue((state) {
            return state.value
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: theme.textTheme.labelLarge?.color,
                    ),
                  )
                : Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        right: 17,
                        left: 17,
                        top: 15.6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: ObxValue((state) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: controller.filteredItems.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.selectedSport.value =
                                              controller.filteredItems[index];
                                          controller.initMeasurementUnits();
                                        },
                                        child: ObxValue((state) {
                                          return RecipeIngredientListItem(
                                            isSportItem: true,
                                            isSelected: controller
                                                    .selectedSport.value ==
                                                controller.filteredItems[index],
                                            icon: Icons.fitness_center_sharp,
                                            text: Get.locale?.languageCode ==
                                                    "fr"
                                                ? controller
                                                    .filteredItems[index]
                                                    .attributes!
                                                    .nameFr!
                                                : controller
                                                        .filteredItems[index]
                                                        .attributes!
                                                        .nameEn ??
                                                    LocaleKeys
                                                        .no_search_result_label
                                                        .tr,
                                            onDeletePressed: () {},
                                          );
                                        }, controller.selectedSport),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, controller.filteredItems),
                          ),
                        ],
                      ),
                    ),
                  );
          }, controller.loading),
          ObxValue((state) {
            return Container(
              height: 200,
              child: AddQuantityWidget(
                theme: theme,
                measurementUnitsItems: controller.measurementUnitsItems,
                selectedMeasurementUnit:
                    controller.selectedMeasurementUnit.value,
                quantityValue: controller.sportQuantity.value,
                onMeasurementUnitChange: (unit) =>
                    controller.selectedMeasurementUnit.value = unit,
                onQuantityChange: (value) =>
                    controller.sportQuantity.value = value,
              ),
            );
          }, controller.selectedMeasurementUnit),
          const SizedBox(
            height: 11,
          ),
          Obx(
            () {
              return Column(
                children: [
                  Container(
                    child: SelectedIngredientRecipeItem(
                      theme: theme,
                      selectedItemName: Get.locale?.languageCode == 'fr'
                          ? controller
                                  .selectedSport.value?.attributes?.nameFr ??
                              LocaleKeys
                                  .selected_ingredient_recipe_hint_label.tr
                          : controller
                                  .selectedSport.value?.attributes?.nameEn ??
                              LocaleKeys
                                  .selected_ingredient_recipe_hint_label.tr,
                      quantityName:
                          controller.selectedMeasurementUnit.value?.name ??
                              LocaleKeys.quantity_of_selected_item_hint.tr,
                      quantityValue: controller.sportQuantity.value,
                      isChecked:
                          controller.selectedSport.value?.attributes != null &&
                              controller.selectedMeasurementUnit.value != null,
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        height: 54,
                        padding: const EdgeInsets.only(right: 24),
                        child: SmallActionButton(
                            width: 181,
                            text: LocaleKeys.add_to_sport_screen_title.tr,
                            backgroundColor: controller
                                            .selectedSport.value?.attributes !=
                                        null &&
                                    controller.selectedMeasurementUnit.value !=
                                        null
                                ? ColorConstants.accentColor
                                : ColorConstants.accentColor.withOpacity(0.4),
                            textColor: Colors.white,
                            onPressed: onAddSportToDaily
                            // Optionally, specify width and height
                            ),
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
