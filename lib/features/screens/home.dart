import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/providers/weather_provider.dart';
import 'package:weather_app/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double lat = -31.42;
  final double lon = -64.18;
  
  
  @override
  void initState() {
    super
        .initState(); //“Antes de hacer mis cosas, dejá que Flutter inicialice correctamente el State.”
    context.read<WeatherProvider>();
    weatherProvider.loadCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context
        .watch<
          WeatherProvider
        >(); //Dame el WeatherProvider que ya existe arriba.

    return const Placeholder();
  }
}
