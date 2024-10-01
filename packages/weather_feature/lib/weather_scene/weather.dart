part of '../weather_feature.dart';

abstract class WeatherModel {
  String get cityName;
  double get temperature;
  String get weatherDescription;
  WeatherCondition get condition;
}

class DefaultWeatherModel implements WeatherModel {
  @override
  String cityName;

  @override
  WeatherCondition condition;

  @override
  double temperature;

  @override
  String weatherDescription;

  DefaultWeatherModel({
    required this.cityName,
    required this.condition,
    required this.temperature,
    required this.weatherDescription,
  });
}

enum WeatherCondition {
  sunny,
  rainy,
  cloudy,
  snowy,
}
