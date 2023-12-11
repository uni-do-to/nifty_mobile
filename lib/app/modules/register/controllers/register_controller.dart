import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/modules/register/signup_request_model.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class RegisterController extends AuthController {
  RxInt currentStep = 0.obs;

  final GlobalKey<FormState> yourInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> yourBmiFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> niftyPointsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final tallController = TextEditingController();
  final weightController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxString selectedGender = ''.obs;
  RxDouble minBMIValue = 0.0.obs;
  RxDouble maxBMIValue = 0.0.obs;
  RxDouble currentBMI = 0.0.obs;
  RxDouble targetBMI = 0.0.obs;
  RxDouble targetWeight = 0.0.obs;
  RxDouble targetCaloriesPerDay = 0.0.obs;
  RxDouble niftyPoints = 0.0.obs;
  RxInt userAge = 0.obs;
  var nameError = ''.obs;
  var birthDateError = ''.obs;
  var genderError = ''.obs;
  var tallError = ''.obs;
  var weightError = ''.obs;
  var targetBMIError = ''.obs;
  var termsAndConditionsError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;
  RxBool isSignup = false.obs;
  RxBool termsAndConditions = false.obs;

  RegisterController(super.authProvider);

  @override
  void onInit() {
    super.onInit();
    tallController.addListener(() {
      calculateBmiChange();
    });
    weightController.addListener(() {
      calculateBmiChange();
    });
  }

  bool validateUserInfoForm() {
    if (nameController.text.isEmpty) {
      nameError.value = LocaleKeys.name_error_message.tr;
    } else {
      nameError.value = '';
    }

    if (dateOfBirthController.text.isEmpty) {
      birthDateError.value = LocaleKeys.birth_date_error_message.tr;
    } else {
      birthDateError.value = '';
    }

    if (selectedGender.isEmpty) {
      genderError.value = LocaleKeys.gender_error_message.tr;
    } else {
      genderError.value = '';
    }

    return nameError.isEmpty && birthDateError.isEmpty && genderError.isEmpty;
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

  bool validateNiftyPointsForm() {
    if (!termsAndConditions.value) {
      termsAndConditionsError.value =
          LocaleKeys.terms_and_conditions_error_message.tr;
    } else {
      termsAndConditionsError.value = '';
    }

    return termsAndConditionsError.isEmpty;
  }

  bool validateSignUpForm() {
    if (emailController.text.isEmpty) {
      emailError.value = LocaleKeys.email_error_message.tr;
    } else {
      emailError.value = '';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = LocaleKeys.password_error_message.tr;
    } else {
      passwordError.value = '';
    }

    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = LocaleKeys.confirm_password_error_message.tr;
    } else {
      confirmPasswordError.value = '';
    }

    if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value =
          LocaleKeys.password_not_match_error_message.tr;
    } else {
      confirmPasswordError.value = '';
    }
    return emailError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty;
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
    targetBMI.value = (selectedGender.value == 'Male') ? 25.0 : 20.0;

    calculateTargetWeight(targetBMI.value, (height / 100));

    if (userAge.value > 19) {
      calculateDailyCaloriesAbove19YearsOld(targetWeight.value, (height / 100),
          userAge.value, selectedGender.value);
    } else {
      calculateDailyCaloriesBelow19YearsOld(
          userAge.value, selectedGender.value);
    }
  }

  //calculate user age from the birthdate
  int calculateUserAge() {
    DateTime birthDate = DateTime.parse(dateOfBirthController.text);
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;

    // Check if the birthday has occurred this year
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  //calculate nifty points according to target calories per day
  void calculateNiftyPoints() {
    niftyPoints.value = targetCaloriesPerDay.value / 33;
  }

  //calculate target weight according to target BMI and height
  void calculateTargetWeight(double targetBMI, double height) {
    targetWeight.value = (targetBMI * (height * height));
  }

  // calculate daily calories above 19 years old according to gender, age , height and target BMI
  void calculateDailyCaloriesAbove19YearsOld(
      double targetWeight, double height, int age, String gender) {
    if (gender == 'Male') {
      targetCaloriesPerDay.value = (height != 0)
          ? (83.362 +
              (13.397 * targetWeight) +
              (479.9 * height) -
              (5.677 * age))
          : 0;
    } else if (gender == 'Female') {
      targetCaloriesPerDay.value = (height != 0)
          ? (447.593 + (9.247 * targetWeight) + (309.8 * height) - (4.33 * age))
          : 0;
    }
  }

  // calculate daily calories below 19 years old according to gender
  void calculateDailyCaloriesBelow19YearsOld(int age, String gender) {
    if (age == 13 && gender == 'Male') {
      targetCaloriesPerDay.value = 2414;
    } else if (age == 13 && gender == 'Female') {
      targetCaloriesPerDay.value = 2223;
    } else if (age == 14 && gender == 'Male') {
      targetCaloriesPerDay.value = 2629;
    } else if (age == 14 && gender == 'Female') {
      targetCaloriesPerDay.value = 2342;
    } else if (age == 15 && gender == 'Male') {
      targetCaloriesPerDay.value = 2820;
    } else if (age == 15 && gender == 'Female') {
      targetCaloriesPerDay.value = 2390;
    } else if (age == 16 && gender == 'Male') {
      targetCaloriesPerDay.value = 2964;
    } else if (age == 16 && gender == 'Female') {
      targetCaloriesPerDay.value = 2414;
    } else if (age == 17 && gender == 'Male') {
      targetCaloriesPerDay.value = 3083;
    } else if (age == 17 && gender == 'Female') {
      targetCaloriesPerDay.value = 2426;
    } else if (age == 18 && gender == 'Male') {
      targetCaloriesPerDay.value = 3155;
    } else if (age == 18 && gender == 'Female') {
      targetCaloriesPerDay.value = 2462;
    }
  }

  void calculateUserGoalMeasurements() {
    double height = double.tryParse(tallController.text) ?? 0;

    calculateTargetWeight(targetBMI.value, (height / 100));

    if (userAge.value > 19) {
      calculateDailyCaloriesAbove19YearsOld(
          targetBMI.value, (height / 100), userAge.value, selectedGender.value);
    } else {
      calculateDailyCaloriesBelow19YearsOld(
          userAge.value, selectedGender.value);
    }
  }

  Future<void> signup() async {
    if (!validateUserInfoForm() &&
        !validateBMIForm() &&
        !validateNiftyPointsForm() &&
        !validateSignUpForm()) return;

    if (validateSignUpForm() && !isSignup.value) {
      try {
        isSignup.value = true;
        SignupRequest data = SignupRequest(
            username: emailController.text,
            // or another appropriate field for username
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            gender: selectedGender.value,
            birthDate: dateOfBirthController.text,
            height: tallController.text,
            weight: weightController.text,
            bmi: currentBMI.value.toString(),
            targetBmi: targetBMI.value.toString(),
            targetWeight: targetWeight.value.toString());

        await signUp(data);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        passwordController.clear();
        rethrow;
      } finally {
        isSignup.value = false;
      }
      signupFormKey.currentState!.save();
    } else {
      throw Exception(LocaleKeys.global_error_message.tr);
    }
  }
}
