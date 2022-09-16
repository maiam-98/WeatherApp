abstract class AirQualityStates{}

class AirQualityInitStates extends AirQualityStates{}

class AirQualityLoadingStates extends AirQualityStates{}

class AirQualitySuccessStates extends AirQualityStates{}

class AirQualityErrorStates extends AirQualityStates{
  final String error;

  AirQualityErrorStates(this.error);
}