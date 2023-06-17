import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/chart_data_model.dart';

class ChartCategoryWidget extends StatelessWidget {
  final List<ChartData> chartData;

  const ChartCategoryWidget({
    Key? key,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(series: <CircularSeries>[
      DoughnutSeries<ChartData, String>(
        dataSource: chartData,
        pointColorMapper: (ChartData data, _) => data.color,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        radius: '90%',
        innerRadius: '50%',
      ),
    ]);
  }
}
