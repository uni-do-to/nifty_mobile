import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';

class EmptyListItem extends StatelessWidget {
  const EmptyListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      alignment: Alignment.center,
      child: Text(
        LocaleKeys.no_ingredient.tr,
        style: NeumorphicTheme.of(context)?.current?.textTheme.titleMedium,
      ),
    );
  }
}
