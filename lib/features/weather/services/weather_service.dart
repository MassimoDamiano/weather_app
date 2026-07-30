import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/api_constants.dart';
import '../models/weather.dart';

class WeatherService {
  Future<Weather> getCurrentWeather(double lat, double lon) async {
   
    // 1. Crear URL
   
    final url = Uri.https(
      'api.openweathermap.org', //Dominio
      '/data/2.5/weather', // Ruta
      //Parametros
      {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'appid': ApiConstants.apiKey,
        'units': 'metric',
        'lang': 'es',
      },
    );
    
    // 2. Hacer GET

    final response = await http.get(url); //mandá una petición GET a esa URL y esperá la respuesta.

    // 3. Comprobar statusCode
   if (response.statusCode == 200) {
  final data = jsonDecode(response.body); //para convertir ese JSON
  return Weather(
    temperature: (data['main']['temp'] as num).toDouble(),
    maxTemp: (data['main']['temp_max'] as num).toDouble(),
    minTemp: (data['main']['temp_min'] as num).toDouble(),
    feelsLike: (data['main']['feels_like'] as num).toDouble(),
    humidity: data['main']['humidity'],
    windSpeed: (data['wind']['speed'] as num).toDouble(),
    description: data['weather'][0]['description'],
    iconCode: data['weather'][0]['icon'],
  );
} else {
  throw Exception(
    'Error al obtener el clima: ${response.statusCode}',
  );
}
  }
}
