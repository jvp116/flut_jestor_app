import 'package:flutter/material.dart';

import '../../services/user_service.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidUser = false;
  bool showPassword = false;

  Future<bool> login(UserService service, String email, String password) async {
    isValidUser = await service.login(email, password);
    return isValidUser;
  }
}
