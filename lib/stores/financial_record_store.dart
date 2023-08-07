import 'package:flut_jestor_app/services/financial_record_service.dart';
import 'package:flut_jestor_app/states/financial_record_state.dart';
import 'package:flutter/material.dart';

class FinancialRecordStore extends ValueNotifier<FinancialRecordState> {
  final FinancialRecordService service;

  FinancialRecordStore(this.service) : super(InitialFinancialRecordState());

  Future fetchCustomers() async {
    value = LoadingFinancialRecordState();
    try {
      final financialRecords = await service.fetchCustomers();
      value = SuccessFinancialRecordState(financialRecords);
    } catch (e) {
      value = ErrorFinancialRecordState(e.toString());
    }
  }

  Future createCustomer(String cpf, String name, String lastname) async {
    try {
      return await service.createCustomer(cpf, name, lastname);
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
