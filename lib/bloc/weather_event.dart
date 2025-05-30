import 'package:weather_now/model/weather_data_format.dart';

abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {}

class SwitchFormatEvent extends WeatherEvent {
  final WeatherDataFormat format;

  SwitchFormatEvent(this.format);
}
