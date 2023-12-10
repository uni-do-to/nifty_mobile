import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class EmptyListItem extends StatelessWidget {
  const EmptyListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      alignment: Alignment.center,
      child: Text(
        'There is no ingredients added yet',
        style: NeumorphicTheme.of(context)?.current?.textTheme.titleMedium,
      ),
    );
  }
}
