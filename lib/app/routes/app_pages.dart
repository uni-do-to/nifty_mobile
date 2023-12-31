import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../modules/addNewIngredient/bindings/add_new_ingredient_binding.dart';
import '../modules/addNewIngredient/views/add_new_ingredient_view.dart';
import '../modules/addNewRecipe/bindings/add_new_recipe_binding.dart';
import '../modules/addNewRecipe/views/add_new_recipe_view.dart';
import '../modules/addNewRecipe/views/add_recipe_ingredient_view.dart';
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
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import 'scale_widget.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => ScaleWidget(
            builder: (context, child) => scaleWidgetBuilder(context, child!),
            child: LoginView()),
        binding: LoginBinding(),
        middlewares: [NotAuthMiddleware()]),
    GetPage(
        name: _Paths.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBinding(),
        middlewares: [NotAuthMiddleware()]),
    GetPage(
        name: _Paths.SUBSCRIPTION,
        page: () => SubscriptionView(),
        binding: SubscriptionBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: _Paths.HOME,
      page: () => ScaleWidget(
          builder: (context, child) => scaleWidgetBuilder(context, child!),
          child: const HomeView()),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_TO_MEAL,
      page: () => ScaleWidget(
          builder: (context, child) => scaleWidgetBuilder(context, child!),
          child: const AddToMealView()),
      binding: AddToMealBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_NEW_INGREDIENT,
      page: () => ScaleWidget(
          builder: (context, child) => scaleWidgetBuilder(context, child!),
          child: const AddNewIngredientView()),
      binding: AddNewIngredientBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_SPORT,
      page: () => ScaleWidget(
          builder: (context, child) => scaleWidgetBuilder(context, child!),
          child: const AddSportView()),
      binding: AddSportBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
        name: _Paths.ADD_NEW_RECIPE,
        page: () => ScaleWidget(
            builder: (context, child) => scaleWidgetBuilder(context, child!),
            child: const AddNewRecipeView()),
        binding: AddNewRecipeBinding(),
        middlewares: [
          AuthMiddleware()
        ],
        children: [
          GetPage(
            name: _Paths.RECIPE_INGREDIENT_TAB,
            page: () => ScaleWidget(
                builder: (context, child) =>
                    scaleWidgetBuilder(context, child!),
                child: const AddRecipeIngredientView()),
            middlewares: [AuthMiddleware()],
          ),
        ]),
  ];
}
