import 'package:flutter/material.dart';

class MyConstant {
  //field
  static Color primary = const Color.fromARGB(255, 237, 79, 79);
  static Color dark = const Color.fromARGB(255, 53, 48, 48);
  static Color light = const Color.fromARGB(255, 239, 229, 229);
  static Color active = const Color.fromARGB(255, 109, 8, 251);

  //mothod

  BoxDecoration planBox() {
    return BoxDecoration(color: light.withOpacity(1));
  }

  TextStyle h1Style() {
    return TextStyle(
      color: dark,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }
  
  TextStyle h2Style() {
    return TextStyle(
      color: dark,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      color: dark,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      color: active,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }
}

