class DailyModel
{
  double? latitude;
  double? longitude;
  double? generationtime_ms;
  int? utc_offset_seconds;
  String? timezone;
  String? timezone_abbreviation;
  double? elevation;
  DailyUnits? daily_units;
  Daily? daily;

  DailyModel.fromJson(Map<String, dynamic> json)
  {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtime_ms = json['generationtime_ms'];
    utc_offset_seconds = json['utc_offset_seconds'];
    timezone_abbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    daily_units = json['daily_units'] != null ? DailyUnits.fromJson(json['daily_units']) : null;
    daily = json['daily'] != null ? Daily.fromJson(json['daily']) : null;

  }
}

class DailyUnits
{
  dynamic time;
  dynamic temperature_2m_max;
  dynamic precipitation_sum;
  dynamic rain_sum;
  dynamic showers_sum;
  dynamic snowfall_sum;
  dynamic precipitation_hours;
  dynamic windspeed_10m_max;

  DailyUnits.fromJson(Map<String, dynamic>json)
  {
    time = json['time'];
    temperature_2m_max = json['temperature_2m_max'];
    precipitation_sum = json['precipitation_sum'];
    rain_sum = json['rain_sum'];
    showers_sum = json['showers_sum'];
    snowfall_sum = json['snowfall_sum'];
    precipitation_hours = json['precipitation_hours'];
    windspeed_10m_max = json['windspeed_10m_max'];
  }
}

class Daily
{
   List<dynamic>? time = [];
   List<dynamic>? temperature_2m_max = [];
   List<dynamic>? precipitation_sum = [];
   List<dynamic>? rain_sum = [];
   List<dynamic>? showers_sum = [];
   List<dynamic>? snowfall_sum = [];
   List<dynamic>? precipitation_hours = [];
   List<dynamic>? windspeed_10m_max = [];

  Daily.fromJson(Map<String, dynamic> json)
  {
     json['time'].forEach((element)
    {
      time?.add(element);
    });

     json['temperature_2m_max'].forEach((element)
    {
      temperature_2m_max?.add(element);
    });

     json['precipitation_sum'].forEach((element)
     {
       precipitation_sum?.add(element);
     });
     json['rain_sum'].forEach((element)
     {
       rain_sum?.add(element);
     });
     json['showers_sum'].forEach((element)
     {
       showers_sum?.add(element);
     });
     json['snowfall_sum'].forEach((element)
     {
       snowfall_sum?.add(element);
     });
     json['precipitation_hours'].forEach((element)
     {
       precipitation_hours?.add(element);
     });
     json['windspeed_10m_max'].forEach((element)
     {
       windspeed_10m_max?.add(element);
     });

  }

}


