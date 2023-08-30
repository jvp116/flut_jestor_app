import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/services/financial_record_service.dart';
import 'package:flut_jestor_app/states/financial_record_state.dart';
import 'package:flutter/material.dart';

class FinancialRecordStore extends ValueNotifier<FinancialRecordState> {
  final FinancialRecordService service;

  FinancialRecordStore(this.service) : super(InitialFinancialRecordState());

  Future fetchRecords(String type, String month) async {
    value = LoadingFinancialRecordState();
    List<FinancialRecordModel>? financialRecords;
    try {
      financialRecords = await service.fetchRecords(type, month);

      value = SuccessFinancialRecordState(financialRecords);
    } catch (e) {
      if (e.toString().contains('403')) {
        value = UnauthorizedFinancialRecordState();
      } else {
        value = ErrorFinancialRecordState(e.toString());
      }
    }
  }

  Future createRecord(double value, String date, String description, int categoryId) async {
    try {
      return await service.createRecord(value, date, description, categoryId);
    } catch (e) {
      rethrow;
    }
  }

  // Future<FinancialRecordModel> editCustomer(int id, String name, String lastname) async {
  //   try {
  //     FinancialRecordModel customer = await service.editCustomer(id, name, lastname);
  //     return customer;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future deleteCustomer(int id) async {
  //   try {
  //     return await service.deleteCustomer(id);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
