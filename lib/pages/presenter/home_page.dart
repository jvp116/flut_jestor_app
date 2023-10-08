import 'package:brasil_fields/brasil_fields.dart';
import 'package:flut_jestor_app/models/chart_data_model.dart';
import 'package:flut_jestor_app/pages/controller/financial_record_controller.dart';
import 'package:flut_jestor_app/pages/controller/home_controller.dart';
import 'package:flut_jestor_app/pages/presenter/financial_record_page.dart';
import 'package:flut_jestor_app/pages/presenter/login_page.dart';
import 'package:flut_jestor_app/pages/presenter/search/search_record_page.dart';
import 'package:flut_jestor_app/shared/components/chart_category_widget.dart';
import 'package:flut_jestor_app/shared/components/drawer_widget.dart';
import 'package:flut_jestor_app/shared/components/dropdown_category_button_widget.dart';
import 'package:flut_jestor_app/states/financial_record_state.dart';
import 'package:flut_jestor_app/stores/financial_record_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../shared/utils/utils.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({super.key, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = HomeController();
  final FinancialRecordController financialRecordController = FinancialRecordController();
  String totalMes = '';
  DateTime dateTime = DateTime.now();
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FinancialRecordStore>().fetchAllRecords(DateFormat.M().format(DateTime.now()), DateFormat.y().format(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    financialRecordController.initialize(context.watch<FinancialRecordStore>());

    return AnimatedBuilder(
      animation: financialRecordController,
      builder: (context, child) {
        return verifyPage();
      },
    );
  }

  Widget verifyPage() {
    if (financialRecordController.state is UnauthorizedFinancialRecordState) {
      return const LoginPage();
    }

    totalMes = financialRecordController.state is SuccessFinancialRecordState
        ? controller.getTotalMes(financialRecordController.state.financialRecords)
        : '0,00';

    chartData = financialRecordController.state is SuccessFinancialRecordState
        ? controller.getChartData(financialRecordController.state.financialRecords)
        : [];

    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: DrawerWidget(controller: controller, email: widget.email),
      appBar: AppBar(
        title: const Text('Jestor', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat Alternates')),
        backgroundColor: blue,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchRecordPage(controller: financialRecordController)),
              );
            },
            icon: const Icon(Icons.search_outlined, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              controller.scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
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
              decoration: const BoxDecoration(
                  color: blue, borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "R\$ ",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    Text(
                                      controller.isPressed ? totalMes : '',
                                      style:
                                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat'),
                                    ),
                                    SizedBox(
                                      width: controller.isPressed ? 0 : 132,
                                      height: controller.isPressed ? 0 : 24,
                                      child: DecoratedBox(
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color.fromARGB(70, 255, 255, 255)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      iconSize: 28.0,
                                      icon: Icon(controller.isPressed ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                      color: const Color.fromARGB(128, 255, 255, 255),
                                      tooltip: controller.isPressed ? 'Esconder saldo' : 'Mostrar saldo',
                                      onPressed: () {
                                        setState(() {
                                          controller.isPressed = !controller.isPressed;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    showCupertinoModalPopup(
                                        barrierColor: Colors.white,
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(56),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        height: 250,
                                                        child: CupertinoDatePicker(
                                                          backgroundColor: Colors.white,
                                                          initialDateTime: dateTime,
                                                          onDateTimeChanged: (DateTime newTime) {
                                                            setState(() => dateTime = newTime);
                                                          },
                                                          mode: CupertinoDatePickerMode.monthYear,
                                                          minimumDate: DateTime(2001),
                                                          maximumDate: DateTime(2099),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          context
                                                              .read<FinancialRecordStore>()
                                                              .fetchAllRecords(DateFormat.M().format(dateTime), DateFormat.y().format(dateTime));
                                                          financialRecordController.dateController =
                                                              TextEditingController(text: DateFormat('dd/MM/yyyy').format(dateTime));

                                                          Navigator.pop(context);
                                                        },
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
                                                          'Selecionar',
                                                          style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ));
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(50, 255, 255, 255)),
                                      elevation: MaterialStateProperty.all(0)),
                                  child: Text(DateFormat("MMM y", "pt_BR").format(dateTime),
                                      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const FinancialRecordPage(
                                              title: 'Entradas',
                                              type: 'ENTRADA',
                                            )),
                                  );
                                },
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FinancialRecordPage(
                                        title: 'Saídas',
                                        type: 'SAIDA',
                                      ),
                                    ),
                                  );
                                },
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
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                children: [
                  const Text(
                    'Despesas do mês',
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
            onPressed: () {
              showModalBottomSheet(
                context: controller.scaffoldKey.currentContext!,
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
                              child: Text("Novo lançamento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: blue)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: financialRecordController.formKeyNewFinancialRecord,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("categoria",
                                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontWeight: FontWeight.w500, fontSize: 12)),
                                  DropDownCategoryButtonWidget(financialRecordController: financialRecordController),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("valor",
                                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontWeight: FontWeight.w500, fontSize: 12)),
                                            TextFormField(
                                              controller: financialRecordController.valueController,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly, RealInputFormatter(moeda: true)],
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
                                                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontWeight: FontWeight.w500, fontSize: 12)),
                                            TextField(
                                              controller: financialRecordController.dateController,
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
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2001),
                                                  lastDate: DateTime(2101),
                                                );
                                                if (pickedDate != null) {
                                                  String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                                                  setState(() {
                                                    financialRecordController.dateController.text = formattedDate;
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
                                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5), fontWeight: FontWeight.w500, fontSize: 12)),
                                  TextFormField(
                                    controller: financialRecordController.descriptionController,
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
                                if (financialRecordController.formKeyNewFinancialRecord.currentState!.validate()) {
                                  financialRecordController.createRecord().then((value) {
                                    context
                                        .read<FinancialRecordStore>()
                                        .fetchAllRecords(DateFormat.M().format(dateTime), DateFormat.y().format(dateTime));

                                    ScaffoldMessenger.of(context).showSnackBar(Utils().snackBarSuccess('Lançamento cadastrado com sucesso!'));
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(64),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                backgroundColor: greenLight,
                                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              child: const Text('Pronto', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat')),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ).then((value) {
                financialRecordController.valueController.updateValue(0);
                financialRecordController.dateController.text = DateFormat('dd/MM/yyyy').format(dateTime);
                financialRecordController.descriptionController.text = '';
              });
            },
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
