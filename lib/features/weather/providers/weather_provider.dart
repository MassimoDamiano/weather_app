import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/models/radar_frame.dart';
import 'package:weather_app/features/weather/repositories/radar_repository.dart';
import 'package:weather_app/features/weather/models/weather.dart';
import 'package:weather_app/features/weather/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/services/location_service.dart';

/*
El Provider administra el estado que necesita la interfaz.

Queremos que tenga tres estados principales:

Weather actual
¿Está cargando?
¿Hubo error?

//ChangeNotifier allowsme to call NotifyListeners when the state is changing

*/

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _error;
  final WeatherRepository _repository;
  final LocationService _locationService;
  final RadarRepository _radarRepository;
  RadarFrame? _radarFrame;

  Weather? get weather => _weather;

  bool get isLoading => _isLoading;

  String? get error => _error;

  RadarFrame? get radarFrame => _radarFrame;

  WeatherProvider({
    required WeatherRepository repository,
    required LocationService locationService,
    required RadarRepository radarRepository,
  }) : _repository = repository,
       _locationService = locationService,
       _radarRepository = radarRepository;

  //“Cuando me creen un WeatherProvider,
  //me tienen que pasar un WeatherRepository, y yo lo guardo en mi variable _repository.

  Future<void> loadCurrentWeather() async {
    try {
      final position = await _locationService.getCurrentLocation();

      await loadWeather(
        position?.latitude ?? -31.4201,
        position?.longitude ?? -64.1888,
      );
    } catch (error) {
      _error = error.toString();
      notifyListeners();
    }
  }

  Future<void> loadWeather(double latitude, double longitude) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _weather = await _repository.getCurrentWeather(latitude, longitude);
    } catch (error) {
      _error = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadRadar() async {
    try {
      _radarFrame = await _radarRepository.getLatestFrame();
      notifyListeners();
    } catch (_) {
      // El clima principal sigue disponible aunque el radar no responda.
    }
  }
}
