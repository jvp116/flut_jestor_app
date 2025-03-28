import 'package:flut_jestor_app/models/category_model.dart';
import 'package:flut_jestor_app/models/user_model.dart';

class FinancialRecordModel {
  int id;
  double value;
  String date;
  String description;
  UserModel? user;
  CategoryModel category;

  FinancialRecordModel({
    required this.id,
    required this.value,
    required this.date,
    required this.description,
    this.user,
    required this.category,
  });

  static FinancialRecordModel fromMap(Map<String, dynamic> map) {
    return FinancialRecordModel(
        id: map['id'] ?? 0,
        value: map['value'] ?? '',
        date: map['date'] ?? '',
        description: map['description'] ?? '',
        category: CategoryModel.fromMap(map['category'] ?? ''));
  }

  Map<String, dynamic> toMap(FinancialRecordModel financialRecord) {
    return <String, dynamic>{
      'id': financialRecord.id,
      'value': financialRecord.value,
      'date': financialRecord.date,
      'description': financialRecord.description,
      'user': UserModel.toMap(financialRecord.user),
      'category': CategoryModel.toMap(financialRecord.category),
    };
  }
}

class ListFinancialRecordModel {
  double totalMes;
  List<dynamic> financialRecords;

  ListFinancialRecordModel({
    required this.totalMes,
    required this.financialRecords,
  });

  static ListFinancialRecordModel fromMap(Map<dynamic, dynamic> map) {
    return ListFinancialRecordModel(
      totalMes: map['totalMes'] ?? 0,
      financialRecords: map['financialRecords'].map((e) => FinancialRecordModel.fromMap(e)).toList(),
    );
  }
}
