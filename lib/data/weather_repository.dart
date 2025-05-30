import 'package:weather_now/data/weather_interface.dart';
import 'package:weather_now/data/weather_service.dart';
import 'package:weather_now/model/weather_forecast_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final OpenWeatherService api;

  WeatherRepositoryImpl(this.api);

  @override
  Future<WeatherForecastModel> fetchWeatherJson() async {
    // Calls API for JSON format and parses result
    return await api.getWeather(isJson: true);
  }

  @override
  Future<WeatherForecastModel> fetchWeatherXml() async {
    // Calls API for XML format and parses result
    return await api.getWeather(isJson: false);
  }
}
