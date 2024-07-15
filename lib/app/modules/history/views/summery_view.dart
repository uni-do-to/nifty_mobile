import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/app/data/models/user_permission_model.dart';
import 'package:nifty_mobile/app/services/auth_service.dart';
import 'package:nifty_mobile/app/utils/chart_utils.dart';
import 'package:nifty_mobile/generated/locales.g.dart';
import 'dart:math';
import '../../../data/models/history_response_model.dart';

class SummaryView extends StatelessWidget {
  final double old;
  final double current;
  final List<History> historyList;
  final String timeFrame;

  const SummaryView({
    required this.old,
    required this.current,
    required this.historyList,
    required this.timeFrame,
    super.key,
  });

  int calculateUserAge(User userData) {
    DateTime birthDate =
    DateFormat("yyyy-MM-dd").parse(userData.birthDate ?? "");
    DateTime now = DateTime.now();
    int age = now.year - birthDate.year;

    // Check if the birthday has occurred this year
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    var userData = Get.find<AuthService>().credentials?.user;
    var userAge = calculateUserAge(userData!);
    var targetWeight = userData.targetWeight ?? 60;

    // Calculate max, min, and mid values from historyList including targetWeight
    double maxWeight = max(historyList.map((h) => h.attributes!.weight??0).reduce(max), targetWeight);
    double minWeight = min(historyList.map((h) => h.attributes!.weight??0).reduce(min), targetWeight);
    double midWeight = (maxWeight + minWeight) / 2;

    final simpleCurrencyFormatter = charts.BasicNumericTickFormatterSpec(

      (measure) => "${measure?.toInt()} ${LocaleKeys.weight_measurement.tr}",
    );

    var series = [
      charts.Series<History, DateTime>(
        id: 'Weight',
        colorFn: (_, __) => charts.Color.fromHex(code: "#42A4A0"),
        domainFn: (History history, _) => history.attributes!.dateTime,
        measureFn: (History history, _) => history.attributes!.weight,
        data: historyList,
        domainFormatterFn: (History history, _) =>
            (datum) => DateFormat('EEE').format(history.attributes!.dateTime),
      ),
      // charts.Series<History, DateTime>(
      //   id: 'weightPoints',
      //   colorFn: (_, __) => charts.Color.fromHex(code: "#274c5b"),
      //   domainFn: (History history, _) => history.attributes!.dateTime,
      //   measureFn: (History history, _) => history.attributes!.weight,
      //   data: historyList,
      // )..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          // Displaying current, old, and change in weight
          weightInfoRow(theme),

          // TimeSeriesChart
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              child: charts.TimeSeriesChart(series,
                  animate: true,
                  defaultRenderer: new charts.LineRendererConfig(),
                  // Custom renderer configuration for the point series.
                  // customSeriesRenderers: [
                  //   charts.PointRendererConfig(
                  //       symbolRenderer: charts.RectSymbolRenderer(),
                  //       // ID used to link series to this renderer.
                  //       customRendererId: 'customPoint')
                  // ],
                  behaviors: userAge > 19 ? [
                    charts.RangeAnnotation([
                      charts.LineAnnotationSegment(
                          targetWeight,
                          charts.RangeAnnotationAxisType.measure,
                          startLabel: "${targetWeight.round()} ${LocaleKeys.weight_measurement.tr}",
                          labelAnchor: charts.AnnotationLabelAnchor.start,
                          labelStyleSpec: charts.TextStyleSpec(color: charts.Color.fromHex(code: "#80D3CC")),
                          color: charts.Color.fromHex(code: "#80D3CC")),
                    ], defaultLabelPosition: charts.AnnotationLabelPosition.inside
                    ),

                  ] : [],
                  dateTimeFactory: LocalizedDateTimeFactory(Get.locale!),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                      showAxisLine: true,
                  tickProviderSpec: charts.StaticNumericTickProviderSpec(
                    <charts.TickSpec<double>>[
                      charts.TickSpec(minWeight-2),
                      charts.TickSpec(midWeight),
                      charts.TickSpec(maxWeight+2),
                    ],
                  ),
                  tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                    (num? value) => "${value?.toInt()} ${LocaleKeys.weight_measurement.tr}",
                  ),
                      renderSpec: charts.GridlineRendererSpec(
                        labelStyle: charts.TextStyleSpec(
                            fontSize: 14, // size in Pts.
                            color: charts.Color.fromHex(code: "#274c5b")),
                        axisLineStyle: charts.LineStyleSpec(
                            color: charts.MaterialPalette.transparent),
                      )),
                  domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                        labelStyle: charts.TextStyleSpec(
                            fontSize: 14, // size in Pts.
                            color: charts.Color.fromHex(code: "#274c5b")),
                         labelRotation: 60,
                        labelCollisionOffsetFromTickPx: 0,
                        labelCollisionOffsetFromAxisPx: 0,
                        labelCollisionRotation: 60,
                        labelOffsetFromTickPx: 0,
                        minimumPaddingBetweenLabelsPx: 0,
                        labelOffsetFromAxisPx: 10,
                        tickLengthPx: 5,
                        lineStyle: charts.LineStyleSpec(
                            thickness: 2,
                            color: charts.MaterialPalette.gray.shade300)
                    ),
                    tickFormatterSpec: const charts.AutoDateTimeTickFormatterSpec(
                      minute: charts.TimeFormatterSpec(
                        format: "EEE" , transitionFormat: 'EEE dd/MM'
                      ),
                        // day: charts.TimeFormatterSpec(
                        //     format: 'EEE', transitionFormat: 'EEE dd/MM')
                    ),
                    tickProviderSpec: charts.DayTickProviderSpec(
                      increments: [1 , 7 , 31]
                    )
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget weightInfoRow(theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          weightDetail(LocaleKeys.old.tr, old, theme),
          weightDetail(LocaleKeys.current.tr, current, theme),
          weightDetail(LocaleKeys.change.tr, current - old, theme),
        ],
      ),
    );
  }

  Widget weightDetail(String label, double weight, theme) {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${weight.toStringAsFixed(1)} kg',
            style: theme?.textTheme.titleMedium,
          ),
          Text(
            label,
            style: theme?.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
