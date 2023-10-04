import 'package:brasil_fields/brasil_fields.dart';
import 'package:flut_jestor_app/models/financial_record_model.dart';
import 'package:flut_jestor_app/services/user_service.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final formKeyPassword = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isPressed = true;
  bool isOut = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  Future<bool> logout(UserService service, String? accessToken) async {
    isOut = await service.logout(accessToken);
    return isOut;
  }

  Future<bool> delete(UserService service, String email) async {
    return await service.delete(email);
  }

  Future<bool> updatePassword(UserService service, String email, String newPassword) async {
    return await service.updatePassword(email, newPassword);
  }

  String getTotalMes(List<FinancialRecordModel> financialRecords) {
    double totalMes = 0;

    for (var record in financialRecords) {
      if (record.category.type.contains('ENTRADA')) {
        totalMes += record.value;
      } else {
        totalMes -= record.value;
      }
    }

    return UtilBrasilFields.obterReal(totalMes);
  }
}
