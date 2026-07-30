import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    final LocationService _locationService;

    if (serviceEnabled == false) {
      throw Exception("Ubicacion desactivada");
    }
    //Con esto chekeo el permiso
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Permiso de ubicación denegado");
      }
    }
    final ubi = await Geolocator.getCurrentPosition();
    return ubi;
  }
}
/*
¿Está activada la ubicación?
        ↓
¿Tengo permiso?
        ↓
si no → pedirlo
        ↓
¿me lo negó?
        ↓
sí → error
no
        ↓
obtener Position
        ↓
return
*/
