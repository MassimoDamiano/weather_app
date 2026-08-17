import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:weather_app/features/weather/services/city_search_service.dart';
import 'package:weather_app/features/weather/services/weather_service.dart';

void main() {
  group('WeatherApi services', () {
    test(
      'search converts backend locations and sends query parameters',
      () async {
        final client = MockClient((request) async {
          expect(request.url.path, '/api/locations');
          expect(request.url.queryParameters['query'], 'Córdoba');
          expect(request.url.queryParameters['limit'], '5');

          return http.Response(
            jsonEncode([
              {
                'name': 'Córdoba',
                'country': 'AR',
                'state': 'Córdoba',
                'latitude': -31.4167,
                'longitude': -64.1833,
              },
            ]),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        });

        final service = CitySearchService(client: client);

        final locations = await service.search('Córdoba');

        expect(locations, hasLength(1));
        expect(locations.single.name, 'Córdoba');
        expect(locations.single.country, 'AR');
        expect(locations.single.latitude, -31.4167);
      },
    );

    test('weather converts the backend response', () async {
      final client = MockClient((request) async {
        expect(request.url.path, '/api/weather');
        expect(request.url.queryParameters['latitude'], '-31.4167');
        expect(request.url.queryParameters['longitude'], '-64.1833');

        return http.Response(
          jsonEncode({
            'city': {
              'name': 'Córdoba',
              'latitude': -31.4167,
              'longitude': -64.1833,
            },
            'temperature': 20.5,
            'maxTemp': 24.0,
            'minTemp': 14.0,
            'description': 'cielo claro',
            'iconCode': '01d',
            'humidity': 55,
            'windSpeed': 3.4,
            'feelsLike': 20.0,
            'hourlyForecasts': [
              {
                'temperature': 21.0,
                'precipitationProbability': 0.1,
                'dateTime': '2026-08-17T12:00:00-03:00',
                'iconCode': '01d',
              },
            ],
            'dailyForecasts': [
              {
                'date': '2026-08-17',
                'maxTemp': 24.0,
                'minTemp': 14.0,
                'iconCode': '01d',
              },
            ],
          }),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      });

      final service = WeatherService(client: client);

      final weather = await service.getCurrentWeather(-31.4167, -64.1833);

      expect(weather.city.name, 'Córdoba');
      expect(weather.temperature, 20.5);
      expect(weather.hourlyForecasts, hasLength(1));
      expect(weather.dailyForecasts, hasLength(1));
    });
  });
}
