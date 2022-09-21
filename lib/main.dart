
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
import 'layout/layout_weather.dart';
import 'modules/air_quality/cubit.dart';
import 'modules/weather_screen/weather_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  DioHelperAir.initAir();
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => WeatherCubit()..getTemperatureItem()),
        BlocProvider(create: (context) => AirQualityCubit()..getAirQuality())
      ],
      child: BlocConsumer<WeatherCubit,WeatherStates>(
        listener: (context,index){},
        builder: (context,index){
          return MaterialApp(
             debugShowCheckedModeBanner: false,
              theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
              headline1: TextStyle(
                //color: Colors.grey
              ),
           )
          ),
              home: const LayoutScreen(),
       );
       },
      ),
    );

  }
}



