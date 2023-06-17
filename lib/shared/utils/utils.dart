import 'package:flutter/material.dart';

const String basePath = "http://10.0.2.2:8080";

// Colors
const Color blue = Color.fromARGB(255, 23, 93, 145);
const Color blueLight = Color.fromARGB(128, 23, 92, 145);
const Color green = Color.fromARGB(255, 107, 200, 61);
const Color red = Color.fromARGB(255, 209, 2, 2);

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
}
