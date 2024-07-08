import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  iconTheme: IconThemeData(color: Colors.white),
brightness: Brightness.light,
colorScheme: const ColorScheme.light(
  background: Colors.white,
  primary: Colors.white,
  secondary: Colors.black,
)
);

ThemeData darkMode = ThemeData(
brightness: Brightness.dark,
colorScheme: const ColorScheme.dark(
  background: Colors.black,
  primary: Colors.black,
  secondary: Colors.white,
)
);