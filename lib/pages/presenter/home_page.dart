import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../shared/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPressed = true;

  final List<ChartData> chartData = [
    ChartData('David', 25, const Color.fromRGBO(9, 0, 136, 1)),
    ChartData('Steve', 38, const Color.fromRGBO(147, 0, 119, 1)),
    ChartData('Jack', 34, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('Others', 52, const Color.fromRGBO(255, 189, 57, 1))
  ];

  @override
  Widget build(BuildContext context) {
    const Color background = Color.fromARGB(255, 23, 93, 145);
    const Color fill = Color.fromARGB(255, 242, 246, 250);
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    const double fillPercent = 67;
    const double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [
      0.0,
      fillStop,
      fillStop,
      1.0
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              stops: stops,
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Jestor',
                      style: TextStyle(height: 1.6, fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat Alternates'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      _isPressed ? 'R\$ 1809,12' : '',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat'),
                    ),
                    SizedBox(
                      width: _isPressed ? 0 : 126,
                      height: _isPressed ? 0 : 24,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            gradient: LinearGradient(begin: FractionalOffset.topLeft, end: FractionalOffset.bottomRight, colors: [
                              const Color.fromARGB(100, 255, 255, 255),
                              Colors.white.withOpacity(0.08),
                            ], stops: const [
                              0.0,
                              1.0
                            ])),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      iconSize: 28.0,
                      icon: Icon(_isPressed ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      color: const Color.fromARGB(128, 255, 255, 255),
                      tooltip: _isPressed ? 'Esconder saldo' : 'Mostrar saldo',
                      onPressed: () {
                        setState(() {
                          _isPressed = !_isPressed;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(20, 120),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          side: const BorderSide(
                            width: 1.0,
                            color: blue,
                          ),
                        ),
                        child: const Text(
                          'Entradas',
                          style: TextStyle(color: blue, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(120),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          side: const BorderSide(
                            width: 1.0,
                            color: blue,
                          ),
                        ),
                        child: const Text(
                          'Saídas',
                          style: TextStyle(color: blue, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                const Text(
                  'Despesas do mês por categoria',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: blue, fontFamily: 'Montserrat'),
                ),
                const Divider(color: blue),
                SfCircularChart(series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(dataSource: chartData, pointColorMapper: (ChartData data, _) => data.color, xValueMapper: (ChartData data, _) => data.x, yValueMapper: (ChartData data, _) => data.y)
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
