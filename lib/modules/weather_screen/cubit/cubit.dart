
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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




  DailyModel? model;
  void getTemperatureItem()
  {
   // emit(TemperatureWeatherLoadingStates());
    DioHelper.getData(
        url: 'v1/forecast',
        query:
        {
          "latitude" : 52.52,
          "longitude" : 13.41,
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
      //print(model?.daily?.time?.length);
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

  List<bool> isSelected = [true, false];
  bool showFirst = true ;
  void chiangMonthDay(int indexToggle)
  {
    for(int indexes = 0; indexes < isSelected.length ; indexes ++) {
      if(indexes == indexToggle)
      {
        isSelected[indexes] = true;


      }else{
        isSelected[indexes] = false;
      }
      if(indexToggle == 0)
      {
        showFirst = true;
      }else{
        showFirst = false;
      }
    }
    emit(ToggleBarSuccessesStates());

  }

}
