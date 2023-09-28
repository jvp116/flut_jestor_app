import 'package:dio/dio.dart';
import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinancialRecordService {
  final Dio dio;

  FinancialRecordService(this.dio);

  Future<ListFinancialRecordModel> fetchRecords(String type, String month, String year) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      dio.options.headers["authorization"] = "Bearer ${sharedPreferences.getString('access_token')}";
      String? email = sharedPreferences.getString('email');
      Map<String, dynamic> data = {"email": email, "type": type, "month": month, "year": year};

      final response = await dio.get('$basePath/financial-record', data: data);
      return ListFinancialRecordModel.fromMap(response.data);
    } catch (error) {
      if (error.toString().contains('403')) {
        throw Exception('[403] Não autorizado: $error');
      }
      throw Exception('Ocorreu um erro durante a listagem de lançamentos: $error');
    }
  }

  Future<bool> createRecord(double value, String description, String date, int month, int year, int categoryId, String type) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      dio.options.headers["authorization"] = "Bearer ${sharedPreferences.getString('access_token')}";
      String? email = sharedPreferences.getString('email');

      Map<String, dynamic> data = {
        'value': value,
        'description': description,
        'date': date,
        'month': month,
        'year': year,
        'categoryId': categoryId,
        'type': type,
        'email': email,
      };

      final response = await dio.post('$basePath/financial-record', data: data);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      // TODO forbidden logar novamente no app para autenticar
      throw Exception('Ocorreu um erro durante a criação de lançamento: $error');
    }
  }

  Future<bool> editRecord(int id, double value, String description, String date, int month, int year, String type) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      dio.options.headers["authorization"] = "Bearer ${sharedPreferences.getString('access_token')}";
      String? email = sharedPreferences.getString('email');

      Map<String, dynamic> data = {
        'value': value,
        'description': description,
        'date': date,
        'month': month,
        'year': year,
        'type': type,
        'email': email,
      };

      final response = await dio.put('$basePath/financial-record/$id', data: data);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      // TODO forbidden logar novamente no app para autenticar
      throw Exception('Ocorreu um erro durante a criação de lançamento: $error');
    }
  }

  Future<bool> deleteRecord(
    int id,
    String type,
    int month,
    int year,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      dio.options.headers["authorization"] = "Bearer ${sharedPreferences.getString('access_token')}";
      String? email = sharedPreferences.getString('email');

      Map<String, dynamic> data = {
        'email': email,
        'type': type,
        'month': month,
        'year': year,
      };

      var response = await dio.delete('$basePath/financial-record/$id', data: data);
      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (error) {
      if (error.toString().contains('403')) {
        throw Exception('[403] Não autorizado: $error');
      }
      throw Exception('Ocorreu um erro durante a deleção do lançamento $id: $error');
    }
  }
}
