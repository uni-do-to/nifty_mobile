import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddNewIngredientController extends AuthController {
  final GlobalKey<FormState> addIngredientFormKey = GlobalKey<FormState>();
  final ingredientNameFranceController = TextEditingController();
  final ingredientNameEnglishController = TextEditingController();
  final gramsPerCircleController = TextEditingController();
  final caloriesPerGramController = TextEditingController();
  final niftyPointsController = TextEditingController();
  final unitNameMeasurementController = TextEditingController();
  final unitNameAnotherMeasurementController = TextEditingController();
  final equivalentUnitInGramsController = TextEditingController();
  final equivalentUnitInGramsController2 = TextEditingController();

  var ingredientNameFranceError = ''.obs;
  var ingredientNameEnglishError = ''.obs;
  var gramsPerCircleError = ''.obs;
  var caloriesPerGramError = ''.obs;
  var niftyPointsError = ''.obs;
  var unitNameMeasurementError = ''.obs;
  var unitNameAnotherMeasurementError = ''.obs;
  var equivalentUnitInGramsError = ''.obs;
  var equivalentUnitInGramsError2 = ''.obs;
  RxBool ingredientCreated = false.obs;

  AddNewIngredientController(super.authProvider);

  @override
  void onInit() {
    super.onInit();
  }

  bool validateNewIngredientForm() {
    if (ingredientNameFranceController.text.isEmpty) {
      ingredientNameFranceError.value = LocaleKeys.email_error_message.tr;
    } else {
      ingredientNameFranceError.value = '';
    }
    if (ingredientNameEnglishController.text.isEmpty) {
      ingredientNameEnglishError.value = LocaleKeys.email_error_message.tr;
    } else {
      ingredientNameEnglishError.value = '';
    }
    if (gramsPerCircleController.text.isEmpty) {
      gramsPerCircleError.value = LocaleKeys.email_error_message.tr;
    } else {
      gramsPerCircleError.value = '';
    }
    if (caloriesPerGramController.text.isEmpty) {
      caloriesPerGramError.value = LocaleKeys.email_error_message.tr;
    } else {
      caloriesPerGramError.value = '';
    }
    if (niftyPointsController.text.isEmpty) {
      niftyPointsError.value = LocaleKeys.email_error_message.tr;
    } else {
      niftyPointsError.value = '';
    }

    return ingredientNameFranceError.isEmpty &&
        ingredientNameEnglishError.isEmpty &&
        gramsPerCircleError.isEmpty &&
        caloriesPerGramError.isEmpty &&
        niftyPointsError.isEmpty;
  }

  Future<void> createNewIngredient() async {
    if (!validateNewIngredientForm()) return;

    if (validateNewIngredientForm() && !ingredientCreated.value) {
      try {
        ingredientCreated.value = true;
        // SignupRequest data = SignupRequest(
        //     username: emailController.text,
        //     // or another appropriate field for username
        //     email: emailController.text,
        //     password: passwordController.text,
        //     name: nameController.text,
        //     gender: selectedGender.value,
        //     birthDate: dateOfBirthController.text,
        //     height: tallController.text,
        //     weight: weightController.text,
        //     bmi: currentBMI.value.toString(),
        //     targetBmi: targetBMI.value.toString(),
        //     targetWeight: targetWeight.value.toString());
        //
        // await signUp(data);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        ingredientNameFranceController.clear();
        ingredientNameEnglishController.clear();
        gramsPerCircleController.clear();
        caloriesPerGramController.clear();
        niftyPointsController.clear();
        unitNameAnotherMeasurementController.clear();
        unitNameMeasurementController.clear();
        equivalentUnitInGramsController.clear();
        equivalentUnitInGramsController2.clear();

        rethrow;
      } finally {
        ingredientCreated.value = false;
      }
      addIngredientFormKey.currentState!.save();
    } else {
      throw Exception(LocaleKeys.global_error_message.tr);
    }
  }
}
