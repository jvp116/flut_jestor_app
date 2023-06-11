import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String typeField;
  final TextEditingController textController;

  const CustomTextFormFieldWidget({
    Key? key,
    required this.typeField,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Email
    if (typeField == "email") {
      return TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: UnderlineInputBorder(),
          labelText: 'E-mail',
          labelStyle: TextStyle(
            color: Color.fromARGB(128, 0, 0, 0),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        controller: textController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor, digite seu e-mail';
          }

          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
            return 'Por favor, digite um e-mail válido';
          }

          return null;
        },
        enableSuggestions: true,
        maxLength: 100,
      );
    }

    // password
    if (typeField == "password") {
      return TextFormField(
        controller: textController,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: UnderlineInputBorder(),
          labelText: 'Senha',
          labelStyle: TextStyle(
            color: Color.fromARGB(128, 0, 0, 0),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor, digite sua senha';
          }

          if (value.length < 8) {
            return "A senha deve ter no mínimo 8 caracteres";
          }

          return null;
        },
      );
    }

    return const Text("");
  }
}
