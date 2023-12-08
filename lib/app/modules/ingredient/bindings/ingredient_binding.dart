import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';

import '../controllers/ingredient_controller.dart';

class IngredientBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<IngredientProvider>(
      () => IngredientProvider(),
    );
    Get.lazyPut<IngredientController>(
      () => IngredientController(Get.find()),
    );
  }
}
