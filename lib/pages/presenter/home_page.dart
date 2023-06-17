import 'package:flut_jestor_app/shared/components/chart_category_widget.dart';
import 'package:flutter/material.dart';

import '../../models/chart_data_model.dart';
import '../../shared/utils/utils.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 308,
              decoration: const BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(1), bottomLeft: Radius.circular(10)),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Jestor',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat Alternates'),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.search_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
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
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(120),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side: const BorderSide(
                                    width: 1.0,
                                    color: blue,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(width: 48, child: Image.asset('assets/images/icone_entrada.png')),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Entradas',
                                      style: TextStyle(color: blue, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                  ],
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side: const BorderSide(
                                    width: 1.0,
                                    color: blue,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(width: 48, child: Image.asset('assets/images/icone_saida.png')),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Saídas',
                                      style: TextStyle(color: blue, fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 36, 16, 16),
              child: Column(
                children: [
                  const Text(
                    'Despesas do mês por categoria',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: blue, fontFamily: 'Montserrat'),
                  ),
                  const Divider(
                    color: blue,
                  ),
                  const SizedBox(height: 32),
                  ChartCategoryWidget(chartData: chartData),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: green,
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text(
              'Novo lançamento',
              style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ),
    );
  }
}
