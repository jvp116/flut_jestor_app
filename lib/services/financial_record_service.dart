import 'package:dio/dio.dart';
import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';

class FinancialRecordService {
  final Dio dio;

  FinancialRecordService(this.dio);

  Future<List<FinancialRecordModel>> fetchRecords() async {
    final response = await dio.get('$basePath/api/v1/financial-record');
    final list = response.data as List;
    return list.map((e) => FinancialRecordModel.fromMap(e)).toList();
  }

  // Future<FinancialRecordModel> createCustomer(String cpf, String name, String lastname) async {
  //   Map<String, dynamic> data = {
  //     'cpf': cpf,
  //     'nome': name,
  //     'sobrenome': lastname,
  //   };

  //   final response = await dio.post('$basePath/clientes', data: data);

  //   return FinancialRecordModel.fromMap(response.data);
  // }

  // Future<FinancialRecordModel> editCustomer(int id, String name, String lastname) async {
  //   Map<String, dynamic> data = {
  //     'nome': name,
  //     'sobrenome': lastname,
  //   };

  //   final response = await dio.put('$basePath/clientes/$id', data: data);

  //   return FinancialRecordModel.fromMap(response.data);
  // }

  // Future<bool> deleteCustomer(int id) async {
  //   var response = await dio.delete('$basePath/clientes/$id');
  //   if (response.statusCode == 204) {
  //     return true;
  //   }
  //   return false;
  // }
}
