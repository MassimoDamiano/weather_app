# Weather App

Aplicación móvil desarrollada con Flutter que consume una API meteorológica para mostrar el clima actual y el pronóstico de distintas ciudades. Estamos usando una organización tipo Feature First: todo lo que pertenece al clima queda dentro de features/weather.

Movil app developed whit flutter, show the actual weather

## How works? 

    Usuario abre HomeScreen
            ↓
    WeatherProvider
            ↓
    necesita coordenadas
            ↓
    LocationService
            ↓
    lat / lon
            ↓
    WeatherProvider
            ↓
    WeatherRepository
            ↓
    WeatherService
            ↓
    OpenWeather
            ↓
    JSON
            ↓
    Weather
            ↓
    Repository
            ↓
    Provider
            ↓
    notifyListeners()
            ↓
    HomeScreen se actualiza

## Características

- Buscar ciudades
- Clima actual
- Pronóstico
- Temperatura
- Humedad
- Viento

## Tecnologías

- Flutter
- Dart
- REST API
- HTTP
- JSON

## Arquitectura

- Models
- Services
- Screens
- Widgets

## Capturas

(imágenes)



## Instalación

flutter pub get

flutter run

## Autor

Massimo Damiano