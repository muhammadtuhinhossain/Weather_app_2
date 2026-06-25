import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/daily_weather.dart';
import 'package:weather_app2/presentation/core/frosted_glass_card.dart';

class DailyForecastSection extends StatelessWidget {
  final List<DailyWeather> dailyList;

  const DailyForecastSection({super.key, required this.dailyList});

  IconData _getWeatherIcon(int code) {
    if (code == 0) return Icons.wb_sunny;
    if (code <= 3) return Icons.cloud;
    if (code <= 67) return Icons.grain;
    if (code <= 77) return Icons.ac_unit;
    if (code <= 99) return Icons.thunderstorm;
    return Icons.cloud;
  }

  String _formatDay(String isoDate, int index) {
    if (index == 0) return 'Today';
    final dt = DateTime.parse(isoDate);
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[dt.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    if (dailyList.isEmpty) return const SizedBox();

    // Pura week er overall min-max — sob bar ek e scale e draw korar jonno
    final overallMin = dailyList.map((d) => d.minTemp).reduce((a, b) => a < b ? a : b);
    final overallMax = dailyList.map((d) => d.maxTemp).reduce((a, b) => a > b ? a : b);
    final range = (overallMax - overallMin).clamp(1, double.infinity);

    return FrostedGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: const [
                Icon(Icons.calendar_today, color: Colors.white70, size: 14),
                SizedBox(width: 8),
                Text(
                  '10-DAY FORECAST',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.white.withOpacity(0.3), thickness: 1, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Column(
              children: List.generate(dailyList.length, (index) {
                final day = dailyList[index];
                final startFraction = (day.minTemp - overallMin) / range;
                final endFraction = (day.maxTemp - overallMin) / range;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 45,
                        child: Text(
                          _formatDay(day.date, index),
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: 28,
                        child: Icon(_getWeatherIcon(day.weatherCode), color: Colors.white, size: 18),
                      ),
                      SizedBox(
                        width: 28,
                        child: Text(
                          '${day.minTemp.round()}°',
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final w = constraints.maxWidth;
                            return Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  height: 4,
                                  width: w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                Positioned(
                                  left: w * startFraction,
                                  child: Container(
                                    height: 4,
                                    width: w * (endFraction - startFraction),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.orange],
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 32,
                        child: Text(
                          '${day.maxTemp.round()}°',
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}