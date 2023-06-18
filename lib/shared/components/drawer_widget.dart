import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
