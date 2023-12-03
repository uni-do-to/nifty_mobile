import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/recipe_provider.dart';

import '../controllers/add_recipe_meal_controller.dart';

class AddRecipeMealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeProvider>(
      () => RecipeProvider(),
    );
    Get.lazyPut<AddRecipeMealController>(
      () => AddRecipeMealController(Get.find()),
    );
  }
}
