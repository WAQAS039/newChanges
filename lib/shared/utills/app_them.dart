import 'package:flutter/material.dart';
import 'package:nour_al_quran/shared/utills/palette.dart';

class AppThem {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primarySwatch: Colors.lightBlue,
    textTheme: const TextTheme(headlineLarge: TextStyle(color: Colors.black)),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primarySwatch: Palette.white,
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
        headlineLarge: TextStyle(color: Colors.white)),
  );
}
