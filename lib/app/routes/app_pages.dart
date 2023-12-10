import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/addNewRecipe/views/add_recipe_ingredient_view.dart';
import 'package:nifty_mobile/app/modules/addNewRecipe/views/recipe_ingredient_tab.dart';

import '../middleware/auth_middleware.dart';
import '../modules/addNewIngredient/bindings/add_new_ingredient_binding.dart';
import '../modules/addNewIngredient/views/add_new_ingredient_view.dart';
import '../modules/addNewRecipe/bindings/add_new_recipe_binding.dart';
import '../modules/addNewRecipe/views/add_new_recipe_view.dart';
import '../modules/addSport/bindings/add_sport_binding.dart';
import '../modules/addSport/views/add_sport_view.dart';
import '../modules/addToMeal/bindings/add_to_meal_binding.dart';
import '../modules/addToMeal/views/add_to_meal_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding(),
        middlewares: [NotAuthMiddleware()]),
    GetPage(
        name: _Paths.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBinding(),
        middlewares: [NotAuthMiddleware()]),
    GetPage(
        name: _Paths.SUBSCRIPTION,
        page: () => const SubscriptionView(),
        binding: SubscriptionBinding(),
        middlewares: [NotAuthMiddleware()]),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_TO_MEAL,
      page: () => const AddToMealView(),
      binding: AddToMealBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_NEW_INGREDIENT,
      page: () => const AddNewIngredientView(),
      binding: AddNewIngredientBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_SPORT,
      page: () => const AddSportView(),
      binding: AddSportBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
        name: _Paths.ADD_NEW_RECIPE,
        page: () => const AddNewRecipeView(),
        binding: AddNewRecipeBinding(),
        middlewares: [
          AuthMiddleware()
        ],
        children: [
          GetPage(
            name: _Paths.RECIPE_INGREDIENT_TAB,
            page: () =>const AddRecipeIngredientView(),
            middlewares: [AuthMiddleware()],
          ),
        ]),
  ];
}
