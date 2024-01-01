import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/app/data/models/edit_health_profile_request_model.dart';
import 'package:nifty_mobile/app/data/models/user_permission_model.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class EditHealthProfileController extends AuthController {
  final GlobalKey<FormState> editHealthFormKey = GlobalKey<FormState>();

  final tallController = TextEditingController();
  final weightController = TextEditingController();

  RxDouble minBMIValue = 0.0.obs;
  RxDouble maxBMIValue = 0.0.obs;
  RxDouble currentBMI = 0.0.obs;
  RxDouble targetBMI = 0.0.obs;
  RxDouble targetWeight = 0.0.obs;
  RxDouble targetCaloriesPerDay = 0.0.obs;
  RxDouble niftyPoints = 0.0.obs;

  var tallError = ''.obs;
  var weightError = ''.obs;
  var targetBMIError = ''.obs;

  RxBool isHealthFormUpdated = false.obs;
  User? userData;
  final AuthProvider provider;

  EditHealthProfileController(this.provider) : super(provider);

  @override
  void onInit() {
    super.onInit();
    tallController.addListener(() {
      calculateBmiChange();
    });
    weightController.addListener(() {
      calculateBmiChange();
    });
    getUserInfo();
    setUserData();
  }

  bool validateBMIForm() {
    if (tallController.text.isEmpty) {
      tallError.value = LocaleKeys.tall_error_message.tr;
    } else {
      tallError.value = '';
    }

    if (weightController.text.isEmpty) {
      weightError.value = LocaleKeys.weight_error_message.tr;
    } else {
      weightError.value = '';
    }

    if (targetBMI.value == 0.0) {
      targetBMIError.value = LocaleKeys.target_bmi_error_message.tr;
    } else {
      targetBMIError.value = '';
    }

    return tallError.isEmpty && weightError.isEmpty && targetBMIError.isEmpty;
  }

  getUserInfo() {
    userData = provider.authService.credentials?.user;
  }

  setUserData() {
    tallController.text = userData!.height.toString() ?? "";
    weightController.text = userData!.weight.toString() ?? "";
    currentBMI.value = userData!.bmi ?? 0.0;
    targetBMI.value = (userData!.targetBmi ?? 0).toDouble();
    targetWeight.value = userData!.targetWeight ?? 0.0;
    targetCaloriesPerDay.value = userData!.dailyCalories ?? 0.0;
  }

  void calculateBmiChange() {
    double height = double.tryParse(tallController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if (weight == 0 || height == 0) {
      currentBMI.value = 0.0;
      return;
    }

    currentBMI.value = (weight / (height * height)) * 10000;
    maxBMIValue.value = currentBMI.value + 15;
    minBMIValue.value = currentBMI.value - 15;
    targetBMI.value = (userData!.gender == 'male') ? 25.0 : 20.0;

    calculateTargetWeight(targetBMI.value, (height / 100));
    int userAge = calculateUserAge();
    if (userAge > 19) {
      calculateDailyCaloriesAbove19YearsOld(
          targetWeight.value, (height / 100), userAge, userData!.gender!);
    } else {
      calculateDailyCaloriesBelow19YearsOld(userAge, userData!.gender!);
    }
  }

  //calculate target weight according to target BMI and height
  void calculateTargetWeight(double targetBMI, double height) {
    targetWeight.value = (targetBMI * (height * height));
  }

  //calculate user age from the birthdate
  int calculateUserAge() {
    DateTime birthDate =
        DateFormat("yyyy-MM-dd").parse(userData!.birthDate ?? "");
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;

    // Check if the birthday has occurred this year
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  // calculate daily calories above 19 years old according to gender, age , height and target BMI
  void calculateDailyCaloriesAbove19YearsOld(
      double targetWeight, double height, int age, String gender) {
    if (gender == 'male') {
      targetCaloriesPerDay.value = (height != 0)
          ? (83.362 +
              (13.397 * targetWeight) +
              (479.9 * height) -
              (5.677 * age))
          : 0;
    } else if (gender == 'female') {
      targetCaloriesPerDay.value = (height != 0)
          ? (447.593 + (9.247 * targetWeight) + (309.8 * height) - (4.33 * age))
          : 0;
    }
  }

  // calculate daily calories below 19 years old according to gender
  void calculateDailyCaloriesBelow19YearsOld(int age, String gender) {
    if (age == 13 && gender == 'male') {
      targetCaloriesPerDay.value = 2414;
    } else if (age == 13 && gender == 'female') {
      targetCaloriesPerDay.value = 2223;
    } else if (age == 14 && gender == 'male') {
      targetCaloriesPerDay.value = 2629;
    } else if (age == 14 && gender == 'female') {
      targetCaloriesPerDay.value = 2342;
    } else if (age == 15 && gender == 'male') {
      targetCaloriesPerDay.value = 2820;
    } else if (age == 15 && gender == 'female') {
      targetCaloriesPerDay.value = 2390;
    } else if (age == 16 && gender == 'male') {
      targetCaloriesPerDay.value = 2964;
    } else if (age == 16 && gender == 'female') {
      targetCaloriesPerDay.value = 2414;
    } else if (age == 17 && gender == 'male') {
      targetCaloriesPerDay.value = 3083;
    } else if (age == 17 && gender == 'female') {
      targetCaloriesPerDay.value = 2426;
    } else if (age == 18 && gender == 'male') {
      targetCaloriesPerDay.value = 3155;
    } else if (age == 18 && gender == 'female') {
      targetCaloriesPerDay.value = 2462;
    }
  }

  void calculateUserGoalMeasurements() {
    double height = double.tryParse(tallController.text) ?? 0;

    calculateTargetWeight(targetBMI.value, (height / 100));

    var userAge = calculateUserAge();
    if (userAge > 19) {
      calculateDailyCaloriesAbove19YearsOld(
          targetBMI.value, (height / 100), userAge, userData!.gender ?? "");
    } else {
      calculateDailyCaloriesBelow19YearsOld(userAge, userData!.gender ?? "");
    }
  }

  Future<void> editHealthProfile() async {
    if (!validateBMIForm()) return;

    if (validateBMIForm() && !isHealthFormUpdated.value) {
      try {
        isHealthFormUpdated.value = true;

        EditHealthProfileRequest data = EditHealthProfileRequest(
            height: tallController.text,
            weight: weightController.text,
            bmi: currentBMI.value.toString(),
            targetBmi: targetBMI.value.toString(),
            targetWeight: targetWeight.value.toString(),
            dailyCalories: targetCaloriesPerDay.value.toString());

        var result = await provider.editUserHealthProfile(data);
        if(result?.email != null) {
          await authProvider.authService.updateUserInfo(result!) ;
        }
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        rethrow;
      } finally {
        isHealthFormUpdated.value = false;
      }
      editHealthFormKey.currentState!.save();
    } else {
      throw Exception(LocaleKeys.global_error_message.tr);
    }
  }
}
