import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

class DeleteAlertDialogWidget extends StatelessWidget {
  final String itemName;
  final void Function()? onDeletePressed;
  final void Function()? onCancelPressed;

  DeleteAlertDialogWidget(
      {super.key,
      this.onDeletePressed,
      this.onCancelPressed,
      required this.itemName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.delete_dialog_recipe_title.tr),
      content: Text('${LocaleKeys.delete_dialog_confirm_label.tr}$itemName ?'),
      actions: <Widget>[
        SmallActionButton(
          text: LocaleKeys.delete_label.tr,
          backgroundColor: ColorConstants.mainThemeColor,
          textColor: Colors.white,
          fontSize: 20,
          height: 30,
          onPressed: onDeletePressed,
        ),
        const SizedBox(
          height: 15,
        ),
        SmallActionButton(
          text: LocaleKeys.cancel_label.tr,
          backgroundColor: ColorConstants.grayBackgroundColor,
          textColor: ColorConstants.mainThemeColor,
          fontSize: 20,
          height: 30,
          onPressed: onCancelPressed,
        ),
      ],
    );
  }
}
