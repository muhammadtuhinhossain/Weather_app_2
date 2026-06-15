import 'package:weather_app2/domain/entities/weather.dart';

import 'daily_weather.dart';
import 'hourly_weather.dart';

class WeatherResult {
  final Weather current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;

  WeatherResult({required this.current, required this.hourly, required this.daily});
}