import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';

import '../controllers/add_ingredient_meal_controller.dart';

class AddIngredientMealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IngredientProvider>(
      () => IngredientProvider(),
    );
    Get.put<AddIngredientMealController>(
      AddIngredientMealController(Get.find()),
    );
  }
}
