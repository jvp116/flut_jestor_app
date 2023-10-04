import 'package:flut_jestor_app/pages/controller/financial_record_controller.dart';
import 'package:flut_jestor_app/pages/presenter/list_financial_record_page.dart';
import 'package:flut_jestor_app/shared/components/loading_widget.dart';
import 'package:flut_jestor_app/shared/components/screen_forbidden_widget.dart';
import 'package:flut_jestor_app/shared/components/start_default_widget.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flut_jestor_app/states/financial_record_state.dart';
import 'package:flut_jestor_app/stores/financial_record_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialRecordPage extends StatefulWidget {
  final String title;
  final String type;

  const FinancialRecordPage({Key? key, required this.title, required this.type}) : super(key: key);

  @override
  State<FinancialRecordPage> createState() => _FinancialRecordPageState();
}

class _FinancialRecordPageState extends State<FinancialRecordPage> {
  final FinancialRecordController controller = FinancialRecordController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.initialize(context.watch<FinancialRecordStore>());

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return verifyPage();
      },
    );
  }

  Widget verifyPage() {
    if (controller.state is UnauthorizedFinancialRecordState) {
      return const ScreenForbiddenWidget(
          title: 'Ops! Parece que sua sessão expirou.',
          subtitle: 'Não se preocupe. Para continuar utilizando o app, por favor, faça login novamente.');
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat'),
          ),
        ),
        backgroundColor: blue,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: configPage(),
    );
  }

  Widget configPage() {
    if (controller.state is LoadingFinancialRecordState) {
      return const LoadingWidget();
    }

    if (controller.state is InitialFinancialRecordState) {
      return const StartDefaultWidget(
          iconData: Icons.currency_exchange_rounded, title: 'Hummm...', subtitle: 'Você não possui lançamentos cadastrados esse mês.');
    }

    if (controller.state is ErrorFinancialRecordState) {
      return const StartDefaultWidget(iconData: Icons.report_problem_rounded, title: 'Algo deu errado :(', subtitle: 'tente novamente mais tarde');
    }

    if (controller.state is SuccessFinancialRecordState &&
        controller.state.financialRecords.isNotEmpty &&
        (controller.state.financialRecords.where((record) => record.category.type == widget.type).length > 0)) {
      return ListFinancialRecordPage(controller: controller, type: widget.type);
    }

    return StartDefaultWidget(
        iconData: Icons.currency_exchange_rounded, title: 'Hummm...', subtitle: 'Você não possui ${widget.title} cadastradas nesse mês.');
  }
}
