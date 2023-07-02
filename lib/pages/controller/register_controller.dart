import 'package:flutter/material.dart';

import '../../services/user_service.dart';

class RegisterController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isValidUser = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  Future<bool> register(UserService service, String email, String password) async {
    isValidUser = await service.register(email, password);
    return isValidUser;
  }
}
