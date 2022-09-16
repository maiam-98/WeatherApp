
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_apps/login_screen.dart';
import 'package:my_apps/sheard/bloc_observer.dart';
import 'package:my_apps/sheard/network/remote/dio_helper_air.dart';
import 'package:my_apps/sheard/network/remote/dio_helper.dart';
import 'modules/weather_screen/weather_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  DioHelperAir.initAir();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:const Color.fromRGBO(114, 116, 129,1),

      ),
      home: const WeatherScreen(),
    );

  }
}



