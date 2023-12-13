import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final niftyPointsController = TextEditingController(text: '');
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
  RxBool loading = false.obs;
  RxBool isNiftyPointValueChanged = false.obs;

  final IngredientProvider ingredientProvider;

  AddNewIngredientController(this.ingredientProvider);

  @override
  void onInit() {
    super.onInit();
    caloriesPerGramController.addListener(() {
      if (double.tryParse(caloriesPerGramController.text)! > 0) {
        isNiftyPointValueChanged.value = true;
        double caloriesPer =
            double.tryParse(caloriesPerGramController.text) ?? 0;

        niftyPointsController.text = (caloriesPer / 33).round().toString();
      } else {
        isNiftyPointValueChanged.value = true;

        niftyPointsController.text = "";
      }
    });
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

    return ingredientNameFranceError.isEmpty &&
        ingredientNameEnglishError.isEmpty &&
        gramsPerCircleError.isEmpty &&
        caloriesPerGramError.isEmpty;
  }

  Future<void> createNewIngredient() async {
    if (validateNewIngredientForm() && !loading.value) {
      try {
        loading.value = true;

        List<Units> units = [];

// Check for the first set of unit name and equivalent unit in grams
        if (unitNameMeasurementController.text.isNotEmpty &&
            double.tryParse(equivalentUnitInGramsController.text)
                    ?.compareTo(0) !=
                0) {
          units.add(Units(
            name: unitNameMeasurementController.text,
            grams: double.tryParse(equivalentUnitInGramsController.text),
          ));
        }

// Check for the second set of unit name and equivalent unit in grams
        if (unitNameAnotherMeasurementController.text.isNotEmpty &&
            double.tryParse(equivalentUnitInGramsController2.text)
                    ?.compareTo(0) !=
                0) {
          units.add(Units(
            name: unitNameAnotherMeasurementController.text,
            grams: double.tryParse(equivalentUnitInGramsController2.text),
          ));
        }

        IngredientRequest request = IngredientRequest(
          data: Data(
              nameEn: ingredientNameEnglishController.text,
              nameFr: ingredientNameFranceController.text,
              caloriesPer100grams:
                  double.tryParse(caloriesPerGramController.text),
              niftyPoints: double.tryParse(niftyPointsController.text),
              gramsPerCircle: double.tryParse(gramsPerCircleController.text),
              units: units),
        );

        await ingredientProvider.createIngredient(request);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        rethrow;
      } finally {
        loading.value = false;
      }
      addIngredientFormKey.currentState!.save();
    } else {
      throw Exception(LocaleKeys.global_error_message.tr);
    }
  }
}
