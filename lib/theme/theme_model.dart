

import 'package:app_climamelhorado/theme/enums.dart';
import 'package:app_climamelhorado/theme/theme_blue.dart';
import 'package:app_climamelhorado/theme/theme_green.dart';
import 'package:app_climamelhorado/theme/theme_purple.dart';
import 'package:app_climamelhorado/theme/theme_red.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeModel extends ChangeNotifier {  // o ChangeNotifier vai notificar se o tema for alterado ou nao 
  ThemeData _currentTheme = themePurple; // tema padrão se nao for alterado/ mexido

  ThemeData get currentTheme => _currentTheme; //get criando o tema

  ThemeModel() {  //construtor sem argumento, primeira coisa que se faz // atualiza o tema
    updateTheme();
  }

// ta chamando o tema
  updateTheme() {
    _currentTheme = getThemeCustom(); // atribuindo tema para a propriedade _currentTheme para o get que está embaixo
    notifyListeners(); //notificar/ envio, independente do que é . não é um problema se ninguem receber. GERENCIAR ESTADO NATIVO NO FLUTTER
  }

  ThemeData getThemeCustom() {
    final box = GetStorage(); // está instanciando e jogando
    final themeColor = strToEnumTema(box.read('tema') ?? 'Purple'); // está fazendo uma conversão se está algo gravado quando abrir o tela, senao volta para o laranja. evitando quebrar o tema

    final result = switch (themeColor) { // devolvendo o arquivo de tema
      ColorTema.blue => themeBlue,
      ColorTema.green => themeGreen,
      ColorTema.red => themeRed,
      _ => themePurple, // pega o arquivo inteiro
    };                   // e
    return result; // retorna
  }

  ColorTema strToEnumTema(String? value) { // para converter uma string para enumerado (strToEnumTema criou)
    final result = switch (value) {
      'Blue' => ColorTema.blue,
      'Green' => ColorTema.green,
      'Red' => ColorTema.red,
      'Purple' => ColorTema.purple,
      _ => ColorTema.purple,
    };
    return result;
  }
}
