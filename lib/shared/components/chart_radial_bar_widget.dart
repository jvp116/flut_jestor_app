import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/chart_data_model.dart';

class ChartRadialBarWidget extends StatelessWidget {
  final List<ChartData> chartData;

  const ChartRadialBarWidget({
    Key? key,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(series: <CircularSeries>[
      RadialBarSeries<ChartData, String>(
          useSeriesColor: true,
          trackOpacity: 0.15,
          dataSource: chartData,
          pointColorMapper: (ChartData data, _) => data.color,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          radius: '100%',
          innerRadius: '50%',
          cornerStyle: CornerStyle.bothCurve),
    ]);
  }
}
