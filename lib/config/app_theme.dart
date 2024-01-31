import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      //colorSchemeSeed: const Color.fromARGB(255, 119, 42, 42),
      colorSchemeSeed: Colors.blueAccent,
      appBarTheme: const AppBarTheme(centerTitle: true));
}
