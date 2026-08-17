import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/features/weather/models/location_search_result.dart';

class CitySearchService {
  final http.Client _client;

  CitySearchService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<LocationSearchResult>> search(String query) async {
    final uri = Uri.parse(
      '${ApiConstants.backendBaseUrl}/api/locations',
    ).replace(queryParameters: {'query': query, 'limit': '5'});

    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'No se pudieron buscar ciudades (${response.statusCode}).',
      );
    }

    final jsonList = jsonDecode(response.body) as List<dynamic>;

    return jsonList
        .map(
          (item) => LocationSearchResult.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }
}
