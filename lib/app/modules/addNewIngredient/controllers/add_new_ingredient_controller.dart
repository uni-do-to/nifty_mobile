import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/data/models/ingredient_request_model.dart';
import 'package:nifty_mobile/app/data/models/unit_model.dart';
import 'package:nifty_mobile/app/data/providers/ingredient_provider.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class AddNewIngredientController extends GetxController {

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

  final IngredientProvider ingredientProvider ;

  AddNewIngredientController(this.ingredientProvider);

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
        IngredientRequest request = IngredientRequest(
          data: Data(
            nameEn: ingredientNameEnglishController.text,
            nameFr: ingredientNameFranceController.text ,
            caloriesPer100grams: int.tryParse(caloriesPerGramController.text),
            niftyPoints: int.tryParse(niftyPointsController.text) ,
            gramsPerCircle: int.tryParse(gramsPerCircleController.text),
            units: [
              Units(
                name: unitNameMeasurementController.text,
                grams: int.tryParse(equivalentUnitInGramsController.text)
              ),
              Units(
                name: unitNameAnotherMeasurementController.text ,
                grams: int.tryParse(equivalentUnitInGramsController2.text)
              )
            ]
          )
        );

        await ingredientProvider.createIngredient(request);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

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
