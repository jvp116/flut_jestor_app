import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SecondaryButtonWidget extends StatelessWidget {
  final String text;
  final String typeNavigate;
  final String routeName;

  const SecondaryButtonWidget({
    Key? key,
    required this.text,
    required this.typeNavigate,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
      ),
      onPressed: () {
        if (typeNavigate == "redirect") {
          Navigator.of(context).pushNamed(routeName);
        }

        if (typeNavigate == "close") {
          Navigator.pop(context);
        }
      },
      child: Text(
        text,
        style: const TextStyle(
          color: blue,
        ),
      ),
    );
  }
}
