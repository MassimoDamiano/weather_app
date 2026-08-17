import 'package:weather_app/features/weather/models/radar_frame.dart';
import 'package:weather_app/features/weather/services/radar_service.dart';

class RadarRepository {
  final RadarService _service;

  RadarRepository({required RadarService service}) : _service = service;

  Future<RadarFrame> getLatestFrame() {
    return _service.getLatestFrame();
  }
}
