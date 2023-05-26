import 'package:bcrypt/bcrypt.dart';
import 'package:flut_jestor_app/features/user/stores/user_store.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  late UserStore? store;
  var state;

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  StringBuffer hashedPassword = StringBuffer();

  bool showPassword = false;
  bool showConfirmPassword = false;

  initialize(UserStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  Future<void> createUser(String email, String password) async {
    bool created = await store!.createUser(email, password);
    if (created) {
      // TODO mostrar mensagem de sucesso ou falha para o usuário
    }
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

  String hashPassword(String password) {
    hashedPassword.clear();
    hashedPassword.write(BCrypt.hashpw(
      password,
      BCrypt.gensalt(),
    ));

    return hashedPassword.toString();
  }
}
