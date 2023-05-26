import 'package:flut_jestor_app/features/user/services/user_service.dart';
import 'package:flut_jestor_app/features/user/states/user_state.dart';
import 'package:flutter/material.dart';

class UserStore extends ValueNotifier<UserState> {
  final UserService service;

  UserStore(this.service) : super(InitialUserState());

  Future login(String email, String password) async {
    value = LoadingUserState();
    try {
      final login = await service.loginUser(email, password);
      value = SuccessUserState(login);
    } catch (e) {
      value = ErrorUserState(e.toString());
    }
  }

  Future createUser(String email, String password) async {
    try {
      return await service.createUser(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editUser(int id, String email, String password) async {
    try {
      return await service.editUser(id, email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteUser(int id) async {
    try {
      return await service.deleteUser(id);
    } catch (e) {
      rethrow;
    }
  }
}
