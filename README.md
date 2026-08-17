# Weather App

Aplicación multiplataforma desarrollada con Flutter para consultar el clima actual y el pronóstico de cualquier ciudad. El frontend se comunica con una API propia en ASP.NET Core, por lo que la clave del proveedor meteorológico nunca queda expuesta en la aplicación.

## Funcionalidades

- Búsqueda de ciudades con resultados coincidentes por país y provincia/estado.
- Clima actual, sensación térmica, humedad y viento.
- Pronóstico por hora y por día.
- Ubicación actual del dispositivo.
- Mapa meteorológico con radar de precipitaciones.
- Estados de carga y manejo de errores de red.

## Arquitectura

```text
Flutter UI
    ↓
Provider (estado de la aplicación)
    ↓
Repositories (reglas de acceso a datos)
    ↓
Services (peticiones HTTP y ubicación)
    ↓
WeatherApi (backend ASP.NET Core)
    ↓
OpenWeather
```

El código está organizado por funcionalidad (`features/weather`) y separa modelos, servicios, repositorios, providers, pantallas y widgets.

## Tecnologías

- Flutter y Dart
- Provider
- HTTP/REST y JSON
- Geolocator
- Flutter Map y RainViewer
- Backend en ASP.NET Core: [weather-app-backend](https://github.com/MassimoDamiano/weather-app-backend)

## Ejecución local

Primero iniciá el backend en `http://localhost:5270`. Después, desde este proyecto:

```bash
flutter pub get
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:5270
```

Para generar la versión web indicando el backend publicado:

```bash
flutter build web --dart-define=API_BASE_URL=https://TU-BACKEND.azurewebsites.net
```

## Calidad

```bash
flutter analyze
flutter test
```

## Autor

[Massimo Damiano](https://github.com/MassimoDamiano)
