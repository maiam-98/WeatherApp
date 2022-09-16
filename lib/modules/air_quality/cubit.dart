import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_apps/modules/air_quality/states.dart';

import '../../models/air_quality_model.dart';
import '../../sheard/network/remote/dio_helper_air.dart';

class AirQualityCubit extends Cubit<AirQualityStates> {
  AirQualityCubit() : super (AirQualityInitStates());

  static AirQualityCubit get(context) => BlocProvider.of(context);

  AirQualityModel? airQualityModel;

  void getAirQuality() {
    //emit(AirQualityLoadingStates());
    DioHelperAir.getDataAir(
        url: 'v1/air-quality',
        query: {
          'latitude': 52.5235,
          'longitude': 13.4115,
          'hourly': ['pm10', 'pm2_5', 'ozone', 'uv_index'],
          'timezone': 'auto',
        }
    ).then((value) {
      airQualityModel = AirQualityModel.fromJson(value.data);
      print('the airQuality');
      print(airQualityModel?.hourly?.uv_index?.length);
      emit(AirQualitySuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(AirQualityErrorStates(error));
    });
  }


}
