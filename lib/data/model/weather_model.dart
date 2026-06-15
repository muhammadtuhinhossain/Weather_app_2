import 'package:weather_app2/domain/entities/weather.dart';

class WeatherModel extends Weather{
  WeatherModel({required super.time, required super.temperature, required super.weatherCode, required super.windSpeed, required super.highTeam, required super.lowTeam});

  factory WeatherModel.fromJson({
    required Map<String, dynamic> current,
    required Map<String, dynamic> daily,
  }) {
    return WeatherModel(
      time: current['time'] as String,
      temperature: (current['temperature_2m'] as num).toDouble(),
      weatherCode: current['weather_code'] as int,
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      highTeam: (daily['temperature_2m_max'][0] as num).toDouble(),
      lowTeam: (daily['temperature_2m_min'][0] as num).toDouble(),
    );
  }
}