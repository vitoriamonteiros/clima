import 'package:flutter/material.dart';

final themeGreen = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
  scaffoldBackgroundColor: Colors.green,
  primaryColor: Colors.green,
  primaryColorLight: Colors.green[100],
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.green;
      }
      return Colors.grey;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.green[100];
      }
      return Colors.grey[200];
    }),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
);
