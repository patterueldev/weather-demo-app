part of '../weather_feature.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<WeatherScreenViewModel>();
      viewModel.loadWeather();
      viewModel.state.addListener(_listener);
    });
  }

  _listener() {
    final viewModel = context.read<WeatherScreenViewModel>();
    final state = viewModel.state.value;
    if (state is WeatherError) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(state.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Consumer<WeatherScreenViewModel>(
        builder: (context, viewModel, child) => Stack(
          children: [
            _buildBody(context, viewModel),

            // loading indicator
            ValueListenableBuilder(
                valueListenable: viewModel.state,
                builder: (context, state, child) {
                  if (state is WeatherLoading) {
                    return Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
          ],
        ),
      );

  Widget _buildBody(BuildContext context, WeatherScreenViewModel viewModel) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: viewModel.loadWeather,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchBar(
                  hintText: 'Search city',
                  controller: TextEditingController(),
                  onChanged: (text) => viewModel.updateCity(text),
                ),
                ValueListenableBuilder(
                  valueListenable: viewModel.state,
                  builder: (context, state, child) {
                    if (state is WeatherLoaded) {
                      return _buildWeatherBody(state.weather);
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildWeatherBody(WeatherModel weather) {
    return Column(
      children: [
        Text(weather.cityName),
        Text(weather.temperature.toString()),
        Text(weather.weatherDescription),
      ],
    );
  }

  // Show the temperature, weather condition (e.g., sunny, rainy), and an appropriate weather icon.
}
