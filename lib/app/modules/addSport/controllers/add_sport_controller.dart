import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/api_response.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/data/models/sports_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/data/providers/sport_provider.dart';
import 'package:nifty_mobile/app/services/auth_service.dart';
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
  TextEditingController sportQuantityController = TextEditingController();
  RxString sportQuantity = "".obs;

  RxBool isValidSportForm = false.obs ;
  final SportProvider provider;

  AddSportController(this.provider);

  @override
  void onInit() {
    super.onInit();
    initData();
    sportQuantityController.addListener(() {
      sportQuantity.value = sportQuantityController.text ;
    }) ;
  }

  Future initData() async {
    try {
      loading.value = true;

      var responseSportList = await provider.getSportsList();
      this.sportsList = responseSportList?.data ?? [];
      filteredItems.value = sportsList;
      selectedSport.value = filteredItems[0];
      initMeasurementUnits();

    } catch (err, _) {
      print(err);
    } finally {
      loading.value = false;
    }
  }

  initMeasurementUnits() {
    selectedMeasurementUnit.value = null;
    sportQuantityController.text = '';
    List<Units> items = [
      Units(name: LocaleKeys.minutes_unit_label.tr, id: 1),
      Units(name: LocaleKeys.calories_unit_label.tr, id: 2),
    ];

    // Add calories if conditions are met
    // if (selectedSport.value?.attributes?.caloriesPerMinute != null &&
    //     selectedSport.value!.attributes!.caloriesPerMinute! > 0) {
    //   items.add(Units(
    //       name: LocaleKeys.calories_unit_label.tr,
    //       grams: selectedSport.value?.attributes!.caloriesPerMinute!));
    // }

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

  bool isValidSportsForm() {
    var result = true;
    if (selectedSport.value == null) {
      print("No sport selected");
      result = false;
    }

    if (selectedMeasurementUnit.value == null) {
      print("No sport measurement unit selected");
      result = false;
    }

    if (sportQuantityController.text .isEmpty) {
      print("sport quantity not entered");
      result = false;
    }

    double quantity;
    try {
      quantity = double.parse(sportQuantityController.text.replaceAll(",", "."));
    } catch (e) {
      print("Invalid number for ingredient quantity");
      result = false;
    }
    // Here you can set a RxBool similar to isValidAddRecipe if needed
    isValidSportForm.value = result;
    return result;
  }

  void onAddSportToSports() {
    if (!isValidSportsForm())
      return;

    var quantity = double.parse(sportQuantityController.text.replaceAll(",", "."));
    print("adding $quantity   ${selectedMeasurementUnit.value?.id}" , ) ;
    var userWeight = Get.find<AuthService>().credentials?.user?.weight??0 ;
    // Assuming you have a way to calculate calories for the ingredient
    var calories = selectedMeasurementUnit.value?.id == 1 ? ((selectedSport.value!.attributes?.caloriesPerMinute??0) * quantity * userWeight) : quantity;

    print("adding $calories" , ) ;
    print("adding ${selectedSport.value!.attributes?.caloriesPerMinute}") ;


    // Assuming MealItem or a similar class is applicable for ingredients as well
    SportItem sportItem = SportItem(
      sport: ApiSingleResponse<Sport>(
          data: selectedSport.value
      ),
      calories: calories,
    );

    Get.back(result: sportItem);
  }
}
