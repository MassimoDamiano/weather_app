import '../models/weather.dart';
import '../services/weather_service.dart';

//El Repository recibe un Service en vez de crearlo adentro.

//La función del Repository es abstraer de dónde vienen los datos.



class WeatherRepository {

  //En vez de hacer que el Repository cree su propio Service internamente, se lo damos desde afuera.
  
  // INYECCION DE DEPENDENCIAS

  final WeatherService weatherService; 
  WeatherRepository({
    required this.weatherService,
  });

  
  
  Future<Weather> getCurrentWeather(double lat, double lon) {
    return weatherService.getCurrentWeather(lat, lon);
  }
}