import 'package:bcrypt/bcrypt.dart';
import 'package:flut_jestor_app/features/user/stores/user_store.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  late UserStore? store;
  var state;

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  StringBuffer hashedPassword = StringBuffer();

  bool isValidUser = false;
  bool showPassword = false;

  initialize(UserStore newStore) {
    store = newStore;
    state = store!.value;
    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    isValidUser = await store!.login(email, password);
    if (isValidUser) {
      // TODO logar no app
    }
    notifyListeners();
  }

  String hashPassword(String password) {
    hashedPassword.clear();
    hashedPassword.write(BCrypt.hashpw(
      password,
      BCrypt.gensalt(),
    ));

    return hashedPassword.toString();
  }
}
