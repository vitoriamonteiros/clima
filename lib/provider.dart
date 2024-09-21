import 'package:dio/dio.dart';

class WeatherProvider {
  Dio dio = Dio();

  initDio() {
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  final endPointWeather = //Endpoint para puxar a Cidade
      'https://api.hgbrasil.com/weather/?format=json-cors&key=development&woeid={code}';

  final endPointCodeCity = //Endpoint para o Woied
      'https://api.hgbrasil.com/stats/find_woeid?key=17284dd0&format=json-cors&sdk_version=console&city_name={cidade}';

  Future<int?> getRequestCodeCity(String city) async {
    try {
      initDio();
      var url = endPointCodeCity.replaceAll('{cidade}', city);
      final response = await dio.get(url);

      return response.data['woeid'];
      //print(response.data['woeid']); //só para testar as APIs, retornando o codigo da cidade
    } on DioException catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> getRequestWeather(int codeCity) async{
    try {
      initDio();
       var url = endPointWeather.replaceAll('{code}', codeCity.toString());
       final response = dio.get(url);

      print(response);
      return response;

    } on DioException catch (e) {
      print(e);
    }
    return null;
  }
}