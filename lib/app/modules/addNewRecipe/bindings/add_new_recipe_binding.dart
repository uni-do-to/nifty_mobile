import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/ingredient_controller.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';
import 'package:nifty_mobile/app/data/providers/recipe_provider.dart';

import '../controllers/add_new_recipe_controller.dart';

class AddNewRecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeProvider>(
      () => RecipeProvider(),
    );
    Get.lazyPut<IngredientProvider>(
      () => IngredientProvider(),
    );

    Get.lazyPut<IngredientController>(
        ()=>IngredientController(Get.find())
    );

    Get.put<AddNewRecipeController>(
      AddNewRecipeController(Get.find()),
    );
  }
}
