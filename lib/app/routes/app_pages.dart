import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/register/views/about_you_view.dart';
import 'package:nifty_mobile/app/modules/register/views/nifty_points_view.dart';
import 'package:nifty_mobile/app/modules/register/views/your_bmi_view.dart';

import '../middleware/auth_middleware.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding(),
        middlewares: [NotAuthMiddleware()]),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_YOU,
      page: () => AboutYouView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.YOUR_BMI,
      page: () => const YourBmiView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.NIFTY_POINTS,
      page: () => const NiftyPointsView(),
      binding: RegisterBinding(),
    ),
  ];
}
