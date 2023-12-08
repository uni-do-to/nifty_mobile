import 'package:date_format/date_format.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/daily_model.dart';
import 'package:nifty_mobile/app/data/providers/daily_provider.dart';

class DailyController extends GetxController {
  final DailyProvider provider ;

  Daily? daily ;

  RxList<Meals> meals = RxList(
    // [Meals()]
  ) ;

  final RxInt selectedMealTabIndex = 0.obs;
  final RxInt selectedSportTabIndex = 0.obs;

  RxString day = 'Today'.obs;

  RxList<String> sportsList = ['sport1', 'sport2', 'sport3'].obs;

  DailyController(this.provider) ;

  @override
  void onInit() {
    super.onInit();
    var today = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    getDaily(today);

  }

  void getDaily(String date) async {
    var results = await provider.getDaily(date) ;
    updateValues(results?.data?[0]) ;
  }

  void updateValues (Daily? newDaily) {
    if(newDaily != null){
      daily = newDaily ;
      meals.value = daily?.attributes?.meals??[];
    }
  }


  void addMeal() async {
    if(daily == null) {
      return ;
    }

    var newIndex = meals.length;
    daily?.attributes?.meals?.add(Meals(
      index: newIndex,
      title: "Meal $newIndex"
    ));

    var newDaily = await provider.editDaily(daily!) ;
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

  deleteItemFromMeal(int mealIndex, int itemIndex) async{
    if(daily == null) {
      return ;
    }

    meals[mealIndex].items?.removeAt(itemIndex) ;
    daily?.attributes?.updateDailyDetails() ;
    var newDaily = await provider.editDaily(daily!) ;
    updateValues(newDaily?.data) ;
  }

}
