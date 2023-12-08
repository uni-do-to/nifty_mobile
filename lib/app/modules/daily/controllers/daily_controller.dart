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
    daily = results!.data?[0] ;
    meals.value = daily?.attributes?.meals??[];
  }


  void addMeal() async {
    if(daily == null)
      return ;
    daily?.attributes?.meals?.add(Meals(
      index: selectedMealTabIndex.value + 1
    ));

    await provider.editDaily(daily!) ;
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
