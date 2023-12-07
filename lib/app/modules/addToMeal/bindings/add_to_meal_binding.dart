import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';
import 'package:nifty_mobile/app/data/providers/recipe_provider.dart';

import '../controllers/add_to_meal_controller.dart';

class AddToMealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IngredientProvider>(
          () => IngredientProvider(),
    );
    Get.lazyPut<RecipeProvider>(
          () => RecipeProvider(),
    );
    Get.lazyPut<AddToMealController>(
      () => AddToMealController(Get.find(),Get.find()),
    );
  }
}
