import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/components/custom_text_form_field_widget.dart';
import '../../services/user_service.dart';
import '../../shared/utils/utils.dart';
import '../controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = LoginController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserService service = Provider.of<UserService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                const Column(
                  children: [
                    Icon(
                      Icons.currency_exchange_outlined,
                      color: Colors.white,
                      size: 80,
                    ),
                    Text(
                      'Jestor',
                      style:
                          TextStyle(height: 1.6, fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat Alternates'),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 360,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(128, 0, 0, 0),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CustomTextFormFieldWidget(
                                typeField: "email",
                                textController: controller.emailController,
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: controller.passwordController,
                                obscureText: controller.showPassword == false ? true : false,
                                enableInteractiveSelection: false,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(0),
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Senha',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(128, 0, 0, 0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  suffixIcon: GestureDetector(
                                      child: Icon(
                                        controller.showPassword == false ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                        color: blueAccent,
                                      ),
                                      onTap: () => setState(() {
                                            controller.showPassword = !controller.showPassword;
                                          })),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, digite sua senha';
                                  }

                                  if (value.length < 8) {
                                    return "A senha deve ter no mínimo 8 caracteres";
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (controller.formKey.currentState!.validate()) {
                                    controller.login(service, controller.emailController.text, controller.passwordController.text).then((value) {
                                      if (controller.isValidUser) {
                                        Navigator.pushReplacementNamed(context, '/home');
                                      }
                                    }).onError((error, stackTrace) {
                                      controller.passwordController.clear();
                                      ScaffoldMessenger.of(context).showSnackBar(Utils().snackBarError("E-mail ou senha inválidos"));
                                    });

                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: greenLight,
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: const Size.fromHeight(52),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/register');
                                },
                                child: const Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    color: blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
