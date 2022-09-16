abstract class WeatherStates{}

class WeatherInitialStates extends WeatherStates{}

class TemperatureWeatherLoadingStates extends WeatherStates{}

class TemperatureSuccessStates extends WeatherStates{}

class TemperatureErrorStates extends WeatherStates{
  final String error;

  TemperatureErrorStates(this.error);
}

class ChiangTemperatureSuccessStates extends WeatherStates{}

class SelectColorSuccessStates extends WeatherStates{}

class ToggleBarSuccessesStates extends WeatherStates{}


