library weather_feature_ds;

import 'package:provider/provider.dart';
import 'package:weather_feature/weather_feature.dart';

part 'weather_repository_impl.dart';

class WeatherFeatureDsProvider {
  static MultiProvider providers = MultiProvider(
    providers: [
      Provider<WeatherRepository>(
        create: (context) => WeatherRepositoryImpl(),
      ),
    ],
  );
}
