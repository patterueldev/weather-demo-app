part of '../weather_feature.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeather(GetWeatherParameters parameters);
}

abstract class GetWeatherUseCase {
  TaskEither<WeatherException, WeatherModel> call(
      GetWeatherParameters parameters);
}

class DefaultGetWeatherUseCase implements GetWeatherUseCase {
  final WeatherRepository weatherRepository;

  DefaultGetWeatherUseCase({
    required this.weatherRepository,
  });

  @override
  TaskEither<WeatherException, WeatherModel> call(
          GetWeatherParameters parameters) =>
      TaskEither.tryCatch(() async {
        final weather = await weatherRepository.getWeather(parameters);
        return weather;
      }, (error, stackTrace) {
        return WeatherException('Failed to get weather');
      });
}
