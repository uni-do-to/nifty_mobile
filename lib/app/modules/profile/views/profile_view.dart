import 'package:country_flags/country_flags.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/app_constants.dart';
import 'package:nifty_mobile/app/routes/app_pages.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

import '../../../config/color_constants.dart';
import '../../../config/size_constants.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: SizeConstants.toolBarPadding,
          child: ObxValue((state) {
            return Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.accentColor),
                  child: Center(
                    child: Text(
                      state.value?.name?.substring(0, 1).toUpperCase() ?? "",
                      style: theme?.textTheme.titleLarge
                          ?.copyWith(color: ColorConstants.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.value?.name?.toUpperCase() ?? ""),
                    Text(state.value?.email ?? "".toUpperCase(),
                        style: theme?.textTheme.titleSmall
                            ?.copyWith(color: ColorConstants.toolbarTextColor)),
                  ],
                ),
              ],
            );
          }, controller.user),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        titleTextStyle: theme?.textTheme.titleLarge
            ?.copyWith(color: ColorConstants.toolbarTextColor),
        toolbarHeight: 64,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: ColorConstants.white,
        child: Column(
          children: [
            Neumorphic(
              child: Column(
                children: [
                  SettingsTile(
                    title: LocaleKeys.personal_info.tr,
                    onTap: () => {Get.toNamed(Routes.EDIT_PERSONAL_INFO)},
                  ),
                  SettingsTile(
                    title: LocaleKeys.health_profile.tr,
                    onTap: () => {Get.toNamed(Routes.EDIT_HEALTH_PROFILE)},
                  ),
                  SettingsTile(
                    title: LocaleKeys.change_password_screen_title.tr,
                    onTap: () => {Get.toNamed(Routes.CHANGE_PASSWORD)},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Neumorphic(
              child: Column(
                children: [
                  SettingsTile(
                    title: LocaleKeys.language_label.tr,
                    trailing: Row(
                      children: [
                        CountryFlag.fromLanguageCode(
                            Get.locale?.languageCode ??
                                AppConstants.DEFAULT_LANGUAGE,
                            width: 24,
                            height: 24,
                            borderRadius: 8),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          Get.locale?.languageCode.toUpperCase() ?? "",
                          style: theme?.textTheme.titleLarge,
                        )
                      ],
                    ),
                    onTap: () async {
                      // Handle the tap action
                      var result = await Get.dialog(SimpleDialog(
                        title: Text(
                          LocaleKeys.language_label.tr,
                          style: theme?.textTheme.titleLarge,
                        ),
                        children: <Widget>[
                          ...AppConstants.languages.keys.map((key) {
                            return SimpleDialogOption(
                              onPressed: () {
                                Get.back(result: key);
                              },
                              child: Row(
                                children: [
                                  CountryFlag.fromLanguageCode(key,
                                      width: 24, height: 24, borderRadius: 8),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    AppConstants.languages[key]!.languageName,
                                    style: theme?.textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            );
                          })
                        ],
                      ));
                      if (result != null) {
                        controller.changeLanguage(result);
                      }
                    },
                  ),
                  SettingsTile(
                      title: LocaleKeys.display_unit_label.tr,
                      trailing: Text(
                        "Nifty point",
                        style: theme?.textTheme.titleLarge,
                      ),
                      onTap: () async {
                        var result = await Get.dialog(SimpleDialog(
                          title: Text(
                            LocaleKeys.display_unit_label.tr,
                            style: theme?.textTheme.titleLarge,
                          ),
                          children: <Widget>[
                            ...AppConstants.displayUnits.map((key) {
                              return SimpleDialogOption(
                                onPressed: () {
                                  Get.back(result: key);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      key,
                                      style: theme?.textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              );
                            })
                          ],
                        ));
                        if (result != null) {
                          controller.changeDisplayUnit(result);
                        }
                      }),
                ],
              ),
            ),
            Expanded(child: Container()),
            Neumorphic(
              child: Column(
                children: [
                  SettingsTile(
                    title: LocaleKeys.logout_label.tr,
                    icon: Icon(Icons.logout),
                    onTap: () async {
                      var result = await Get.dialog(AlertDialog(
                        title: Text(
                          LocaleKeys.logout_label.tr,
                          style: theme?.textTheme.titleLarge,
                        ),
                        content: Text(LocaleKeys.logout_confirm_question.tr),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              LocaleKeys.cancel_label.tr,
                              style: theme?.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Get.back(result: false);
                            },
                          ),
                          TextButton(
                            child: Text(LocaleKeys.logout_label.tr,
                                style: theme?.textTheme.titleMedium),
                            onPressed: () {
                              Get.back(result: true);
                            },
                          ),
                        ],
                      ));
                      if (result == true) {
                        controller.logout();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showOptionDialog(
      {required String title,
      required Map<String, String> options,
      NeumorphicThemeData? theme}) {
    return Get.dialog(SimpleDialog(
      title: Text(
        title,
        style: theme?.textTheme.titleLarge,
      ),
      children: <Widget>[
        ...options.keys.map((key) {
          return SimpleDialogOption(
            onPressed: () {
              Get.back(result: key);
            },
            child: Text(
              options[key]!,
              style: theme?.textTheme.titleMedium,
            ),
          );
        })
      ],
    ));
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget? icon;

  final GestureTapCallback? onTap;

  const SettingsTile(
      {Key? key,
      required this.title,
      required this.onTap,
      this.icon,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return ListTile(
      title: Text(
        title,
        style: theme?.textTheme.titleLarge
            ?.copyWith(fontWeight: FontWeight.normal),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          trailing ?? Container(),
          SizedBox(
            width: 8,
          ),
          icon ??
              Icon(
                Icons.arrow_forward_ios,
                color: ColorConstants.accentColor.withOpacity(0.5),
              ),
        ],
      ),
      onTap: onTap,
    );
  }
}
