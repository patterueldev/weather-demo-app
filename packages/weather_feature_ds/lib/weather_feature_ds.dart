library weather_feature_ds;

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:weather_feature/weather_feature.dart';
import 'package:weather/weather.dart' as weather_api;

part 'weather_repository_impl.dart';

class WeatherFeatureDsProvider {
  static MultiProvider providers = MultiProvider(
    providers: [
      Provider<WeatherFactory>(
        create: (context) => weather_api.WeatherFactory(
          context.read<WeatherFeatureDSConfiguration>().openWeatherApiKey,
        ),
      ),
      Provider<WeatherRepository>(
        create: (context) => OWMWeatherRepositoryImpl(
          weatherFactory: context.read(),
        ),
      ),
    ],
  );
}

class WeatherFeatureDSConfiguration {
  final String openWeatherApiKey;

  WeatherFeatureDSConfiguration({
    required this.openWeatherApiKey,
  });
}
