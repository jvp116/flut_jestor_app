import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/pages/controller/financial_record_controller.dart';
import 'package:flut_jestor_app/shared/components/list_all_records_widget.dart';
import 'package:flut_jestor_app/shared/components/loading_widget.dart';
import 'package:flut_jestor_app/shared/components/screen_forbidden_widget.dart';
import 'package:flut_jestor_app/shared/components/start_default_widget.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flut_jestor_app/states/financial_record_state.dart';
import 'package:flut_jestor_app/stores/financial_record_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchRecordPage extends StatefulWidget {
  const SearchRecordPage({super.key});

  @override
  State<SearchRecordPage> createState() => _SearchRecordPageState();
}

class _SearchRecordPageState extends State<SearchRecordPage> {
  final FinancialRecordController controller = FinancialRecordController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FinancialRecordStore>().fetchAllRecords();
    });
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
          centerTitle: true,
          backgroundColor: blue,
          elevation: 0,
          title: const Text(
            'Lançamentos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: blue, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SearchBar(
                    controller: controller.searchController,
                    leading: const Icon(Icons.search_rounded, color: blue),
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                    hintText: 'Pesquisar por descrição',
                    hintStyle: MaterialStateProperty.all(const TextStyle(color: Colors.grey)),
                    padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                    onChanged: (_) {
                      List<FinancialRecordModel> duplicatedList = List.of(controller.state.financialRecords);
                      List<FinancialRecordModel> searchedRecords = [];

                      for (var element in controller.state.financialRecords) {
                        if (element.description.startsWith(controller.searchController.text)) {
                          searchedRecords.add(element);
                          duplicatedList.remove(element);
                        }
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16),
                child: configPage(),
              ))
            ],
          ),
        ));
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

    if (controller.state is SuccessAllFinancialRecordState && controller.state.financialRecords.isNotEmpty) {
      return ListAllRecordsWidget(controller: controller);
    }

    return const StartDefaultWidget(
        iconData: Icons.currency_exchange_rounded, title: 'Hummm...', subtitle: 'Você não possui lançamentos cadastrados esse mês.');
  }
}
