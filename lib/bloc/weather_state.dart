// weather_state.dart
import 'package:equatable/equatable.dart';
import 'package:weather_now/model/weather_data_format.dart';
import 'package:weather_now/model/weather_forecast_model.dart';

class WeatherState {
  final WeatherForecastModel? weather;
  final bool isLoading;
  final String? errorMessage;
  final WeatherDataFormat format;

  WeatherState({
    this.weather,
    this.isLoading = false,
    this.errorMessage,
    this.format = WeatherDataFormat.json,
  });

  WeatherState copyWith({
    WeatherForecastModel? weather,
    bool? isLoading,
    String? errorMessage,
    WeatherDataFormat? format,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      format: format ?? this.format,
    );
  }

  factory WeatherState.initial() {
    return WeatherState(
      weather: null,
      isLoading: false,
      errorMessage: null,
      format: WeatherDataFormat.json, // initial format as JSON
    );
  }
}
