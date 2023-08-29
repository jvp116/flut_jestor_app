import 'package:dio/dio.dart';
import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinancialRecordService {
  final Dio dio;

  FinancialRecordService(this.dio);

  Future<List<FinancialRecordModel>> fetchRecords(String type, String month) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Response response = Response(requestOptions: RequestOptions());

    try {
      dio.options.headers["authorization"] = "Bearer ${sharedPreferences.getString('access_token')}";
      String? email = sharedPreferences.getString('email');
      Map<String, dynamic> data = {"email": email, "type": type, "month": month};

      final response = await dio.get('$basePath/financial-record', data: data);
      final list = response.data as List;
      return list.map((e) => FinancialRecordModel.fromMap(e)).toList();
    } catch (error) {
      if (response.statusCode == 403) {
        // TODO forbidden logar novamente no app para autenticar
      }
      throw Exception('Ocorreu um erro durante a listagem de lançamentos: $error');
    }
  }

  Future<bool> createRecord(double value, String date, String description, int categoryId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Response response = Response(requestOptions: RequestOptions());

    try {
      dio.options.headers["authorization"] = "Bearer ${sharedPreferences.getString('access_token')}";
      String? email = sharedPreferences.getString('email');

      Map<String, dynamic> data = {
        'value': value,
        'description': description,
        'date': date,
        'categoryId': categoryId,
        'email': email,
      };

      response = await dio.post('$basePath/financial-record', data: data);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      if (response.statusCode == 403) {
        // TODO forbidden logar novamente no app para autenticar
      }
      throw Exception('Ocorreu um erro durante a criação de lançamento: $error');
    }
  }

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
