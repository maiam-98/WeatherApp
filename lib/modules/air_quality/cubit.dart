import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_apps/modules/air_quality/states.dart';
import 'package:my_apps/modules/weather_screen/cubit/cubit.dart';

import '../../models/air_quality_model.dart';
import '../../sheard/network/remote/dio_helper.dart';
import '../../sheard/network/remote/dio_helper_air.dart';

class AirQualityCubit extends Cubit<AirQualityStates> {
  AirQualityCubit() : super (AirQualityInitStates());

  static AirQualityCubit get(context) => BlocProvider.of(context);

  AirQualityModel? airQualityModel;
  void getAirQuality() async{
    DioHelper.getData(
        url: 'http://air-quality-api.open-meteo.com/v1/air-quality',
        query: {
          'latitude': 15.4218531,
          'longitude': 44.209739,
          'hourly': ['pm10', 'pm2_5', 'ozone', 'uv_index'],
          'timezone': 'auto',
        }
    ).then((value) {
      airQualityModel = AirQualityModel.fromJson(value.data);
      print('the airQuality');
      print(airQualityModel?.hourly?.pm2_5?[1]);
      emit(AirQualitySuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AirQualityErrorStates(error));
    });
  }

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

  int indexes = 0;
  int? pm2;
  int? resultAQI ;
  int? formulaAQI(pm2)
  {
      dynamic pm = airQualityModel?.hourly?.pm2_5?.length.toInt();
    for(indexes = 0 ; indexes < pm ;)
      {
        indexes ++;
        //pm2 = airQualityModel?.hourly?.pm2_5?[index];
        if(pm2 < 15.5) {
          return resultAQI = ((50/15.5)*pm2).toInt();
        }else if(pm2 < 40.5){
         return resultAQI = ((((pm2-15.5)*49)/24.9)+51).toInt();
        }else if(pm2 < 65.5){
         return resultAQI = ((((pm2-40.5)*49)/24.9)+101).toInt();
        }else if(pm2 < 150.5){
         return resultAQI = ((((pm2-65.5)*49)/84.9)+151).toInt();
        }else if(pm2 < 250.5){
         return resultAQI = ((((pm2-150.4)*99)/99.9)+201).toInt();
        }else if(pm2 < 350.5){
         return resultAQI = ((((pm2-250.5)*99)/99.9)+301).toInt();
        }

      }
    return resultAQI;

  }

  Color? color;
  String? text;
  dynamic getColors(resultAqi)
  {
   // print(resultAQI);
    if( resultAqi <= 50) {
       color = Colors.green;
       text ='Air quality is satisfactory, '
           'and air pollution poses little or no risk.';
      return color;
    }else if ( resultAqi <= 100){
      color = const Color.fromRGBO(242, 211, 136,1);
      text = 'Air quality is acceptable. However, there may be a risk for some people, '
          'particularly those who are unusually sensitive to air pollution';
      return color;
    }else if ( resultAqi <= 150){
      color = Colors.brown;
      text = 'Members of sensitive groups may experience health effects.'
          ' The general public is less likely to be affected.';
      return color;
    }else if ( resultAqi <= 200){
      color = Colors.red;
      text = '	Some members of the general public may experience health effects;'
          ' members of sensitive groups may experience more serious health effects.';
      return color;
    }else if ( resultAqi <= 300){
      color = Colors.purpleAccent;
      text = 'Health alert: The risk of health effects is'
          ' increased for everyone.';
      return color;
    }else{
      color = Colors.purple;
      text = '	Health warning of emergency conditions:'
          ' everyone is more likely to be affected.';
      return color;
    }
  }

}
