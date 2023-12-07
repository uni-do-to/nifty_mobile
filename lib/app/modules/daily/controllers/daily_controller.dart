import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class DailyController extends GetxController {
  final RxInt selectedMealTabIndex = 0.obs;
  final RxInt selectedSportTabIndex = 0.obs;

  RxString day = 'Today'.obs;
  RxList<String> mealsList = ['test1', 'test2', 'test3'].obs;
  RxList<String> sportsList = ['sport1', 'sport2', 'sport3'].obs;

  @override
  void onInit() {
    super.onInit();
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
