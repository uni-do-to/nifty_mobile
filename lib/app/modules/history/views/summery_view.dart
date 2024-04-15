import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/history_response_model.dart';

class SummeryView extends StatelessWidget {
  final double old;
  final double current;

  const SummeryView({ required this.old,required this.current, super.key});

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$old kg', // Display weight with 'kg' suffix
                  style: theme?.textTheme.titleMedium ,
                ),
                Text(
                  "OLD", // Display formatted date
                  style: theme?.textTheme.titleSmall ,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$current kg', // Display weight with 'kg' suffix
                  style: theme?.textTheme.titleMedium ,
                ),
                Text(
                  "CURRENT", // Display formatted date
                  style: theme?.textTheme.titleSmall ,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${current-old} kg', // Display weight with 'kg' suffix
                  style: theme?.textTheme.titleMedium ,
                ),
                Text(
                  "CHANGE", // Display formatted date
                  style: theme?.textTheme.titleSmall ,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}