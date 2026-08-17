//Representa una ciudad.

class City {
  final String name;
  final double latitud;
  final double longitude;

  City({required this.name, required this.latitud, required this.longitude});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] as String,
      latitud: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
