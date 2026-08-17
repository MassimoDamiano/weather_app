import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/models/radar_frame.dart';

class RadarService {
  Future<RadarFrame> getLatestFrame() async {
    final response = await http.get(
      Uri.parse('https://api.rainviewer.com/public/weather-maps.json'),
    );

    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener el radar');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final host = data['host'] as String;
    final pastFrames = data['radar']['past'] as List;
    final latestFrame = pastFrames.last as Map<String, dynamic>;

    return RadarFrame(
      tileUrl: '$host${latestFrame['path']}/256/{z}/{x}/{y}/2/1_1.png',
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        (latestFrame['time'] as num).toInt() * 1000,
      ),
    );
  }
}
