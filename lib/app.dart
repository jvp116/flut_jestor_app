import 'package:dio/dio.dart';
import 'package:flut_jestor_app/pages/presenter/welcome_page.dart';
import 'package:flut_jestor_app/services/user_service.dart';
import 'package:flut_jestor_app/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        // ChangeNotifierProvider(create: (context) => ProductStore(context.read())),
      ],
      child: MaterialApp(
        title: 'Jestor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: blue, fontFamily: 'Montserrat'),
        home: const WelcomePage(),
      ),
    );
  }
}
