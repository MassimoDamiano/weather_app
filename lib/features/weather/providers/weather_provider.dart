import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/models/weather.dart';


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


  Weather? get weather => _weather;

  bool get isLoading => _isLoading;

  String? get error => _error;
 
}
