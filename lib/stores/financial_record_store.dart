import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/services/financial_record_service.dart';
import 'package:flut_jestor_app/states/financial_record_state.dart';
import 'package:flutter/material.dart';

class FinancialRecordStore extends ValueNotifier<FinancialRecordState> {
  final FinancialRecordService service;

  FinancialRecordStore(this.service) : super(InitialFinancialRecordState());

  Future fetchRecords(String type, String month, String year) async {
    value = LoadingFinancialRecordState();
    ListFinancialRecordModel? data;
    try {
      data = await service.fetchRecords(type, month, year);

      value = SuccessFinancialRecordState(data);
    } catch (e) {
      if (e.toString().contains('403')) {
        value = UnauthorizedFinancialRecordState();
      } else {
        value = ErrorFinancialRecordState(e.toString());
      }
    }
  }

  Future createRecord(double value, String description, String date, int month, int year, int categoryId, String type) async {
    try {
      return await service.createRecord(value, description, date, month, year, categoryId, type);
    } catch (e) {
      rethrow;
    }
  }

  Future editRecord(int id, double value, String description, String date, int month, String type) async {
    try {
      return await service.editRecord(id, value, description, date, month, type);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteRecord(int id) async {
    try {
      return await service.deleteRecord(id);
    } catch (e) {
      rethrow;
    }
  }
}
