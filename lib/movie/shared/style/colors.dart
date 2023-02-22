import 'package:flutter/material.dart';

class AppColors {
  static const Brightness brightnessDark = Brightness.dark;
  static const Brightness brightnessLight = Brightness.light;

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Colors.redAccent;
  static const Color yellow = Colors.yellow;
  static const Color transparent = Colors.transparent;
  static const MaterialColor pinkAccent = MaterialColor(0xFFFF0A6C, pinkMaterial);

  static const Color darkGray = Color(0xFF0C0C0C);
  static const Color grey = Color(0xFF606060);
  static const Color lightGray = Color(0xFFF8F8F8);

  static const Map<int, Color> pinkMaterial = <int, Color>{
    50: Color.fromRGBO(255, 10, 108, .1),
    100: Color.fromRGBO(255, 10, 108, .2),
    200: Color.fromRGBO(255, 10, 108, .3),
    300: Color.fromRGBO(255, 10, 108, .4),
    400: Color.fromRGBO(255, 10, 108, .5),
    500: Color.fromRGBO(255, 10, 108, .6),
    600: Color.fromRGBO(255, 10, 108, .7),
    700: Color.fromRGBO(255, 10, 108, .8),
    800: Color.fromRGBO(255, 10, 108, .9),
    900: Color.fromRGBO(255, 10, 108, 1),
  };
}
