import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/app/modules/register/signup_request_model.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class EditPersonalInfoController extends AuthController {
  final GlobalKey<FormState> editInfoFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  RxString selectedGender = ''.obs;
  RxInt userAge = 0.obs;
  var nameError = ''.obs;
  var birthDateError = ''.obs;
  var genderError = ''.obs;
  RxBool isInfoFormUpdated = false.obs;

  final AuthProvider provider;

  EditPersonalInfoController(this.provider) : super(provider);

  @override
  void onInit() {
    super.onInit();
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

  //calculate user age from the birthdate
  int calculateUserAge() {
    DateTime birthDate =
        DateFormat("dd-mm-yyyy").parse(dateOfBirthController.text);
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;

    // Check if the birthday has occurred this year
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Future<void> signup() async {
    if (!validateUserInfoForm()) return;
    //
    // if (validateUserInfoForm() && !isInfoFormUpdated.value) {
    //   try {
    //     isInfoFormUpdated.value = true;
    //     DateTime birthDate =
    //         DateFormat("dd-mm-yyyy").parse(dateOfBirthController.text);
    //     String formattedBirthDate = DateFormat("yyyy-MM-dd").format(birthDate);
    //
    //     SignupRequest data = SignupRequest(
    //       name: nameController.text,
    //       gender: selectedGender.value,
    //       birthDate: formattedBirthDate,
    //     );
    //
    //     await provider.editUserInfo(data);
    //   } catch (err, _) {
    //     // message = 'There is an issue with the app during request the data, '
    //     //         'please contact admin for fixing the issues ' +
    //
    //     passwordController.clear();
    //     confirmPasswordController.clear();
    //     rethrow;
    //   } finally {
    //     isSignup.value = false;
    //   }
    //   signupFormKey.currentState!.save();
    // } else {
    //   throw Exception(LocaleKeys.global_error_message.tr);
    // }
  }
}
