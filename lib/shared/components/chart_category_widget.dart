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
    return SfCircularChart(
        tooltipBehavior: TooltipBehavior(
          enable: true,
          tooltipPosition: TooltipPosition.pointer,
        ),
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: chartData,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
              connectorLineSettings: ConnectorLineSettings(type: ConnectorType.curve),
            ),
            enableTooltip: true,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,
            radius: '80%',
            innerRadius: '60%',
          ),
        ]);
  }
}
