import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';

import '../controllers/my_ingredient_controller.dart';

class MyIngredientBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<IngredientProvider>(
      () => IngredientProvider(),
    );
    Get.lazyPut<MyIngredientController>(
      () => MyIngredientController(Get.find()),
    );
  }
}
