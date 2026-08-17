class LocationSearchResult {
  final String name;
  final String country;
  final String? state;
  final double latitude;
  final double longitude;

  const LocationSearchResult({
    required this.name,
    required this.country,
    required this.state,
    required this.latitude,
    required this.longitude,
  });

  factory LocationSearchResult.fromJson(Map<String, dynamic> json) {
    return LocationSearchResult(
      name: json['name'] as String,
      country: json['country'] as String,
      state: json['state'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
