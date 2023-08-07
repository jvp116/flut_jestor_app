import 'package:flut_jestor_app/pages/controller/financial_record_controller.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class ListFinancialRecordPage extends StatefulWidget {
  final FinancialRecordController controller;

  const ListFinancialRecordPage({super.key, required this.controller});

  @override
  State<ListFinancialRecordPage> createState() => _ListFinancialRecordPageState();
}

class _ListFinancialRecordPageState extends State<ListFinancialRecordPage> {
  bool _isPressed = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'total do mês',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  Row(
                    children: [
                      const Text(
                        "R\$ ",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        _isPressed ? '10.000,00' : '',
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
                      const Spacer(),
                      IconButton(
                        iconSize: 32,
                        visualDensity: VisualDensity.comfortable,
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
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.controller.state.financialRecords.length,
                      itemBuilder: (context, index) {
                        final financialRecord = widget.controller.state.financialRecords[index];

                        return ListTile(
                            leading: Text('${financialRecord.id}', style: const TextStyle(fontSize: 14)),
                            title: Text(financialRecord.description),
                            subtitle: Text(financialRecord.value),
                            onTap: () {
                              showModalBottomSheet(
                                constraints: BoxConstraints.tight(Size(MediaQuery.of(context).size.width, 160)),
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("${financialRecord.id} ${financialRecord.description}", style: const TextStyle(fontSize: 24)),
                                          const SizedBox(height: 16),
                                          ElevatedButton(
                                            child: const Text('Fechar'),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
