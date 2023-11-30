import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';

import '../controllers/add_new_ingredient_controller.dart';

class AddNewIngredientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IngredientProvider>(
          () => IngredientProvider(),
    );
    Get.lazyPut<AddNewIngredientController>(
      () => AddNewIngredientController(Get.find()),
    );
  }
}
