import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidUser = false;
  bool showPassword = false;

  Future<void> loginUser(String email, String password) async {
    // isValidUser = await store!.login(email, password);
    if (isValidUser) {
      print('login efetuado com sucesso');
    }
    notifyListeners();
  }
}
