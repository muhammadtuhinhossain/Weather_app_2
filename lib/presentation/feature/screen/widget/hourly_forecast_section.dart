import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/hourly_weather.dart';
import 'package:weather_app2/presentation/core/frosted_glass_card.dart';

class HourlyForecastSection extends StatelessWidget {
  final List<HourlyWeather> hourlyList;

  const HourlyForecastSection({super.key, required this.hourlyList});

  IconData _getWeatherIcon(int code) {
    if (code == 0) return Icons.wb_sunny;
    if (code <= 3) return Icons.cloud;
    if (code <= 67) return Icons.grain;
    if (code <= 77) return Icons.ac_unit;
    if (code <= 99) return Icons.thunderstorm;
    return Icons.cloud;
  }

  String _formatTime(String isoTime) {
    final dt = DateTime.parse(isoTime);
    final hour = dt.hour;
    if (hour == 0) return '12 AM';
    if (hour < 12) return '$hour AM';
    if (hour == 12) return '12 PM';
    return '${hour - 12} PM';
  }

  @override
  Widget build(BuildContext context) {
    return FrostedGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: const Text(
              'HOURLY FORECAST',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          Divider(
            color: Colors.white.withOpacity(0.3),
            thickness: 1,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourlyList.length,
                itemBuilder: (context, index) {
                  final h = hourlyList[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          index == 0 ? 'Now' : _formatTime(h.time),
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Icon(_getWeatherIcon(h.weatherCode), color: Colors.white, size: 24),
                        const SizedBox(height: 8),
                        Text(
                          '${h.temperature.round()}°',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}