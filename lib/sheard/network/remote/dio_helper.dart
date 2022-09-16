
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{

  static  Dio? dio;
  static init(){
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://api.open-meteo.com/',
          receiveDataWhenStatusError: true
      ),
    );/*..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));*/

  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
})async{/*
    try{*/
      return await dio!.get(url,queryParameters:query);
    }/*on DioError catch(e)
    {
      print('this is error$e');
      rethrow;
    }*/
  }



