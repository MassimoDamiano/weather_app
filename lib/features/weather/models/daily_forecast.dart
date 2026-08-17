/// Representa el resumen meteorológico de un día.
class DailyForecast {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String iconCode;

  const DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.iconCode,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.parse(json['date'] as String),
      maxTemp: (json['maxTemp'] as num).toDouble(),
      minTemp: (json['minTemp'] as num).toDouble(),
      iconCode: json['iconCode'] as String,
    );
  }
}
