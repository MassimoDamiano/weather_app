import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/api_constants.dart';
import 'dart:math';
import '../models/weather.dart';
import '../models/city.dart';
import '../models/hourlyForecast.dart';
import '../models/dailyForecast.dart';

class WeatherService {
  Future<Weather> getCurrentWeather(double lat, double lon) async {
    // URL para clima actual
    final currentUrl =
        Uri.https('api.openweathermap.org', '/data/2.5/weather', {
          'lat': lat.toString(),
          'lon': lon.toString(),
          'appid': ApiConstants.apiKey,
          'units': 'metric',
          'lang': 'es',
        });

    // URL para pronóstico por horas
    final forecastUrl =
        Uri.https('api.openweathermap.org', '/data/2.5/forecast', {
          'lat': lat.toString(),
          'lon': lon.toString(),
          'appid': ApiConstants.apiKey,
          'units': 'metric',
          'lang': 'es',
        });

    // Peticiones HTTP
    final currentResponse = await http.get(currentUrl);
    final forecastResponse = await http.get(forecastUrl);

    // Validar clima actual
    if (currentResponse.statusCode != 200) {
      throw Exception(
        'Error al obtener clima actual: ${currentResponse.statusCode}',
      );
    }

    // Validar pronóstico
    if (forecastResponse.statusCode != 200) {
      throw Exception(
        'Error al obtener pronóstico: ${forecastResponse.statusCode}',
      );
    }

    // Convertir JSON a Map
    final data = jsonDecode(currentResponse.body);
    final forecastData = jsonDecode(forecastResponse.body);

    final forecastList = forecastData['list'] as List;
    final forecastsByDay = <String, List<dynamic>>{};

    for (final item in forecastList) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
        (item['dt'] as num).toInt() * 1000,
      );

      final dayKey = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

      forecastsByDay.putIfAbsent(dayKey, () => []);
      forecastsByDay[dayKey]!.add(item);
    }

    // Convertir la lista JSON del forecast en List<Hourlyforecast>
    final hourlyForecasts = (forecastData['list'] as List).map<Hourlyforecast>((
      item,
    ) {
      return Hourlyforecast(
        temperature: (item['main']['temp'] as num).toDouble(),
        precipitationProbability: (item['pop'] as num?)?.toDouble() ?? 0.0,
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          (item['dt'] as num).toInt() * 1000,
        ),
        iconCode: item['weather'][0]['icon'] as String,
      );
    }).toList();

    // Convertir la lista JSON del forecast en List<Hourlyforecast>
    final dailyForecasts = forecastsByDay.values.map<Dailyforecast>((dayItems) {
      final temperatures = dayItems
          .map((item) => (item['main']['temp'] as num).toDouble())
          .toList();

      final firstItem = dayItems.first;
      final date = DateTime.fromMillisecondsSinceEpoch(
        (firstItem['dt'] as num).toInt() * 1000,
      );

      return Dailyforecast(
        date: date,
        minTemp: temperatures.reduce(min),
        maxTemp: temperatures.reduce(max),
        iconCode: firstItem['weather'][0]['icon'] as String,
      );
    }).toList();

    // Armar el objeto Weather completo
    return Weather(
      hourlyForecast: Hourlyforecast(
        temperature: (data['main']['temp'] as num).toDouble(),
        precipitationProbability: (data['pop'] as num?)?.toDouble() ?? 0.0,
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          (data['dt'] as int) * 1000,
        ),
        iconCode: data['weather'][0]['icon'] as String,
      ),
      dailyForecast: Dailyforecast(
        maxTemp: (data['main']['temp'] as num).toDouble(),
        minTemp: (data['pop'] as num?)?.toDouble() ?? 0.0,
        date: DateTime.fromMillisecondsSinceEpoch((data['dt'] as int) * 1000),
        iconCode: data['weather'][0]['icon'] as String,
      ),
      city: City(
        name: data['name'],
        latitud: (data['coord']['lat'] as num).toDouble(),
        longitude: (data['coord']['lon'] as num).toDouble(),
      ),
      temperature: (data['main']['temp'] as num).toDouble(),
      maxTemp: (data['main']['temp_max'] as num).toDouble(),
      minTemp: (data['main']['temp_min'] as num).toDouble(),
      feelsLike: (data['main']['feels_like'] as num).toDouble(),
      humidity: data['main']['humidity'],
      windSpeed: (data['wind']['speed'] as num).toDouble(),
      description: data['weather'][0]['description'] as String,
      iconCode: data['weather'][0]['icon'] as String,
      hourlyForecasts: hourlyForecasts,
      dailyForecasts: dailyForecasts,
    );
     }
}
