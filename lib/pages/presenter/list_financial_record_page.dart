import 'package:brasil_fields/brasil_fields.dart';
import 'package:flut_jestor_app/pages/controller/financial_record_controller.dart';
import 'package:flut_jestor_app/shared/components/list_records_widget.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class ListFinancialRecordPage extends StatefulWidget {
  final FinancialRecordController controller;

  const ListFinancialRecordPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<ListFinancialRecordPage> createState() => _ListFinancialRecordPageState();
}

class _ListFinancialRecordPageState extends State<ListFinancialRecordPage> {
  bool _isPressed = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                          AnimatedBuilder(
                            animation: widget.controller,
                            builder: (context, child) {
                              return Text(
                                _isPressed ? UtilBrasilFields.obterReal(widget.controller.state.data.totalMes, moeda: false) : '',
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat'),
                              );
                            },
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListRecordsWidget(controller: widget.controller)
        ],
      ),
    );
  }
}
