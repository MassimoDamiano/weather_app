import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/core/theme/app_spacing.dart';
import 'package:weather_app/features/weather/models/city.dart';
import 'package:weather_app/features/weather/models/radar_frame.dart';

class WeatherMapCard extends StatelessWidget {
  final City city;
  final RadarFrame? radarFrame;

  const WeatherMapCard({
    super.key,
    required this.city,
    required this.radarFrame,
  });

  @override
  Widget build(BuildContext context) {
    final cityPosition = LatLng(city.latitud, city.longitude);

    return Container(
      height: 310,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.radar_outlined,
                size: 16,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'RADAR DE TORMENTAS',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: FlutterMap(
                key: ValueKey('${city.latitud}-${city.longitude}'),
                options: MapOptions(
                  initialCenter: cityPosition,
                  initialZoom: 7,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.opentopomap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.massimodamiano.weatherapp',
                    panBuffer: 0,
                    maxNativeZoom: 17,
                  ),
                  if (radarFrame != null)
                    Opacity(
                      opacity: 0.8,
                      child: TileLayer(
                        urlTemplate: radarFrame!.tileUrl,
                        tileDisplay: const TileDisplay.fadeIn(),
                      ),
                    ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: cityPosition,
                        width: 36,
                        height: 36,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 34,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (radarFrame == null)
                    const Center(child: CircularProgressIndicator()),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        '© OpenStreetMap contributors, SRTM',
                        onTap: () => launchUrl(
                          Uri.parse('https://www.openstreetmap.org/copyright'),
                        ),
                      ),
                      TextSourceAttribution(
                        '© OpenTopoMap (CC-BY-SA)',
                        onTap: () => launchUrl(
                          Uri.parse('https://opentopomap.org/about'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (radarFrame != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Row(
                children: [
                  Text(
                    'Radar: ${radarFrame!.dateTime.hour.toString().padLeft(2, '0')}:${radarFrame!.dateTime.minute.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                  const Spacer(),
                  Link(
                    uri: Uri.parse('https://www.rainviewer.com/'),
                    target: LinkTarget.blank,
                    builder: (context, followLink) => GestureDetector(
                      onTap: followLink,
                      child: Text(
                        'RainViewer',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 10,
                          color: Colors.white.withValues(alpha: 0.75),
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
