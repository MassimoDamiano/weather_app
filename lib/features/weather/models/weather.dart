//Este modelo representa solamente el clima actual.

class Weather {
  final double temperature;
  final double maxTemp;
  final double minTemp;
  final String description;
  final String iconCode;
  final double humidity;
  final double windSpeed;
  final double feelsLike; //Sensacion termica

  Weather({
    required this.temperature,
    required this.maxTemp,
    required this.minTemp,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.feelsLike,
  });
}
