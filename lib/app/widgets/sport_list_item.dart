import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/data/models/sports_model.dart';
import 'package:nifty_mobile/app/modules/addSport/controllers/add_sport_controller.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';

class SportListItem extends StatelessWidget {
  final Sport sportItem;
  final VoidCallback onClick;
  final AddSportController controller;

  SportListItem(
      {Key? key,
      required this.sportItem,
      required this.onClick,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Neumorphic(
        style: NeumorphicStyle(depth: 1.2, intensity: 1),
        padding:
            EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        child: Row(
          children: [
            Icon(
              Icons.fitness_center_sharp,
              color: NeumorphicTheme.of(context)?.current?.iconTheme.color,
              size: 18,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              Get.locale?.languageCode == 'fr'
                  ? sportItem.attributes!.nameFr!
                  : sportItem.attributes!.nameEn!,
              style: NeumorphicTheme.of(context)?.current?.textTheme.bodySmall,
            ),
            Expanded(child: Container()),
            Obx(() {
              bool isSelected = controller.selectedSport == sportItem;
              return Visibility(
                visible: isSelected,
                child: Icon(
                  Icons.check_circle,
                  color: NeumorphicTheme.of(context)?.current?.iconTheme.color,
                  size: 18,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
