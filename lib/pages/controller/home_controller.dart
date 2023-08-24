import 'package:flut_jestor_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

class HomeController {
  final formKeyNewFinancialRecord = GlobalKey<FormState>();
  var valueController = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$ ');
  final TextEditingController dateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final TextEditingController descriptionController = TextEditingController();

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
}
