import 'package:flut_jestor_app/services/user_service.dart';
import 'package:flutter/material.dart';

class HomeController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

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
