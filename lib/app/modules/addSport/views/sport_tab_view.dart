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
                          Text(
                            LocaleKeys.research_dropdown_label.tr,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          NeuFormField(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            hintText:
                                LocaleKeys.search_sports_dropdown_label.tr,
                            controller: controller.searchSportsController,
                            suffixIcon: Icon(Icons.search),
                            maintainErrorSize: false,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            onChanged: (value) {
                              controller.filterSearchResults(value);
                            },
                          ),
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
                                                    "no search result",
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
              height: 177,
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
                              "Choisissez un élément dans la liste"
                          : controller
                                  .selectedSport.value?.attributes?.nameEn ??
                              "Choisissez un élément dans la liste",
                      quantityName:
                          controller.selectedMeasurementUnit.value?.name ??
                              "QTé",
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
                            text: 'Ajouter au sport',
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
