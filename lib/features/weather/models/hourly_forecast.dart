/// Representa un intervalo del pronóstico meteorológico.
class HourlyForecast {
  final double temperature;
  final double precipitationProbability;
  final DateTime dateTime;
  final String iconCode;

  const HourlyForecast({
    required this.temperature,
    required this.precipitationProbability,
    required this.dateTime,
    required this.iconCode,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      temperature: (json['temperature'] as num).toDouble(),
      precipitationProbability: (json['precipitationProbability'] as num)
          .toDouble(),
      dateTime: DateTime.parse(json['dateTime'] as String),
      iconCode: json['iconCode'] as String,
    );
  }
}
