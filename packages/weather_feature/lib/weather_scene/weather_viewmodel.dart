part of '../weather_feature.dart';

class WeatherException implements Exception {
  final String message;

  WeatherException(this.message);

  @override
  String toString() => message;
}

abstract class WeatherScreenViewModel extends ChangeNotifier {
  ValueNotifier<WeatherState> get state;
  String get cityText;
  Future<void> loadWeather();
  void updateCity(String city);
}

class DefaultWeatherViewModel extends WeatherScreenViewModel {
  final GetWeatherUseCase getWeatherUseCase;

  DefaultWeatherViewModel({
    required this.getWeatherUseCase,
  });

  @override
  ValueNotifier<WeatherState> state =
      ValueNotifier<WeatherState>(WeatherState());

  @override
  String cityText = 'New York';

  Timer? _loadTimer;

  @override
  Future<void> loadWeather() async {
    state.value = WeatherLoading();
    final weatherOrFailure = await getWeatherUseCase(
      GetWeatherParameters(city: cityText),
    ).run();
    weatherOrFailure.fold(
      (failure) {
        state.value = WeatherError(failure.message);
      },
      (weather) {
        state.value = WeatherLoaded(weather);
      },
    );
  }

  @override
  void updateCity(String city) {
    this.cityText = city;
    _resetTimer();
  }

  void _resetTimer() {
    _loadTimer?.cancel();
    _loadTimer = Timer(const Duration(milliseconds: 250), () {
      loadWeather();
    });
  }
}
