import 'package:app_climamelhorado/controller.dart';
import 'package:app_climamelhorado/core/constants.dart';
import 'package:app_climamelhorado/provider.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherProvider provider = WeatherProvider();
  late final WeatherController
      ctlWeatherController; //aqui nao preencher ela agora, instanciar no futuro
  final _formState = GlobalKey<FormState>();
  final TextEditingController _input = TextEditingController();

  @override
  void initState() {
    super.initState();
    ctlWeatherController = WeatherController(provider: provider);
  }

  //dispose - para ter certeza se tivesse outras paginas, nao vai ficar sobrando na memória,
  //destroi a classe ctlWeatherControllerao final do app
  @override
  void dispose() {
    super.dispose();
    ctlWeatherController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildForm(),
                const SizedBox(height: 20),
                buildButton(),
                const SizedBox(height: 20),
                buildAnimatedText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formState,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _input,
          keyboardType: TextInputType.text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            labelText: 'Consultar Cidade',
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(color: Colors.red),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe a Cidade!';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        if (_formState.currentState!.validate()) {
          await ctlWeatherController.getWeatherApi(_input.text);
        }
      },
      label: const Text('Consultar Temperatura'),
      icon: const Icon(Icons.refresh),
    );
  }

  Widget buildAnimatedText() {
    return AnimatedBuilder(
      animation: ctlWeatherController,
      builder: (_, child) {
        return ctlWeatherController.isLoading 
          ? const CircularProgressIndicator(
              color: Colors.white,
            ) 
          : ctlWeatherController.description.isEmpty  //nao exibir a temperatuda na inicalização
            ? Container()
            : Column(
                children: [
              const Text(
                'Frio: abaixo de ${Constants.limiteTemperaturaBaixa} °C',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Agradavel: ${Constants.limiteTemperaturaBaixa}°C até ${Constants.limiteTemperaturaAlta}°C',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Quente: acima de ${Constants.limiteTemperaturaAlta}°C',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Temperatura: ${ctlWeatherController.temp.toString()} °C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                ctlWeatherController.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
            );
      },
    );
  }
}
