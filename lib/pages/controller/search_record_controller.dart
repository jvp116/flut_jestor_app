import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flutter/material.dart';

class SearchRecordController {
  final TextEditingController searchController = TextEditingController();
  List<FinancialRecordModel> listRecords = [];

  List<FinancialRecordModel> filterByDescription(List<FinancialRecordModel> records, String description) {
    listRecords = List<FinancialRecordModel>.of(records);
    listRecords.retainWhere((record) => record.description.startsWith(description));

    if (description.isEmpty) {
      return records;
    }

    if (listRecords.isEmpty) {
      List<FinancialRecordModel> listEmpty = List.empty();
      return listEmpty;
    }
    return listRecords;
  }
}
