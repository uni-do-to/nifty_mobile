import 'package:flutter/material.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';

class DeleteAlertDialogWidget extends StatelessWidget {
  final String itemName;
  final void Function()? onDeletePressed;
  final void Function()? onCancelPressed;

  DeleteAlertDialogWidget({super.key, this.onDeletePressed, this.onCancelPressed, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Delete Recipe'),
      content: Text(
          'Are you sure you want to delete $itemName ?'),
      actions: <Widget>[
        SmallActionButton(
          text: 'Delete',
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
          text: 'Cancel',
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
