import 'package:brasil_fields/brasil_fields.dart';
import 'package:flut_jestor_app/pages/controller/financial_record_controller.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.controller.state.data.financialRecords.length,
              itemBuilder: (context, index) {
                final financialRecord = widget.controller.state.data.financialRecords[index];

                return ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                    leading: SizedBox(
                      width: 36,
                      child: Image.asset(
                        'assets/images/${financialRecord.category.icon}.png',
                      ),
                    ),
                    title: Text(financialRecord.description, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: blue)),
                    subtitle: Text(
                      UtilBrasilFields.obterReal(financialRecord.value),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: blue),
                    ),
                    trailing: Text(widget.controller.getDate(DateTime.parse(financialRecord.date)),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: blue)),
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(23, 93, 145, 0.15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(financialRecord.description,
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: blue)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("valor",
                                                  style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontWeight: FontWeight.w500, fontSize: 12)),
                                              const SizedBox(height: 4),
                                              Text(UtilBrasilFields.obterReal(financialRecord.value),
                                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: blue)),
                                            ],
                                          ),
                                          Container(
                                            width: 1,
                                            height: 60,
                                            color: blueAccent,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("data",
                                                  style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontWeight: FontWeight.w500, fontSize: 12)),
                                              const SizedBox(height: 4),
                                              Text(UtilData.obterDataDDMMAAAA(DateTime.parse(financialRecord.date)),
                                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: blue)),
                                            ],
                                          ),
                                          Container(
                                            width: 1,
                                            height: 60,
                                            color: blueAccent,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("categoria",
                                                  style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontWeight: FontWeight.w500, fontSize: 12)),
                                              const SizedBox(height: 4),
                                              Text(financialRecord.category.description,
                                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: blue)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.vertical(
                                                    top: Radius.circular(10.0),
                                                  ),
                                                ),
                                                isScrollControlled: true,
                                                builder: (BuildContext context) {
                                                  return Wrap(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment.centerLeft,
                                                            decoration: const BoxDecoration(
                                                              color: Color.fromRGBO(23, 93, 145, 0.15),
                                                            ),
                                                            child: const Padding(
                                                              padding: EdgeInsets.all(16.0),
                                                              child: Text("Editar lançamento",
                                                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: blue)),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(16.0),
                                                            child: Form(
                                                              key: widget.controller.formKeyEditFinancialRecord,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const Text("categoria",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 12)),
                                                                  TextFormField(
                                                                      controller:
                                                                          widget.controller.getCategoryForEdit(financialRecord.category.description),
                                                                      enabled: false,
                                                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: blue)),
                                                                  const SizedBox(height: 16),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text("valor",
                                                                                style: TextStyle(
                                                                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 12)),
                                                                            TextFormField(
                                                                              controller: widget.controller.getValueForEdit(financialRecord.value),
                                                                              inputFormatters: [
                                                                                FilteringTextInputFormatter.digitsOnly,
                                                                                RealInputFormatter(moeda: true)
                                                                              ],
                                                                              decoration: const InputDecoration(
                                                                                border: UnderlineInputBorder(),
                                                                                enabledBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: Color.fromRGBO(23, 93, 145, 0.25)),
                                                                                ),
                                                                                focusedBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: blue),
                                                                                ),
                                                                              ),
                                                                              keyboardType: TextInputType.number,
                                                                              validator: (value) {
                                                                                value = UtilBrasilFields.removerSimboloMoeda(value!);
                                                                                if (value == '0,00') {
                                                                                  return 'Por favor, digite um valor';
                                                                                }
                                                                                return null;
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const SizedBox(width: 24),
                                                                      Expanded(
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text("data",
                                                                                style: TextStyle(
                                                                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 12)),
                                                                            TextField(
                                                                              controller: widget.controller.getDateForEdit(financialRecord.date),
                                                                              decoration: const InputDecoration(
                                                                                suffixIcon: Icon(Icons.edit_calendar_outlined, color: blue, size: 24),
                                                                                border: UnderlineInputBorder(),
                                                                                enabledBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: Color.fromRGBO(23, 93, 145, 0.25)),
                                                                                ),
                                                                                focusedBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: blue),
                                                                                ),
                                                                              ),
                                                                              readOnly: true,
                                                                              onTap: () async {
                                                                                DateTime? pickedDate = await showDatePicker(
                                                                                  builder: (context, child) {
                                                                                    return Theme(
                                                                                      data: Theme.of(context).copyWith(
                                                                                        colorScheme: const ColorScheme.light(
                                                                                          primary: blue,
                                                                                          onPrimary: Colors.white,
                                                                                          onSurface: Colors.black,
                                                                                        ),
                                                                                        textButtonTheme: TextButtonThemeData(
                                                                                          style: TextButton.styleFrom(foregroundColor: blue),
                                                                                        ),
                                                                                      ),
                                                                                      child: child!,
                                                                                    );
                                                                                  },
                                                                                  locale: const Locale('pt', 'BR'),
                                                                                  context: context,
                                                                                  initialDate: DateTime.parse(financialRecord.date),
                                                                                  firstDate: DateTime(2001),
                                                                                  lastDate: DateTime(2101),
                                                                                );
                                                                                if (pickedDate != null) {
                                                                                  String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                                                                                  setState(() {
                                                                                    widget.controller.dateEditController.text = formattedDate;
                                                                                  });
                                                                                }
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 16),
                                                                  const Text("descrição",
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 12)),
                                                                  TextFormField(
                                                                    controller: widget.controller.getDescriptionForEdit(financialRecord.description),
                                                                    decoration: const InputDecoration(
                                                                      border: UnderlineInputBorder(),
                                                                      enabledBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: Color.fromRGBO(23, 93, 145, 0.25)),
                                                                      ),
                                                                      focusedBorder: UnderlineInputBorder(
                                                                        borderSide: BorderSide(color: blue),
                                                                      ),
                                                                    ),
                                                                    keyboardType: TextInputType.text,
                                                                    maxLength: 40,
                                                                    validator: (value) {
                                                                      if (value!.isEmpty) {
                                                                        return 'Por favor, digite uma descrição';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(24),
                                                            child: ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                                Navigator.pop(context);
                                                                if (widget.controller.formKeyEditFinancialRecord.currentState!.validate()) {
                                                                  widget.controller.editRecord(financialRecord).then((value) {
                                                                    ScaffoldMessenger.of(context)
                                                                        .showSnackBar(Utils().snackBarSuccess('Lançamento editado com sucesso!'));
                                                                  }).onError((error, stackTrace) {
                                                                    ScaffoldMessenger.of(context).showSnackBar(Utils()
                                                                        .snackBarError("Ops, não foi possível editar os dados tente mais tarde"));
                                                                  });
                                                                }
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                minimumSize: const Size.fromHeight(64),
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                                backgroundColor: greenLight,
                                                                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                              ),
                                                              child: const Text('Pronto',
                                                                  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat')),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit_rounded,
                                              color: purple,
                                            ),
                                            label: const Text(
                                              'Editar',
                                              style: TextStyle(color: purple, fontFamily: 'Montserrat'),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(20),
                                              side: const BorderSide(color: purple, width: 2),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              backgroundColor: const Color.fromARGB(255, 245, 235, 247),
                                              textStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) => AlertDialog(
                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  title: const Text(
                                                    'Excluir lançamento',
                                                    style:
                                                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: blue),
                                                  ),
                                                  content: const Text(
                                                    'Você tem certeza de que deseja excluir os dados do lançamento?',
                                                    style:
                                                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Montserrat', color: blue),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context),
                                                      child: const Text(
                                                        'Não',
                                                        style: TextStyle(
                                                            fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: red),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        widget.controller.deleteRecord(financialRecord).then((value) {
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(Utils().snackBarSuccess("Lançamento excluído com sucesso"));
                                                        }).onError((error, stackTrace) {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              Utils().snackBarError("Ops, não foi possível excluir os dados tente mais tarde"));
                                                        });
                                                      },
                                                      child: const Text(
                                                        'Sim',
                                                        style: TextStyle(
                                                            fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: greenLight),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.delete_outlined,
                                              color: red,
                                            ),
                                            label: const Text(
                                              'Excluir',
                                              style: TextStyle(color: red, fontFamily: 'Montserrat'),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              padding: const EdgeInsets.all(20),
                                              side: const BorderSide(color: red, width: 2),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              backgroundColor: const Color.fromARGB(255, 249, 235, 234),
                                              textStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
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
                          );
                        },
                      );
                    });
              }),
        ],
      ),
    );
  }
}
