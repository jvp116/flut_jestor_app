import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flutter/material.dart';

class SearchRecordController {
  final TextEditingController searchController = TextEditingController();

  filterByDescription(List<FinancialRecordModel> records, String description) {
    var recordsFiltered = List<FinancialRecordModel>.of(records);
    recordsFiltered.retainWhere((record) => record.description.startsWith(description));

    if (description.isEmpty || recordsFiltered.isEmpty) {
      return records;
    }
    description = "";
    return recordsFiltered;
  }
}
