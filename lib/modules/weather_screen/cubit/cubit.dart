
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:my_apps/models/weather_daily_model.dart';
import 'package:my_apps/models/air_quality_model.dart';
import 'package:my_apps/modules/weather_screen/cubit/states.dart';
import 'package:my_apps/sheard/network/remote/dio_helper_air.dart';

import '../../../sheard/network/remote/dio_helper.dart';

class WeatherCubit extends Cubit<WeatherStates>
{
  WeatherCubit():super(WeatherInitialStates());

  static WeatherCubit get(context) => BlocProvider.of(context);


  Future<Position> getCoordinates() async
  {
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  DailyModel? model;
  void getTemperatureItem() async
  {
    emit(TemperatureWeatherLoadingStates());
    Position cl = await getCoordinates();
    DioHelper.getData(
        url: 'v1/forecast',
        query:
        {
          "latitude" : cl.latitude,
          "longitude" : cl.longitude,
          "daily" : [
            "temperature_2m_max",
            "precipitation_sum",
            "rain_sum",
            "showers_sum",
            "snowfall_sum",
            "precipitation_hours",
            "windspeed_10m_max"
          ],
          "timezone" :"auto"
        }
    ).then((value){

      model = DailyModel.fromJson(value.data);
      print(cl.latitude);
      print(cl.longitude);
      emit(TemperatureSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(TemperatureErrorStates(error.toString()));
    });
  }

  dynamic index = 0;
  void chiangTemp()
  {

    dynamic time = model?.daily?.time?.length;
    dynamic temp = model?.daily?.temperature_2m_max?.length;
    if(index < time-1 && index < temp-1) {
      index++;
    }else{
      index = (time&temp) - index;
    }
    emit(ChiangTemperatureSuccessStates());
  }


  List<String>? days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];

  List<String>? month = ['Sep','Oct','Nov','Des','Jan', 'Fab', 'Mar', 'Apr','May','Jun','Jal', 'Aug'] ;

  List<String>? airQuality = ['Real Feel','Wind','SO2','Chance of Rain','UV Index','O3'];


  Future getPosition(context) async
  {
    bool services;
    LocationPermission permission;
     services = await Geolocator.isLocationServiceEnabled();
     //print(services);
     if(services == false)
       {
         AwesomeDialog(
           context: context,
           title: 'services',
           body: const Text('GPS not Enabled'),
         ).show();
       }

     permission = await Geolocator.checkPermission();
     print(permission);

     if(permission == LocationPermission.denied)
       {
         permission = await Geolocator.requestPermission();
         if(permission == LocationPermission.always)
           {
             getCoordinates();
           }
       }
  }

  dynamic place;
  Future<String> gioCoding() async
  {
   emit(GetCoordinatesLoadingStates());
    Position cl = await getCoordinates();
    List<Placemark> placemarks = await placemarkFromCoordinates(cl.latitude, cl.longitude);
    place = placemarks[0].country;
    print(cl.latitude);
    print(cl.longitude);
   emit(GetCoordinatesSuccessStates());
    return place;
    emit(GetCoordinatesSuccessStates());
  }



}
