import 'package:get/get.dart';

import '../controllers/add_new_ingredient_controller.dart';

class AddNewIngredientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewIngredientController>(
      () => AddNewIngredientController(Get.find()),
    );
  }
}
