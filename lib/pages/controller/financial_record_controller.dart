import 'package:flut_jestor_app/stores/financial_record_store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinancialRecordController extends ChangeNotifier {
  late FinancialRecordStore? store;
  var state;

  initialize(FinancialRecordStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  String getDate(DateTime date) {
    return DateFormat("EEEE',' d MMM y", "pt_BR").format(date);
  }
}
