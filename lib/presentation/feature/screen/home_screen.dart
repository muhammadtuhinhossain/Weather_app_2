import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/core/app_colors.dart';
import 'package:weather_app2/core/weather_helper.dart';
import 'package:weather_app2/presentation/feature/screen/widget/current_weather_card.dart';
import 'package:weather_app2/presentation/feature/screen/widget/daily_forecast_section.dart';
import 'package:weather_app2/presentation/feature/screen/widget/hourly_forecast_section.dart';
import 'package:weather_app2/presentation/feature/screen/widget/search_bar_widget.dart';
import 'package:weather_app2/presentation/provider/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeather('Istanbul');
    });
    //Provider.of<WeatherProvider>(context, listen: false).fetchWeather('New York');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;
    FocusScope.of(context).unfocus();
    Provider.of<WeatherProvider>(context, listen: false).fetchWeather(query);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, _) {
        final colors = provider.weatherResult != null
            ? WeatherHelper.getGradientColors(
          provider.weatherResult!.current.weatherCode,
        )
            : AppColors.sunnyGradient;

        return Scaffold(
          body: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      SearchBarWidget(
                        controller: _searchController,
                        onSearch: _onSearch,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                          child: _buildBody(provider))),
                    ],
                  ),
                ),
              ),
              if (provider.isLoading && provider.weatherResult != null)
                Positioned(
                  top: 16,
                  right: 16,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(WeatherProvider provider) {
    // Fix 1: null-safe check with ?.isNotEmpty
    if (provider.errorMessage?.isNotEmpty == true) {
      return Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          provider.errorMessage ?? '',  // Fix 2: null fallback
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (provider.weatherResult == null) {
      return SizedBox.shrink();
    }

    final weather = provider.weatherResult!;  // Fix 3: null assertion
    return Column(
      children: [
        CurrentWeatherCard(
            cityName: provider.cityName,
            weather: weather.current,
        ),
        const SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: HourlyForecastSection(hourlyList: weather.hourly),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DailyForecastSection(dailyList: weather.daily),
        ),
      ],
    );
  }
}

