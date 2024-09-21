import 'package:app_climamelhorado/core/constants.dart';
import 'package:app_climamelhorado/core/locator.dart';
import 'package:app_climamelhorado/provider.dart';
import 'package:app_climamelhorado/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class WeatherController extends ChangeNotifier{
  String description = '';
  int temp = 0;
  bool isLoading = false; // variavel do carregamento

  final box = GetStorage();
  
  final WeatherProvider provider;

  WeatherController({required this.provider});

  void themeModify(){
    if(temp <=  Constants.limiteTemperaturaBaixa){
      box.write('tema', 'Blue');
    }else if(temp <= Constants.limiteTemperaturaAlta){
      box.write('tema', 'Green');
    }else{
      box.write('tema', 'Red');
    }
    locator.get<ThemeModel>().updateTheme();
  }

  Future getWeatherApi(String cityName) async {
    try {
      //limpando antes das outras consultas
      description = ''; //limpando/deixando vazio
      temp = 0;

      isLoading = true;
      notifyListeners();

      var codeCity = await provider.getRequestCodeCity(cityName);

        if (codeCity ==null) {
          isLoading = false;
          notifyListeners();
          return;
        }

      var json = await provider.getRequestWeather(codeCity);

      description = json?.data['results']['description'];
      temp = json?.data ['results']['temp'];
      themeModify();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print(e);
    }
  }
}