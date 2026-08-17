// Modelo principal con la información climática que se muestra en Home.
import 'city.dart';
import 'daily_forecast.dart';
import 'hourly_forecast.dart';

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
  final List<HourlyForecast> hourlyForecasts;
  final List<DailyForecast> dailyForecasts;

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
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      temperature: (json['temperature'] as num).toDouble(),
      maxTemp: (json['maxTemp'] as num).toDouble(),
      minTemp: (json['minTemp'] as num).toDouble(),
      description: json['description'] as String,
      iconCode: json['iconCode'] as String,
      humidity: (json['humidity'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      feelsLike: (json['feelsLike'] as num).toDouble(),
      hourlyForecasts: (json['hourlyForecasts'] as List<dynamic>)
          .map((item) => HourlyForecast.fromJson(item as Map<String, dynamic>))
          .toList(),
      dailyForecasts: (json['dailyForecasts'] as List<dynamic>)
          .map((item) => DailyForecast.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
