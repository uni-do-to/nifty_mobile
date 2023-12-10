import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/sports_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/data/providers/sport_provider.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddSportController extends GetxController {
  final measurementUnitGramsController = TextEditingController();
  List<Sport> sportsList = [];

  RxBool isSportSelected = false.obs;
  RxBool sportListItemIsSelected = false.obs;
  RxBool loading = false.obs;
  Rx<Sport?> selectedSport = Rx(null);
  Rx<Units?> selectedMeasurementUnit = Rx(null);
  List<Units> measurementUnitsItems = [];

  final SportProvider provider;

  AddSportController(this.provider);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
    try {
      loading.value = true;

      var responseSportList = await provider.getSportsList();
      this.sportsList = responseSportList?.data ?? [];
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }

  initMeasurementUnits() {
    List<Units> items = [
      Units(name: LocaleKeys.minutes_unit_label.tr, grams: 1),
    ];

    // Add calories burned per minutes if conditions are met
    if (selectedSport.value?.attributes?.caloriesPerMinute != null &&
        selectedSport.value!.attributes!.caloriesPerMinute! > 0) {
      items.add(Units(
          name: LocaleKeys.calories_unit_label.tr,
          grams: selectedSport.value?.attributes!.caloriesPerMinute!));
    }
    measurementUnitsItems = items;
    selectedMeasurementUnit.value = items[0];
  }
}
