
import 'package:dio/dio.dart';

class DioHelperAir
{
  static Dio? dio;

 static initAir()
  {
    dio = Dio(
    BaseOptions(
        baseUrl : 'air-quality-api.open-meteo.com/',
        receiveDataWhenStatusError: true
      ),
    );
  }

  static Future<Response> getDataAir({

  required String url,
    required Map<String, dynamic> query,
})
  async {
    try{
      return dio!.get(url, queryParameters: query);
    }on Dio catch(e){
      print('this is error Air$e');
      rethrow;
    }
  }

}
