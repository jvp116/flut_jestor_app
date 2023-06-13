import 'package:flutter/material.dart';

import '../../services/user_service.dart';
import '../../shared/utils/constants.dart';

class RegisterController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isValidUser = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  final snackBar = const SnackBar(
    content: Text(
      "Ops! Este e-mail já está cadastrado ",
      textAlign: TextAlign.center,
    ),
    backgroundColor: red,
  );

  Future<bool> register(UserService service, String email, String password) async {
    isValidUser = await service.register(email, password);
    return isValidUser;
  }

  // Future<void> editUser(int id, String email, String password) async {
  //   bool edited = await store!.editUser(id, email, password);
  //   if (edited) {
  //     // TODO mostrar mensagem de sucesso ou falha para o usuário
  //   }
  //   notifyListeners();
  // }

  // Future<void> deleteuser(UserModel user) async {
  //   bool deleted = await store!.deleteUser(user.id);
  //   if (deleted) {
  //     // TODO mostrar mensagem de sucesso ou falha para o usuário
  //     // TODO retornar a tela de login
  //   }
  //   notifyListeners();
  // }

  // initFormEdit(String email, String password) {
  //   emailController.text = email;
  //   passwordController.text = password;
  // }
}
