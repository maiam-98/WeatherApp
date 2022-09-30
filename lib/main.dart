
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_apps/login_screen.dart';
import 'package:my_apps/modules/weather_screen/cubit/cubit.dart';
import 'package:my_apps/modules/weather_screen/cubit/states.dart';
import 'package:my_apps/sheard/bloc_observer.dart';
import 'package:my_apps/sheard/network/remote/dio_helper_air.dart';
import 'package:my_apps/sheard/network/remote/dio_helper.dart';
import 'MenuPages/layout_weather.dart';
import 'modules/air_quality/cubit.dart';
import 'modules/weather_screen/weather_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  DioHelperAir.initAir();
  Paint.enableDithering = true;
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => WeatherCubit()..getTemperatureItem(),),
            BlocProvider(create: (BuildContext context) => AirQualityCubit()..getAirQuality(),),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor:const Color.fromRGBO(242, 230, 242, 1),
                textTheme: const TextTheme(
                  headline1: TextStyle(
                    //color: Colors.grey
                  ),
                )
            ),
            home: const LayoutScreen(),
          ),
        );

}



