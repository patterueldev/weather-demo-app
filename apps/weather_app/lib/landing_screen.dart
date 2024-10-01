part of 'main.dart';

class Coordinator {
  final WeatherProvider weatherProvider;
  final WeatherFeatureDsProvider weatherFeatureDsProvider;
  final WeatherFeatureDSConfiguration weatherFeatureDSConfiguration;

  const Coordinator({
    required this.weatherFeatureDSConfiguration,
    required this.weatherFeatureDsProvider,
    required this.weatherProvider,
  });

  void start() {
    runApp(MultiProvider(
      providers: [
        Provider<WeatherFeatureDSConfiguration>(
          create: (context) => weatherFeatureDSConfiguration,
        ),
        weatherFeatureDsProvider.providers,
        weatherProvider.providers,
      ],
      child: WeatherApp(
        coordinator: this,
      ),
    ));
  }

  void navigateToWeatherScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => weatherProvider.buildWeatherScreen(),
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key, required this.coordinator});

  final Coordinator coordinator;

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  void _onGetStartedPressed() {
    // Handle the button press action here
    print('Get Started button pressed');
    widget.coordinator.navigateToWeatherScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _onGetStartedPressed,
          child: Text('Get Started'),
        ),
      ),
    );
  }
}
