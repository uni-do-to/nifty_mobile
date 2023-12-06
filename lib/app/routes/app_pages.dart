import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/daily/bindings/daily_binding.dart';
import 'package:nifty_mobile/app/modules/daily/views/daily_view.dart';
import 'package:nifty_mobile/app/modules/ingredient/bindings/ingredient_binding.dart';
import 'package:nifty_mobile/app/modules/ingredient/views/ingredient_view.dart';
import 'package:nifty_mobile/app/modules/profile/bindings/profile_binding.dart';
import 'package:nifty_mobile/app/modules/profile/views/profile_view.dart';
import 'package:nifty_mobile/app/modules/recipe/bindings/recipe_binding.dart';
import 'package:nifty_mobile/app/modules/recipe/views/recipe_view.dart';

import '../middleware/auth_middleware.dart';
import '../modules/addIngredientMeal/bindings/add_ingredient_meal_binding.dart';
import '../modules/addIngredientMeal/views/add_ingredient_meal_view.dart';
import '../modules/addIngredientMeal/views/add_quantity_meal_view.dart';
import '../modules/addNewIngredient/bindings/add_new_ingredient_binding.dart';
import '../modules/addNewIngredient/views/add_new_ingredient_view.dart';
import '../modules/addRecipeMeal/bindings/add_recipe_meal_binding.dart';
import '../modules/addRecipeMeal/views/add_recipe_meal_view.dart';
import '../modules/addSport/bindings/add_sport_binding.dart';
import '../modules/addSport/views/add_sport_view.dart';
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
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: _Paths.ADD_NEW_INGREDIENT,
      page: () => const AddNewIngredientView(),
      binding: AddNewIngredientBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
        name: _Paths.ADD_INGREDIENT_MEAL,
        page: () => const AddIngredientMealView(),
        binding: AddIngredientMealBinding(),
        middlewares: [
          AuthMiddleware()
        ],
        children: [
          GetPage(
            name: _Paths.ADD_QUANTITY_MEAL,
            page: () => const AddQuantityMealView(),
            middlewares: [AuthMiddleware()],
          ),
        ]),
    GetPage(
      name: _Paths.ADD_RECIPE_MEAL,
      page: () => const AddRecipeMealView(),
      binding: AddRecipeMealBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_SPORT,
      page: () => const AddSportView(),
      binding: AddSportBinding(),
      middlewares: [AuthMiddleware()],
    )
  ];
}
