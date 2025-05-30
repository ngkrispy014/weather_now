import 'package:weather_now/model/weather_forecast_model.dart';

abstract class WeatherRepository {
  Future<WeatherForecastModel> fetchWeatherJson();
  Future<WeatherForecastModel> fetchWeatherXml();
}