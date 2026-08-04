// Modelo principal con la información climática que se muestra en Home.
import 'city.dart';
import '../models/hourlyForecast.dart';
import '../models/dailyForecast.dart';

class Weather {
  final double temperature;
  final double maxTemp;
  final double minTemp;
  final String description;
  final String iconCode;
  final int humidity;
  final double windSpeed;
  final double feelsLike; //Sensacion termica
  final City city;
  final List<Hourlyforecast> hourlyForecasts;
  final List<Dailyforecast> dailyForecasts;

  Weather({
    required this.city,
    required this.hourlyForecasts,
    required this.dailyForecasts,
    required this.temperature,
    required this.maxTemp,
    required this.minTemp,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
    required Hourlyforecast hourlyForecast,
    required Dailyforecast dailyForecast,
  });
}
