import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/quantity_dropdown_item.dart';
import 'package:nifty_mobile/app/data/models/sports_response_model.dart';
import 'package:nifty_mobile/app/data/providers/sport_provider.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddSportController extends GetxController {
  final measurementUnitGramsController = TextEditingController();
  List<SportData> sportsList = [];

  RxBool isSportSelected = false.obs;
  RxBool sportListItemIsSelected = false.obs;
  RxBool loading = false.obs;
  Rx<SportData?> selectedSport = Rx(null);
  Rx<QuantityDropdownItem?> selectedMeasurementUnit = Rx(null);
  List<QuantityDropdownItem> measurementUnitsItems = [];

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
      this.sportsList = responseSportList.data ?? [];
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }

  initMeasurementUnits() {
    List<QuantityDropdownItem> items = [
      QuantityDropdownItem(name: LocaleKeys.minutes_unit_label.tr, minutes: 1),
    ];

    // Add calories burned per minutes if conditions are met
    if (selectedSport.value?.attributes?.caloriesPerMinute != null &&
        selectedSport.value!.attributes!.caloriesPerMinute! > 0) {
      items.add(QuantityDropdownItem(
          name: LocaleKeys.calories_unit_label.tr,
          grams: selectedSport.value?.attributes!.caloriesPerMinute!));
    }
    measurementUnitsItems = items;
    selectedMeasurementUnit.value = items[0];
  }
}
