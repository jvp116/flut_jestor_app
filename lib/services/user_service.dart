import 'package:dio/dio.dart';
import 'package:dson_adapter/dson_adapter.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final Dio dio;
  final dson = const DSON();

  UserService(this.dio);

  Future<bool> login(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };

      Response response = await dio.post('$basePath/api/v1/auth/authenticate', data: data);

      if (response.statusCode == 200) {
        await sharedPreferences.setString('access_token', (response.data)['access_token']);
        await sharedPreferences.setString('refresh_token', (response.data)['refresh_token']);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Ocorreu um erro durante o login: $error');
    }
  }

  Future<bool> register(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      Map<String, dynamic> data = {'email': email, 'password': password, 'role': 'USER'};

      // UserModel user = dson.fromJson(data, UserModel.new);

      final response = await dio.post('$basePath/api/v1/auth/register', data: data);

      if (response.statusCode == 200) {
        await sharedPreferences.setString('access_token', (response.data)['access_token']);
        await sharedPreferences.setString('refresh_token', (response.data)['refresh_token']);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Ocorreu um erro durante o cadastro de usuario: $error');
    }
  }

  Future<bool> logout(String? accessToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      dio.options.headers["authorization"] = "Bearer $accessToken";

      await sharedPreferences.clear();

      final response = await dio.post('$basePath/api/v1/auth/logout');

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (error) {
      throw Exception('Ocorreu um erro durante o logout: $error');
    }
  }

  // Future<bool> editUser(int id, String email, String password) async {
  //   try {
  //     Map<String, dynamic> data = {
  //       'email': email,
  //       'password': password,
  //     };

  //     final response = await dio.put('$basePath/user/$id', data: data);

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (error) {
  //     throw Exception('Ocorreu um erro durante a edicao de usuario: $error');
  //   }
  // }

  // Future<bool> deleteUser(int id) async {
  //   try {
  //     final response = await dio.delete('$basePath/user/$id');

  //     if (response.statusCode == 204) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (error) {
  //     throw Exception('Ocorreu um erro durante a delecao de usuario: $error');
  //   }
  // }

  Future<bool> refresh(String? refreshToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      dio.options.headers["authorization"] = "Bearer $refreshToken";

      final response = await dio.post('$basePath/api/v1/auth/refresh-token');

      if (response.statusCode == 200) {
        await sharedPreferences.setString('access_token', (response.data)['access_token']);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Ocorreu um erro ao renovar a autenticacao do usuario: $error');
    }
  }
}
