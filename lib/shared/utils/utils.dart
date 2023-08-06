import 'package:flutter/material.dart';

const String basePath = "http://10.0.2.2:8080";
// 10.0.2.2

// Colors
const Color blueAccent = Color.fromRGBO(23, 93, 145, 0.5);
const Color blue = Color(0xFF175D91);
const Color blueLight = Color(0xFF00A5CF);

const Color greenAccent = Color(0xFF25A539);
const Color green = Color(0xFF196E19);
const Color greenLight = Color(0xFF6BC83D);

const Color yellowAccent = Color(0xFFC46B0F);
const Color yellow = Color(0xFFCCB801);

const Color purple = Color(0xFF4E196E);
const Color purpleLight = Color(0xFF7F6BB3);

const Color red = Color(0xFFD10202);

const Color brown = Color(0xFF7E4409);

class Utils {
  SnackBar snackBarError(String text) {
    return SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      backgroundColor: red,
      behavior: SnackBarBehavior.floating,
    );
  }

  SnackBar snackBarSuccess(String text) {
    return SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      backgroundColor: green,
      behavior: SnackBarBehavior.floating,
    );
  }
}
