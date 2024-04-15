import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/history_response_model.dart';

class HistoryListItem extends StatelessWidget {
  final History history;

  const HistoryListItem({ required this.history, super.key});

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    // Assuming the date format is in a parseable format
    final DateTime date = DateTime.parse(history.attributes?.date ?? '');
    final String formattedDate = DateFormat('EEEE d MMMM yyyy', Get.locale?.toLanguageTag()).format(date); // Example date formatting
    final String weight = history.attributes?.weight?.toStringAsFixed(1) ?? '';

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$weight kg', // Display weight with 'kg' suffix
            style: theme?.textTheme.titleMedium ,
          ),
          Text(
            formattedDate, // Display formatted date
            style: theme?.textTheme.titleSmall ,

          ),
        ],
      ),
    );
  }
}