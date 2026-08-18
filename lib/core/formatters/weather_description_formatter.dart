class WeatherDescriptionFormatter {
  const WeatherDescriptionFormatter._();

  static const _descriptions = <String, String>{
    'cielo claro': 'despejado',
    'algo de nubes': 'algo nublado',
    'nubes dispersas': 'parcialmente nublado',
    'muy nuboso': 'muy nublado',
    'nubes': 'nublado',
    'lluvia ligera': 'lluvia leve',
    'lluvia de gran intensidad': 'lluvia intensa',
    'llovizna ligera': 'llovizna leve',
    'nevada ligera': 'nieve leve',
  };

  static String format(String description) {
    final normalizedDescription = description.trim().toLowerCase();

    return _descriptions[normalizedDescription] ?? description.trim();
  }
}
