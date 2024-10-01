import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_feature/weather_feature.dart';
import 'package:weather_feature_ds/weather_feature_ds.dart';

part 'weather_app.dart';
part 'landing_screen.dart';

void main() async {
  final WeatherProvider weatherProvider = WeatherProvider();
  final WeatherFeatureDsProvider weatherFeatureDsProvider =
      WeatherFeatureDsProvider();
  final coordinator = Coordinator(
    weatherProvider: weatherProvider,
    weatherFeatureDsProvider: weatherFeatureDsProvider,
    weatherFeatureDSConfiguration: WeatherFeatureDSConfiguration(
      openWeatherApiKey: 'c235214bd296a30efc2d58793478c629',
    ),
  );
  coordinator.start();
}
