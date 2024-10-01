part of 'weather_feature_ds.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  // final WeatherDataSource weatherDataSource;
  //
  // WeatherRepositoryImpl({
  //   required this.weatherDataSource,
  // });

  @override
  Future<WeatherModel> getWeather(GetWeatherParameters parameters) async {
    await Future.delayed(Duration(seconds: 1));
    return DefaultWeatherModel(
      cityName: 'London',
      condition: WeatherCondition.sunny,
      temperature: 20.0,
      weatherDescription: 'Clear sky',
    );
    // final weather = await weatherDataSource.getWeather(parameters);
    // return weather;
  }
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
