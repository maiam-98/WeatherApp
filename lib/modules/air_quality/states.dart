abstract class AirQualityStates{}

class AirQualityInitStates extends AirQualityStates{}

class AirQualityLoadingStates extends AirQualityStates{}

class AirQualitySuccessStates extends AirQualityStates{}

class AirQualityErrorStates extends AirQualityStates{
  final String error;

  AirQualityErrorStates(this.error);
}

class ToggleBarSuccessesStates extends AirQualityStates{}

class IndexForHoursLoadingStates extends AirQualityStates{}

class IndexForHoursSuccessStates extends AirQualityStates{}
