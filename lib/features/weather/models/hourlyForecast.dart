//Representa una hora del pronóstico.

class Hourlyforecast {
  final double temperature;
  final double precipitationProbability;
  final DateTime dateTime;
  final String iconCode;

  Hourlyforecast({
    required this.temperature,
    required this.precipitationProbability,
    required this.dateTime,
    required this.iconCode,
  });


  
}
