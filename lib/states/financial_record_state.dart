import 'package:flut_jestor_app/models/financial_record_model.dart';

abstract class FinancialRecordState {}

// Initial, Success, Error, Loading
class InitialFinancialRecordState extends FinancialRecordState {}

class SuccessFinancialRecordState extends FinancialRecordState {
  final ListFinancialRecordModel data;
  SuccessFinancialRecordState(this.data);
}

class LoadingFinancialRecordState extends FinancialRecordState {}

class ErrorFinancialRecordState extends FinancialRecordState {
  final String message;

  ErrorFinancialRecordState(this.message);
}

class UnauthorizedFinancialRecordState extends FinancialRecordState {}
