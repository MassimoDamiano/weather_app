// Representa un día del pronóstico semanal.

class Dailyforecast {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String iconCode;

Dailyforecast({
  required this.date,
  required this.maxTemp,
  required this.minTemp,
  required this.iconCode
});

}
