import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;

  const PrimaryButtonWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
      ),
    );
  }
}
