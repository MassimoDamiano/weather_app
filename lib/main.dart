
import 'package:flutter/material.dart';
import 'package:weather_app/features/screens/home.dart';
import 'package:weather_app/features/weather/providers/weather_provider.dart';
import 'package:weather_app/features/weather/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/services/location_service.dart';
import 'package:weather_app/features/weather/services/weather_service.dart';
import 'package:provider/provider.dart';


//ChangeNotifierProvider hace disponible weatherProvider


void main() {
  runApp(ChangeNotifierProvider.value( value: weatherProvider  , child: const MyApp()) );
}

final weatherService = WeatherService();

final weatherRepository = WeatherRepository(weatherService: weatherService);

final weatherProvider = WeatherProvider(repository: weatherRepository, locationService: LocationService());

final locationService = LocationService();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    return  MaterialApp( home: const Home());
  }
}
