import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_feature/weather_feature.dart';
import 'package:weather_feature_ds/weather_feature_ds.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      WeatherFeatureDsProvider.providers,
      WeatherProvider.providers,
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WeatherProvider.buildWeatherScreen(),
    );
  }
}
