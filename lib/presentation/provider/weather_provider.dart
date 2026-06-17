import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/weather_result.dart';
import '../../data/service/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final _service = WeatherService();

  WeatherResult? _weatherResult;
  WeatherResult? get weatherResult => _weatherResult;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _cityName = '';
  String get cityName => _cityName;

  String _currentCity = '';
  String get currentCity => _currentCity;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final cityInfo = await _service.getCityLocation(city);
      if (cityInfo == null) {
        _errorMessage = 'City "$city" not found';
        _isLoading = false;
        notifyListeners();
        return;
      }
      final result = await _service.getWeather(
        cityInfo['latitude'] as double,
        cityInfo['longitude'] as double,
      );
      _cityName = '${cityInfo['name']}, ${cityInfo['country']}';
      _currentCity = city;
      _weatherResult = result;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch weather data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshWeather() async {
    if (_currentCity.isNotEmpty) {
      await fetchWeather(_currentCity);
    }
  }
}
