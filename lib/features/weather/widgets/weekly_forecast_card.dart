import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_spacing.dart';
import 'package:weather_app/features/weather/models/daily_forecast.dart';

class WeeklyForecastCard extends StatelessWidget {
  final List<DailyForecast> forecasts;

  const WeeklyForecastCard({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    final weeklyMin = forecasts.isEmpty
        ? 0.0
        : forecasts
              .map((forecast) => forecast.minTemp)
              .reduce((current, value) => min(current, value).toDouble());
    final weeklyMax = forecasts.isEmpty
        ? 1.0
        : forecasts
              .map((forecast) => forecast.maxTemp)
              .reduce((current, value) => max(current, value).toDouble());

    return Container(
      height: 400,
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
                Icons.calendar_today_outlined,
                size: 14,
                color: Colors.white.withValues(alpha: 0.65),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'PRONÓSTICO DE 5 DÍAS',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView.separated(
              itemCount: forecasts.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: Colors.white.withValues(alpha: 0.14),
              ),
              itemBuilder: (context, index) {
                final daily = forecasts[index];

                return SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 58,
                        child: Text(
                          _dayLabel(daily.date),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Image.network(
                        'https://openweathermap.org/img/wn/${daily.iconCode}@2x.png',
                        width: 38,
                        height: 38,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.cloud, color: Colors.white),
                      ),
                      const Spacer(),
                      Text(
                        '${daily.minTemp.round()}°',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _TemperatureRangeBar(
                        minTemperature: daily.minTemp,
                        maxTemperature: daily.maxTemp,
                        weeklyMin: weeklyMin,
                        weeklyMax: weeklyMax,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '${daily.maxTemp.round()}°',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _dayLabel(DateTime date) {
    final today = DateTime.now();
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return 'Hoy';
    }

    const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return days[date.weekday - 1];
  }
}

class _TemperatureRangeBar extends StatelessWidget {
  final double minTemperature;
  final double maxTemperature;
  final double weeklyMin;
  final double weeklyMax;

  const _TemperatureRangeBar({
    required this.minTemperature,
    required this.maxTemperature,
    required this.weeklyMin,
    required this.weeklyMax,
  });

  @override
  Widget build(BuildContext context) {
    final temperatureSpan = weeklyMax - weeklyMin;
    final safeSpan = temperatureSpan == 0 ? 1.0 : temperatureSpan;
    final startRatio = ((minTemperature - weeklyMin) / safeSpan)
        .clamp(0.0, 1.0)
        .toDouble();
    final endRatio = ((maxTemperature - weeklyMin) / safeSpan)
        .clamp(0.0, 1.0)
        .toDouble();

    return SizedBox(
      width: 72,
      height: 4,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final start = constraints.maxWidth * startRatio;
          final availableWidth = constraints.maxWidth - start;
          final rangeWidth = min(
            availableWidth,
            max(5.0, constraints.maxWidth * (endRatio - startRatio)),
          );

          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                left: start,
                child: Container(
                  width: rangeWidth,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF67E8F9), Color(0xFFFDE047)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
