import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/data/models/sports_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/data/providers/sport_provider.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddSportController extends GetxController {
  Sports selectedSportDaily = Get.arguments ?? "";

  final searchSportsController = TextEditingController();
  final measurementUnitGramsController = TextEditingController();

  List<Sport> sportsList = [];
  RxList<Sport> filteredItems = RxList();
  Rx<Units?> selectedMeasurementUnit = Rx(null);
  List<Units> measurementUnitsItems = [];
  Rx<Sport?> selectedSport = Rx(null);

  RxBool isSportSelected = false.obs;
  RxBool sportListItemIsSelected = false.obs;
  RxBool loading = false.obs;
  RxString sportQuantity = "0".obs;

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
      filteredItems.value = sportsList;
    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }

  initMeasurementUnits() {
    selectedMeasurementUnit.value = null;
    sportQuantity.value = '0';
    List<Units> items = [
      Units(name: LocaleKeys.minutes_unit_label.tr, grams: 1),
    ];

    // Add calories if conditions are met
    if (selectedSport.value?.attributes?.caloriesPerMinute != null &&
        selectedSport.value!.attributes!.caloriesPerMinute! > 0) {
      items.add(Units(
          name: LocaleKeys.calories_unit_label.tr,
          grams: selectedSport.value?.attributes!.caloriesPerMinute!));
    }

    measurementUnitsItems = items;
    selectedMeasurementUnit.value = items[0];
  }

  void filterSearchResults(String query) {
    List<Sport> dummySearchList = [];
    dummySearchList.addAll(sportsList);

    if (query.isNotEmpty) {
      filteredItems.value = dummySearchList.where((sport) {
        bool matchesKeyword = sport.attributes!.nameEn!
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            sport.attributes!.nameFr!
                .toLowerCase()
                .contains(query.toLowerCase());

        return matchesKeyword;
      }).toList();
      return;
    } else {
      filteredItems.value = sportsList;
    }
  }
}
