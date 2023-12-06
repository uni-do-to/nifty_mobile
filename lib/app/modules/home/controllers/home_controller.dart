import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/middleware/auth_middleware.dart';
import 'package:nifty_mobile/app/modules/daily/bindings/daily_binding.dart';
import 'package:nifty_mobile/app/modules/daily/views/daily_view.dart';
import 'package:nifty_mobile/app/modules/ingredient/bindings/ingredient_binding.dart';
import 'package:nifty_mobile/app/modules/ingredient/views/ingredient_view.dart';
import 'package:nifty_mobile/app/modules/profile/bindings/profile_binding.dart';
import 'package:nifty_mobile/app/modules/profile/views/profile_view.dart';
import 'package:nifty_mobile/app/modules/recipe/bindings/recipe_binding.dart';
import 'package:nifty_mobile/app/modules/recipe/views/recipe_view.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';

class HomeController extends AuthController {
  var currentIndex = 0.obs;

  final pages = <String>[
    Routes.DAILY,
    Routes.RECIPE,
    Routes.INGREDIENT,
    Routes.PROFILE
  ];

  HomeController(super.authProvider);

  void changePage(int index) {
    currentIndex.value = index;
    Get.offAndToNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.DAILY) {
      return GetPageRoute(
        routeName: Routes.DAILY,
        page: () => const DailyView(),
        binding: DailyBinding(),
      );
    }

    if (settings.name == Routes.RECIPE) {
      return GetPageRoute(
        routeName: Routes.RECIPE,
        page: () => const RecipeView(),
        binding: RecipeBinding(),
      );
    }

    if (settings.name == Routes.INGREDIENT) {
      return GetPageRoute(
        routeName: Routes.INGREDIENT,
        page: () => const IngredientView(),
        binding: IngredientBinding(),
      );
    }
    if (settings.name == Routes.PROFILE) {
      return GetPageRoute(
        routeName: Routes.PROFILE,
        page: () => const ProfileView(),
        binding: ProfileBinding(),
      );
    }

    return null;
  }
}
