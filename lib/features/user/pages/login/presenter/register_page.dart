import 'package:flut_jestor_app/features/user/pages/login/controller/register_controller.dart';
import 'package:flut_jestor_app/shared/components/custom_text_form_field_widget.dart';
import 'package:flut_jestor_app/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController controller = RegisterController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      style: TextStyle(height: 1.6, fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat Alternates'),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 460,
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
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: controller.passwordController,
                                obscureText: controller.showPassword == false ? true : false,
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
                                        color: blueLight,
                                      ),
                                      onTap: () => setState(() {
                                            controller.showPassword = !controller.showPassword;
                                          })),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Campo obrigatório!';
                                  }

                                  if (value.length < 8) {
                                    return "A senha deve ter no mínimo 8 caracteres";
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(height: 36),
                              TextFormField(
                                controller: controller.confirmPasswordController,
                                obscureText: controller.showConfirmPassword == false ? true : false,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(0),
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Confirmação de senha',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(128, 0, 0, 0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  suffixIcon: GestureDetector(
                                      child: Icon(
                                        controller.showConfirmPassword == false ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                        color: blueLight,
                                      ),
                                      onTap: () => setState(() {
                                            controller.showConfirmPassword = !controller.showConfirmPassword;
                                          })),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Campo obrigatório!';
                                  }

                                  if (value.length < 8) {
                                    return "A senha deve ter no mínimo 8 caracteres";
                                  }

                                  if (value != controller.passwordController.text) {
                                    return "Ops! Parece que as senhas digitadas não correspondem";
                                  }

                                  return null;
                                },
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (controller.formKey.currentState!.validate()) {}
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: green,
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: const Text(
                                  'Cadastrar',
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
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Voltar',
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
