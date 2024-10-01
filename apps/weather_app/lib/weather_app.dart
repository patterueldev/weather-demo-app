part of 'main.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key, required this.coordinator});

  final Coordinator coordinator;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LandingScreen(coordinator: coordinator),
    );
  }
}
