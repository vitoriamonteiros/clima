import 'package:flutter/material.dart';

final themePurple = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
  scaffoldBackgroundColor: Colors.purple,
  primaryColor: Colors.purple,
  primaryColorLight: Colors.purple[100],
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.purple;
      }
      return Colors.grey;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.purple[100];
      }
      return Colors.grey[200];
    }),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
);
