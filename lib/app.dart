import 'package:dio/dio.dart';
import 'package:flut_jestor_app/features/user/services/user_service.dart';
import 'package:flut_jestor_app/features/user/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/user/pages/login/presenter/login_page.dart';
import 'features/user/pages/login/presenter/register_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Dio()),
        Provider(create: (context) => UserService(context.read())),
        // Provider(create: (context) => ProductService(context.read())),
        ChangeNotifierProvider(create: (context) => UserStore(context.read())),
        // ChangeNotifierProvider(create: (context) => ProductStore(context.read())),
      ],
      child: MaterialApp(title: 'Jestor', debugShowCheckedModeBanner: false, theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 23, 92, 145), fontFamily: 'Montserrat'), initialRoute: '/', routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      }),
    );
  }
}
