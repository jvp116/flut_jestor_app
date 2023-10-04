import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/pages/controller/financial_record_controller.dart';
import 'package:flut_jestor_app/pages/controller/search_record_controller.dart';
import 'package:flut_jestor_app/pages/presenter/search/search_list_record_page.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchRecordPage extends StatefulWidget {
  final FinancialRecordController controller;

  const SearchRecordPage({super.key, required this.controller});

  @override
  State<SearchRecordPage> createState() => _SearchRecordPageState();
}

class _SearchRecordPageState extends State<SearchRecordPage> {
  final SearchRecordController controller = SearchRecordController();

  var searchListPage = SearchListRecordPage(
    records: const [],
    controller: FinancialRecordController(),
  );

  @override
  void initState() {
    super.initState();
    widget.controller.state.financialRecords.sort((FinancialRecordModel a, FinancialRecordModel b) => b.date.compareTo(a.date));
    searchListPage = SearchListRecordPage(records: widget.controller.state.financialRecords, controller: widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
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
                          setState(() {
                            searchListPage = SearchListRecordPage(
                                records: controller.filterByDescription(widget.controller.state.financialRecords, controller.searchController.text),
                                controller: widget.controller);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: searchListPage,
                  ))
                ],
              ),
            ));
      },
    );
  }
}
