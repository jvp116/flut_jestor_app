import 'package:flutter/material.dart';

import '../../services/user_service.dart';
import '../../shared/utils/constants.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidUser = false;
  bool showPassword = false;

  final snackBar = const SnackBar(
    content: Text(
      "E-mail ou senha inválidos",
      textAlign: TextAlign.center,
    ),
    backgroundColor: red,
  );

  Future<bool> login(UserService service, String email, String password) async {
    isValidUser = await service.login(email, password);
    return isValidUser;
  }
}
