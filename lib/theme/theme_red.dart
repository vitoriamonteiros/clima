import 'package:flutter/material.dart';

final themeRed = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
  scaffoldBackgroundColor: Colors.red,
  primaryColor: Colors.red,
  primaryColorLight: Colors.red[100],
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.red;
      }
      return Colors.grey;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.red[100];
      }
      return Colors.grey[200];
    }),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
);
