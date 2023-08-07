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

  String getActualMonth() {
    var now = DateTime.now();
    String formattedDate = DateFormat.M().format(now);

    switch (formattedDate) {
      case '1':
        return 'Jan';
      case '2':
        return 'Fev';
      case '3':
        return 'Mar';
      case '4':
        return 'Abr';
      case '5':
        return 'Mai';
      case '6':
        return 'Jun';
      case '7':
        return 'Jul';
      case '8':
        return 'Ago';
      case '9':
        return 'Set';
      case '10':
        return 'Out';
      case '11':
        return 'Nov';
      case '12':
        return 'Dez';
      default:
        return '';
    }
  }
}
