import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;

  Future<void> createUser(String email, String password) async {
    // bool created = await store!.createUser(email, password);
    // if (created) {
    // }
    notifyListeners();
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
