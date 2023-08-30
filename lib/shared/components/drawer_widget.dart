// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flut_jestor_app/pages/controller/home_controller.dart';
import 'package:flut_jestor_app/services/user_service.dart';
import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  final HomeController controller;
  final String email;

  const DrawerWidget({
    Key? key,
    required this.controller,
    required this.email,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

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
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: blue,
                  size: 24,
                ),
                title: Text(
                  widget.email,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
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
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        title: const Text(
                          'Alterar Senha',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: blue),
                        ),
                        content: SizedBox(
                          width: 280,
                          height: 180,
                          child: Form(
                            key: widget.controller.formKeyPassword,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                TextFormField(
                                  controller: widget.controller.newPasswordController,
                                  obscureText: widget.controller.showPassword == false ? true : false,
                                  enableInteractiveSelection: false,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(0),
                                    border: const UnderlineInputBorder(),
                                    labelText: 'Nova senha',
                                    labelStyle: const TextStyle(
                                      color: Color.fromARGB(128, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    suffixIcon: GestureDetector(
                                        child: Icon(
                                          widget.controller.showPassword == false ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                          color: blueAccent,
                                        ),
                                        onTap: () => setState(() {
                                              widget.controller.showPassword = !widget.controller.showPassword;
                                            })),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor, digite uma senha';
                                    }

                                    if (value.length < 8) {
                                      return "A senha deve ter no mínimo 8 caracteres";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(height: 36),
                                TextFormField(
                                  controller: widget.controller.confirmNewPasswordController,
                                  obscureText: widget.controller.showConfirmPassword == false ? true : false,
                                  enableInteractiveSelection: false,
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
                                          widget.controller.showConfirmPassword == false ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                          color: blueAccent,
                                        ),
                                        onTap: () => setState(() {
                                              widget.controller.showConfirmPassword = !widget.controller.showConfirmPassword;
                                            })),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor, confirme a senha';
                                    }

                                    if (value.length < 8) {
                                      return "A senha deve ter no mínimo 8 caracteres";
                                    }

                                    if (value != widget.controller.newPasswordController.text) {
                                      return "Ops! As senhas digitadas não correspondem";
                                    }

                                    return null;
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              widget.controller.newPasswordController.clear();
                              widget.controller.confirmNewPasswordController.clear();
                              Navigator.pop(context, 'Cancelar');
                            },
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: red),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (widget.controller.formKeyPassword.currentState!.validate()) {
                                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                widget.controller
                                    .updatePassword(service, sharedPreferences.getString('email') ?? '', widget.controller.newPasswordController.text)
                                    .then((value) {
                                  if (value == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(Utils().snackBarSuccess("A senha foi atualizada com sucesso!"));
                                  }
                                  Navigator.of(context).pop();
                                }).onError((error, stackTrace) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(Utils().snackBarError("Algo deu errado! Tente novamente."));
                                });
                                widget.controller.newPasswordController.clear();
                                widget.controller.confirmNewPasswordController.clear();
                              }
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: greenLight),
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: blue,
                ),
                title: const Text(
                  'Excluir usuário',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      title: const Text(
                        'Excluir usuário',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: blue),
                      ),
                      content: const Text(
                        'Você tem certeza de que deseja excluir seu usuário?',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Montserrat', color: blue),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Não'),
                          child: const Text(
                            'Não',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: red),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            widget.controller.delete(service, sharedPreferences.getString('email') ?? '').then((value) {
                              Navigator.pushReplacementNamed(context, '/login');
                            }).onError((error, stackTrace) {
                              ScaffoldMessenger.of(context).showSnackBar(Utils().snackBarError("Ops, ocorreu um erro inesperado"));
                            });
                          },
                          child: const Text(
                            'Sim',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: greenLight),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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

                  widget.controller.logout(service, sharedPreferences.getString('access_token')).then((value) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }).onError((error, stackTrace) {
                    Navigator.pushReplacementNamed(context, '/login');
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
