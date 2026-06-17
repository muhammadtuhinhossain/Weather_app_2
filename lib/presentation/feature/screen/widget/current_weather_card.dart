import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/core/weather_helper.dart';

import '../../../../domain/entities/weather.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({super.key, required this.cityName, required this.weather});
  final String cityName;
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            Text(cityName,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400,color: Colors.white,letterSpacing: 0.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8,),
            Text(
              DateFormat('EEEE, MMM d').format(DateTime.now()),
              style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8),),
            ),
            Icon(WeatherHelper.getWeatherIcon(weather.weatherCode),
            size: 80,
              color: Colors.white,
            ),
            Text(
              '${weather.temperature.round()}°',
              style: TextStyle(
                fontSize: 95,
                fontWeight: FontWeight.w100,
                height: 1,
                color: Colors.white,
              ),
            ),
            Text(
              WeatherHelper.getConditionText(weather.weatherCode),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                height: 1,
                color: Colors.white,
              ),
            ),
            Text(
              'H:${weather.highTeam.round()}°' 'L:${weather.lowTeam.round()}°',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                height: 1,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wind_power,
                color: Colors.white.withValues(alpha: 0.8),
                  size: 16,
                ),
                SizedBox(width: 8,),
                Text(
                  '${weather.windSpeed.round()} km/h',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
