// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flut_jestor_app/pages/controller/home_controller.dart';
import 'package:flut_jestor_app/services/user_service.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatelessWidget {
  final HomeController controller;

  const DrawerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserService service = Provider.of<UserService>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 88,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: blue,
              ),
              child: Text(
                'Meu Perfil',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat'),
              ),
            ),
          ),
          Column(
            children: [
              const ListTile(
                leading: Icon(
                  Icons.person_outline,
                  color: blue,
                  size: 24,
                ),
                title: Text(
                  'usuario@email.com',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                ),
              ),
              const Divider(
                height: 1,
                indent: 8,
                endIndent: 8,
                color: blueAccent,
              ),
              ListTile(
                leading: const Icon(
                  Icons.lock_outline,
                  color: blue,
                ),
                title: const Text(
                  'Alterar senha',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: blue,
                ),
                title: const Text(
                  'Excluir conta',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app_outlined,
                  color: blue,
                ),
                title: const Text(
                  'Sair',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                ),
                onTap: () async {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                  controller.logout(service, sharedPreferences.getString('access_token')).then((value) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(Utils().snackBarError("E-mail ou senha inválidos"));
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
