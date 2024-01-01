import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/controllers/auth_controller.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/app/data/models/edit_personal_info_request_model.dart';
import 'package:nifty_mobile/app/data/models/user_permission_model.dart';
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

  User? userData;

  final AuthProvider provider;

  EditPersonalInfoController(this.provider) : super(provider);

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    setUserData();
  }

  getUserInfo() {
    userData = provider.authService.credentials?.user;
    print(userData!.birthDate!);
  }

  setUserData() {
    nameController.text = userData!.name ?? "";
    selectedGender.value = userData!.gender ?? "";

    DateTime birthDate =
        DateFormat("yyyy-MM-dd").parse(userData!.birthDate ?? "");
    String formattedBirthDate = DateFormat("dd-MM-yyyy").format(birthDate);

    dateOfBirthController.text = formattedBirthDate;
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
        DateFormat("dd-MM-yyyy").parse(dateOfBirthController.text);
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;

    // Check if the birthday has occurred this year
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Future<void> editProfile() async {
    if (!validateUserInfoForm()) return;

    if (validateUserInfoForm() && !isInfoFormUpdated.value) {
      try {
        isInfoFormUpdated.value = true;
        DateTime birthDate =
            DateFormat("dd-MM-yyyy").parse(dateOfBirthController.text);
        String formattedBirthDate = DateFormat("yyyy-MM-dd").format(birthDate);

        EditPersonalInfoRequest data = EditPersonalInfoRequest(
          name: nameController.text,
          gender: selectedGender.value,
          birthDate: formattedBirthDate,
        );

        await provider.editUserInfo(data);
      } catch (err, _) {
        // message = 'There is an issue with the app during request the data, '
        //         'please contact admin for fixing the issues ' +

        rethrow;
      } finally {
        isInfoFormUpdated.value = false;
      }
      editInfoFormKey.currentState!.save();
    } else {
      throw Exception(LocaleKeys.global_error_message.tr);
    }
  }
}
