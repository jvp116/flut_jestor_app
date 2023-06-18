import 'package:flut_jestor_app/shared/components/chart_category_widget.dart';
import 'package:flut_jestor_app/shared/components/drawer_widget.dart';
import 'package:flutter/material.dart';

import '../../models/chart_data_model.dart';
import '../../shared/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isPressed = true;

  final List<ChartData> chartData = [
    ChartData('Alimentação', 2510, red),
    ChartData('Compras', 3114, purple),
    ChartData('Educação', 9000, purpleLight),
    ChartData('Lazer', 9000, yellow),
    ChartData('Moradia', 9000, yellowAccent),
    ChartData('Pet', 5002.56, brown),
    ChartData('Saúde', 3098, green),
    ChartData('Transporte', 1400, blueLight),
    ChartData('Outras Saídas', 9000, blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'Jestor',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat Alternates'),
        ),
        backgroundColor: blue,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              _isPressed ? 'R\$ 1809,12' : '',
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat'),
                            ),
                            SizedBox(
                              width: _isPressed ? 0 : 132,
                              height: _isPressed ? 0 : 24,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromARGB(84, 255, 255, 255),
                                ),
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
                                  minimumSize: const Size.fromHeight(96),
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
                                  minimumSize: const Size.fromHeight(96),
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
              backgroundColor: greenLight,
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
