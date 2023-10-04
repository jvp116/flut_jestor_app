import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flutter/material.dart';

class SearchRecordController {
  final TextEditingController searchController = TextEditingController();

  List<FinancialRecordModel> filterByDescription(List<FinancialRecordModel> records, String description) {
    var recordsFiltered = List<FinancialRecordModel>.of(records);
    recordsFiltered.retainWhere((record) => record.description.startsWith(description));

    if (description.isEmpty) {
      return records;
    }

    if (recordsFiltered.isEmpty) {
      List<FinancialRecordModel> listEmpty = List.empty();
      return listEmpty;
    }
    return recordsFiltered;
  }
}
