import 'package:flut_jestor_app/models/category_model.dart';
import 'package:flut_jestor_app/models/user_model.dart';

class FinancialRecordModel {
  int id;
  double value;
  String date;
  String description;
  UserModel user;
  CategoryModel category;

  FinancialRecordModel({
    required this.id,
    required this.value,
    required this.date,
    required this.description,
    required this.user,
    required this.category,
  });

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
