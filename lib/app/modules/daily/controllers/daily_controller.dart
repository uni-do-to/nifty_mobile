import 'package:date_format/date_format.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/data/providers/daily_provider.dart';

class DailyController extends GetxController {
  final DailyProvider provider;

  final Rx<Daily?> daily = Rx(null);

  RxList<Meals> meals = RxList(
      // [Meals()]
      );

  RxList<Sports> sports = RxList() ;

  final RxInt selectedMealTabIndex = 0.obs;
  final RxInt selectedSportTabIndex = 0.obs;

  RxString day = 'Today'.obs;

  DailyController(this.provider);

  @override
  void onInit() {
    super.onInit();
    getDaily(DateTime.now());

  }

  void getDaily(DateTime date) async {
    var dateFormatted = formatDate(date, [yyyy, '-', mm, '-', dd]);

    Daily? daily ;
    // try {
      var results = await provider.getDaily(dateFormatted);
      if((results?.data?.length??0) > 0 ){
        daily = results?.data?[0] ;
      }else {
        var results = await provider.createDaily(dateFormatted);
        if(results?.data != null){
          daily = results?.data ;
        }
      }
      updateValues(daily) ;

    // }catch (e) {
    //   print(e);
    // }
  }

  void updateValues (Daily? newDaily) {
    if(newDaily != null){
      daily.value = newDaily ;
      meals.value = daily.value?.attributes?.meals??[];
      sports.value = daily.value?.attributes?.sports??[] ;
    }
  }


  void addMeal() async {
    if (daily.value == null) {
      return;
    }

    var newIndex = meals.length;
    daily.value?.attributes?.meals
        ?.add(Meals(index: newIndex, title: "Meal $newIndex"));

    var newDaily = await provider.editDaily(daily.value!);
    updateValues(newDaily?.data);
  }

  void addSport() async{
    if(daily.value == null) {
      return ;
    }

    var newIndex = sports.length;
    daily.value?.attributes?.sports?.add(Sports(
        index: newIndex,
        title: "Sport $newIndex"
    ));

    var newDaily = await provider.editDaily(daily.value!) ;
    updateValues(newDaily?.data) ;
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  deleteItemFromMeal(int mealIndex, int itemIndex) async {
    if (daily.value == null) {
      return;
    }

    meals[mealIndex].items?.removeAt(itemIndex);
    daily.value?.attributes?.updateDailyDetails();
    var newDaily = await provider.editDaily(daily.value!);
    updateValues(newDaily?.data);
  }

  deleteItemFromSport(int tabIndex, int itemIndex) async{
    if(daily == null) {
      return ;
    }

    sports[tabIndex].items?.removeAt(itemIndex) ;
    daily.value?.attributes?.updateDailyDetails() ;
    var newDaily = await provider.editDaily(daily.value!) ;
    updateValues(newDaily?.data) ;
  }


  Meals? getSelectedMeal() {
    if (meals.length > selectedMealTabIndex.value) {
      return meals[selectedMealTabIndex.value];
    }
    return null;
  }

  Sports? getSelectedSport() {
    if(sports.length > selectedSportTabIndex.value){
      return sports[selectedSportTabIndex.value] ;
    }
    return null ;
  }


  void addToMeal(MealItem results) async{
    var selectedMeal = getSelectedMeal() ;
    var index = selectedMeal?.items?.indexWhere(
            (e) => e.ingredient?.data?.id == results.ingredient?.data?.id || e.recipe?.data?.id == results.recipe?.data?.id);

    // print(selectedMeal?.items?.map((e) => e.ingredient?.data?.id)) ;
    // print(results?.ingredient?.data?.id);
    // print(index) ;
    //
    // if (selectedMeal != null && selectedMeal.items != null && index != null && index != -1) {
    //   // Ingredient exists, update quantity and calories
    //   selectedMeal.items![index].weight =
    //       selectedMeal.items![index].weight??0 + (results.weight ?? 0);
    //   selectedMeal.items![index].calories =
    //       (selectedMeal.items![index].calories ?? 0) +
    //           (results.calories ?? 0);
    // } else {
      // Ingredient does not exist, add it to the list
      selectedMeal?.items?.add(results);
    // }
    daily.value?.attributes?.updateDailyDetails() ;
    var newDaily = await provider.editDaily(daily.value!) ;
    updateValues(newDaily?.data) ;
  }

  void addToSport(SportItem results) async{
    var selectedSport = getSelectedSport() ;

    selectedSport?.items?.add(results);
    // }
    daily.value?.attributes?.updateDailyDetails() ;
    var newDaily = await provider.editDaily(daily.value!) ;
    updateValues(newDaily?.data) ;
  }




}
