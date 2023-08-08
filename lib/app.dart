import 'package:dio/dio.dart';
import 'package:flut_jestor_app/pages/presenter/home_page.dart';
import 'package:flut_jestor_app/pages/presenter/login_page.dart';
import 'package:flut_jestor_app/pages/presenter/register_page.dart';
import 'package:flut_jestor_app/pages/presenter/welcome_page.dart';
import 'package:flut_jestor_app/services/financial_record_service.dart';
import 'package:flut_jestor_app/services/user_service.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flut_jestor_app/stores/financial_record_store.dart';
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
        Provider(create: (context) => FinancialRecordService(context.read())),
        ChangeNotifierProvider(create: (context) => FinancialRecordStore(context.read())),
      ],
      child: MaterialApp(
        title: 'Jestor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: blue, fontFamily: 'Montserrat'),
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomePage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(email: ''),
        },
      ),
    );
  }
}
