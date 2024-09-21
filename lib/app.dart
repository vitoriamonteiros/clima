import 'package:app_climamelhorado/page/home_page.dart';
import 'package:app_climamelhorado/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: GetIt.instance<ThemeModel>(), 
      builder: (context, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: GetIt.instance<ThemeModel>().currentTheme,
          home: const MyHomePage(title: ''),
        );
      },
    );
  }
}