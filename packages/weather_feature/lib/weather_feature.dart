library weather_feature;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show TaskEither;
import 'package:provider/provider.dart';

part 'weather_scene/weather.dart';
part 'weather_scene/weather_state.dart';
part 'weather_scene/weather_screen.dart';
part 'weather_scene/weather_viewmodel.dart';
part 'weather_scene/get_weather_usecase.dart';
part 'weather_scene/get_weather_parameters.dart';

class WeatherProvider {
  static MultiProvider providers = MultiProvider(
    providers: [
      Provider<GetWeatherUseCase>(
        create: (context) => DefaultGetWeatherUseCase(
          weatherRepository: context.read(),
        ),
      ),
    ],
  );

  static Widget buildWeatherScreen() {
    return ChangeNotifierProvider<WeatherScreenViewModel>(
      create: (context) => DefaultWeatherViewModel(
        getWeatherUseCase: context.read(),
      ),
      child: const WeatherScreen(),
    );
  }
}
