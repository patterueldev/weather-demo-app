part of '../weather_feature.dart';

abstract class WeatherModel {
  String get cityName;
  double get temperature;
  String get weatherDescription;
  WeatherCondition get condition;
}

enum WeatherCondition {
  sunny,
  rainy,
  cloudy,
  snowy,
}
