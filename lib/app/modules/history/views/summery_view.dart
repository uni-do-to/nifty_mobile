import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/data/auth_provider.dart';
import 'package:nifty_mobile/app/services/auth_service.dart';
import 'package:nifty_mobile/generated/locales.g.dart';

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

  @override
  Widget build(BuildContext context) {
    var theme = NeumorphicTheme.of(context)?.current;

    final simpleCurrencyFormatter = charts.BasicNumericTickFormatterSpec(
      (measure) => "$measure ${LocaleKeys.weight_measurement.tr}",
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
      charts.Series<History, DateTime>(
        id: 'weightPoints',
        colorFn: (_, __) => charts.Color.fromHex(code: "#274c5b"),
        domainFn: (History history, _) => history.attributes!.dateTime,
        measureFn: (History history, _) => history.attributes!.weight,
        data: historyList,
      )..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];

    var targetWeight = Get.find<AuthService>()
        .credentials
        ?.user
        ?.targetWeight?? 60;

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
                  customSeriesRenderers: [
                    charts.PointRendererConfig(
                        symbolRenderer: charts.RectSymbolRenderer(),
                        // ID used to link series to this renderer.
                        customRendererId: 'customPoint')
                  ],
                  behaviors: [
                    charts.RangeAnnotation([
                      charts.LineAnnotationSegment(
                          targetWeight,
                          charts.RangeAnnotationAxisType.measure,
                          startLabel: "${LocaleKeys.target_bmi_label.tr} $targetWeight ${LocaleKeys.weight_measurement.tr}",
                          labelAnchor: charts.AnnotationLabelAnchor.start,
                          labelStyleSpec: charts.TextStyleSpec(color: charts.Color.fromHex(code: "#80D3CC")),
                          color: charts.Color.fromHex(code: "#80D3CC")),
                    ], defaultLabelPosition: charts.AnnotationLabelPosition.inside
                    ),

                  ],
                  primaryMeasureAxis: charts.NumericAxisSpec(
                      showAxisLine: true,
                      tickProviderSpec: const charts.BasicNumericTickProviderSpec(
                          zeroBound: false, desiredMinTickCount: 4),
                      tickFormatterSpec: simpleCurrencyFormatter,
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
                        lineStyle: charts.LineStyleSpec(
                            thickness: 2,
                            color: charts.MaterialPalette.gray.shade300)
                    ),
                    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                        // day: charts.TimeFormatterSpec(
                        //     format: 'EEE', transitionFormat: 'EEE dd/MM')
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
