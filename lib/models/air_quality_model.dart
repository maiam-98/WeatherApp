class AirQualityModel
{
  dynamic latitude;
  dynamic longitude;
  dynamic generationtime_ms;
  dynamic utc_offset_seconds;
  dynamic timezone;
  dynamic timezone_abbreviation;
 HourlyUnits? hourly_units;
 Hourly? hourly;


  AirQualityModel.fromJson(Map<String, dynamic>json)
 {
   latitude = json['latitude'];
   longitude = json['longitude'];
   generationtime_ms = json['generationtime_ms'];
   utc_offset_seconds = json['utc_offset_seconds'];
   timezone = json['timezone'];
   timezone_abbreviation = json['timezone_abbreviation'];
   hourly_units = json['hourly_units'] != null ? HourlyUnits.fromJson(json['hourly_units']) : null;
   hourly = json['hourly'] != null ? Hourly.fromJson(json['hourly']) : null;
 }
}

class HourlyUnits
{
  dynamic timeUnits;
  dynamic pm10;
  dynamic pm2_5;
  dynamic ozone;

  //named constructor
  HourlyUnits.fromJson(Map<String, dynamic>json)
  {
    timeUnits = json['time'];
    pm10 = json['pm10'];
    pm2_5 = json['pm2_5'];
    ozone = json['ozone'];
  }

}

class Hourly
{
  List<dynamic>? time;
  List<dynamic>? pm10;
  List<dynamic>? pm2_5;
  List<dynamic>? ozone;
  List<dynamic>? uv_index;


  Hourly.fromJson(Map<String, dynamic>json)
  {
    json['time'].forEach((element) {
      time?.add(element);
    });

    json['pm10'].forEach((element){
      pm2_5?.add(element);
    });

    json['pm2_5'].forEach((element){
      pm2_5?.add(element);
    });

    json['ozone'].forEacn((element){
      ozone?.add(element);
    });

    json['uv_index'].forEach((element){
      uv_index?.add(element);
    });
  }
}

