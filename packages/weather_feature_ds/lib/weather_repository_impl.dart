part of 'weather_feature_ds.dart';

class OWMWeatherRepositoryImpl implements WeatherRepository {
  final WeatherFactory weatherFactory;

  OWMWeatherRepositoryImpl({
    required this.weatherFactory,
  });

  @override
  Future<WeatherModel> getWeather(GetWeatherParameters parameters) async {
    try {
      Weather weather =
          await weatherFactory.currentWeatherByCityName(parameters.city);

      final areaName = weather.areaName;
      final weatherDescription = weather.weatherDescription;

      // factors to check for weather condition
      final cloudiness = weather.cloudiness;
      final rain = weather.rainLastHour;
      final snow = weather.snowLastHour;
      final wind = weather.windSpeed;
      final humidity = weather.humidity;
      final pressure = weather.pressure;
      final temperature = weather.temperature?.celsius;
      if (areaName == null ||
          weatherDescription == null ||
          cloudiness == null ||
          wind == null ||
          humidity == null ||
          pressure == null ||
          temperature == null) {
        // Debug prints to check for null values
        debugPrint('areaName: $areaName');
        debugPrint('weatherDescription: $weatherDescription');
        debugPrint('cloudiness: $cloudiness');
        debugPrint('rain: $rain');
        debugPrint('snow: $snow');
        debugPrint('wind: $wind');
        debugPrint('humidity: $humidity');
        debugPrint('pressure: $pressure');
        debugPrint('temperature: $temperature');

        throw WeatherException('Weather data is incomplete');
      }

      WeatherCondition condition;
      if (snow != null && snow > 0) {
        condition = WeatherCondition.snowy;
      } else if (rain != null && rain > 0) {
        condition = WeatherCondition.rainy;
      } else if (cloudiness > 50) {
        condition = WeatherCondition.cloudy;
      } else {
        condition = WeatherCondition.sunny;
      }

      return DefaultWeatherModel(
        cityName: areaName,
        condition: condition,
        temperature: temperature,
        weatherDescription: weatherDescription,
      );
    } on OpenWeatherAPIException catch (e) {
      debugPrint("Error while attempting to fetch weather data: $e");
      throw WeatherException(e.toString());
    } catch (e) {
      throw WeatherException(e.toString());
    }
  }
}
