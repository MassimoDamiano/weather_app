import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/formatters/weather_description_formatter.dart';

void main() {
  group('WeatherDescriptionFormatter', () {
    test('replaces uncommon OpenWeather descriptions', () {
      expect(WeatherDescriptionFormatter.format('muy nuboso'), 'muy nublado');
      expect(WeatherDescriptionFormatter.format('cielo claro'), 'despejado');
      expect(
        WeatherDescriptionFormatter.format('nubes dispersas'),
        'parcialmente nublado',
      );
    });

    test('keeps an unknown description unchanged', () {
      expect(
        WeatherDescriptionFormatter.format('tormenta tropical'),
        'tormenta tropical',
      );
    });
  });
}
