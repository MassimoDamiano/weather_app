import 'package:flutter/material.dart';
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

  Weather? get weather => _weather;

  bool get isLoading => _isLoading;

  String? get error => _error;

  WeatherProvider({
    required WeatherRepository repository,
    required LocationService locationService,
  }) : _repository = repository,
       _locationService = locationService;

  //“Cuando me creen un WeatherProvider,
  //me tienen que pasar un WeatherRepository, y yo lo guardo en mi variable _repository.

  Future<void> loadCurrentWeather() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final position = await _locationService.getCurrentLocation();
      
      final weather = await _repository.getCurrentWeather(position.latitude, position.longitude);
      _weather = weather;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }
}
