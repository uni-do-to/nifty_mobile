import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/recipe_provider.dart';

import '../controllers/recipe_controller.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeProvider>(
      () => RecipeProvider(),
    );

    Get.lazyPut<RecipeController>(
      () => RecipeController(Get.find()),
    );
  }
}
