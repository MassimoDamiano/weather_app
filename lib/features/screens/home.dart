// ignore_for_file: prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/app_spacing.dart';
import 'package:weather_app/features/weather/models/city.dart';
import 'package:weather_app/features/weather/models/hourlyForecast.dart';
import 'package:weather_app/features/weather/providers/weather_provider.dart';
import 'package:weather_app/features/weather/widgets/weekly_forecast_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super
        .initState(); //“Antes de hacer mis cosas, dejá que Flutter inicialice correctamente el State.”
    final provider = context.read<WeatherProvider>();
    provider.loadCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context
        .watch<
          WeatherProvider
        >(); //Dame el WeatherProvider que ya existe arriba.

    //VERIFICACION DE ESTADOS

    final weather = weatherProvider.weather;
    if (weatherProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (weatherProvider.error != null) {
      return Scaffold(body: Center(child: Text(weatherProvider.error!)));
    }
    if (weather == null) {
      return Text("error");
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 99, 164, 233), Color(0xFF1E3C72)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SafeArea(
          child: Column(
            children: [
              Spacer(),

              Center(
                child: Column(
                  children: [
                    Text(
                      weather.city.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      '${weather.temperature.round()}°',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      weather.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Spacer(),

              Container(
                height: 120,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.20),
                  ),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weather.hourlyForecasts.length,
                  itemBuilder: (context, index) {
                    final hourly = weather.hourlyForecasts[index];

                    return Padding(
                      padding: EdgeInsets.only(right: AppSpacing.md),
                      child: Column(
                        children: [
                          formatHour(context, hourly.dateTime),
                          buildWeatherIcon(hourly.iconCode),
                          Text(
                            '${hourly.temperature.round()}°',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Acá después hacés la sección por hora
              Spacer(),

              WeeklyForecastCard(forecasts: weather.dailyForecasts),
              // Acá después hacés la sección semanal
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWeatherIcon(String iconCode) {
    return Image.network(
      'https://openweathermap.org/img/wn/$iconCode@2x.png',
      width: 45,
      height: 45,
      errorBuilder: (_, __, ___) {
        return const Icon(Icons.cloud);
      },
    );
  }

  Widget formatHour(BuildContext context, DateTime dateTime) {
    var hour = dateTime.hour;
    final suffix = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
    return Text(
      '$formattedHour$suffix',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
