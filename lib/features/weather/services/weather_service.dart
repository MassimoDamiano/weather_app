import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/features/weather/models/weather.dart';

class WeatherService {
  final http.Client _client;

  WeatherService({http.Client? client}) : _client = client ?? http.Client();

  Future<Weather> getCurrentWeather(double latitude, double longitude) async {
    final uri = Uri.parse('${ApiConstants.backendBaseUrl}/api/weather').replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      },
    );

    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener el clima (${response.statusCode}).');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Weather.fromJson(json);
  }
}
