import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/form_field.dart';
import 'package:nifty_mobile/app/widgets/sport_list_item.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../controllers/add_sport_controller.dart';

class AddSportView extends GetView<AddSportController> {
  const AddSportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;
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
            Icon(Icons.fitness_center_sharp),
            SizedBox(
              width: 30.toWidth,
            ),
            Text(
              LocaleKeys.sport_budget_label.tr,
            ),
          ],
        ),
        iconTheme: theme?.iconTheme,
      ),
      body: ObxValue((state) {
        return state.value
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: theme?.textTheme.labelLarge?.color,
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 50.toWidth, vertical: 10.toHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Neumorphic(
                            style: NeumorphicStyle(depth: 1.2, intensity: 1),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.toWidth, vertical: 30.toHeight),
                            margin:
                                EdgeInsets.symmetric(horizontal: 90.toWidth),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '1',
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
                                      LocaleKeys.choose_title.tr,
                                      style:
                                          theme?.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.toFont,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.toHeight,
                                    ),
                                    Text(
                                      LocaleKeys.choose_sub_title.tr,
                                      style: theme?.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.toHeight,
                          ),
                          Text(
                            LocaleKeys.calculate_your_effort_title.tr,
                            style: theme?.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.toHeight,
                          ),
                          Text(
                            LocaleKeys.calculate_your_effort_sub_title.tr,
                            style: theme?.textTheme.bodySmall
                                ?.copyWith(height: 1.8),
                          ),
                          SizedBox(
                            height: 30.toHeight,
                          ),

                          //search in admin ingredients
                          Text(
                            LocaleKeys.intensity_physical_effort_sub_title.tr,
                            style: theme?.textTheme.bodySmall,
                          ),
                          SizedBox(
                            height: 20.toHeight,
                          ),

                          // sports list
                          Flexible(
                            child: ListView.builder(
                              itemCount: controller.sportsList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.only(bottom: 10.toHeight),
                                  child: SportListItem(
                                    controller: controller,
                                    sportItem: controller.sportsList[index],
                                    onClick: () {
                                      controller.sportListItemIsSelected.value =
                                          (controller.selectedSport ==
                                              controller.sportsList[index]);
                                      controller.initMeasurementUnits();
                                      controller.isSportSelected.value = true;
                                      controller.selectedSport.value =
                                          controller.sportsList[index];
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          ObxValue((state) {
                            return Visibility(
                              visible: state.value,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.toWidth),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Neumorphic(
                                      style: NeumorphicStyle(
                                          depth: 1.2, intensity: 1),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 90.toWidth,
                                          vertical: 30.toHeight),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.toWidth,
                                          vertical: 20.toHeight),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '2',
                                                style: theme
                                                    ?.textTheme.bodyMedium
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 25.toWidth,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    LocaleKeys
                                                        .quantity_screen_title
                                                        .tr,
                                                    style: theme
                                                        ?.textTheme.bodyMedium
                                                        ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.toHeight,
                                                  ),
                                                  Text(
                                                    LocaleKeys
                                                        .quantity_screen_sub_title
                                                        .tr,
                                                    style: theme
                                                        ?.textTheme.bodySmall,
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
                                              depth:
                                                  NeumorphicTheme.embossDepth(
                                                      context),
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                      BorderRadius.circular(8)),
                                              color: Colors.transparent,
                                              border: NeumorphicBorder(
                                                width: 0.5,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.toWidth),
                                            child: DropdownButtonFormField<
                                                Units>(
                                              value: controller
                                                  .selectedMeasurementUnit
                                                  .value,
                                              onChanged: (newValue) {
                                                controller
                                                    .selectedMeasurementUnit
                                                    .value = newValue;
                                              },
                                              items: controller
                                                  .measurementUnitsItems
                                                  .map((item) {
                                                return DropdownMenuItem<
                                                    Units>(
                                                  value: item,
                                                  child: Text(item.name!),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.toHeight,
                                          ),
                                          ObxValue((state) {
                                            return Text(
                                              state.value?.name ==
                                                      LocaleKeys
                                                          .calories_unit_label
                                                          .tr
                                                  ? LocaleKeys
                                                      .calories_burned_unit_label
                                                      .tr
                                                  : LocaleKeys
                                                      .duration_label.tr,
                                              style: theme?.textTheme.bodySmall,
                                            );
                                          },
                                              controller
                                                  .selectedMeasurementUnit),
                                          SizedBox(
                                            height: 10.toHeight,
                                          ),
                                          NeuFormField(
                                            hintText: 'ex : 60',
                                            controller: controller
                                                .measurementUnitGramsController,
                                            keyboardType: TextInputType.number,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            );
                          }, controller.isSportSelected)
                        ],
                      ),
                    ),
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        color: theme?.accentColor,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 300.toWidth),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                        if (controller.selectedSport.value != null &&
                            controller.selectedMeasurementUnit.value?.grams !=
                                null &&
                            controller.selectedMeasurementUnit.value!.grams! >
                                0) {
                          Get.offNamed(Routes.HOME, arguments: [
                            controller.selectedSport,
                            controller.selectedMeasurementUnit
                          ]);
                        }
                      },
                    ),
                    SizedBox(height: 20.toHeight),
                  ],
                ),
              );
      }, controller.loading),
    );
  }
}
