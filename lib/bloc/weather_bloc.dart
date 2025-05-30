// weather_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_now/bloc/weather_event.dart';
import 'package:weather_now/bloc/weather_state.dart';
import 'package:weather_now/data/weather_interface.dart';
import 'package:weather_now/model/weather_data_format.dart';
import 'package:weather_now/model/weather_forecast_model.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherState.initial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      try {
        WeatherForecastModel weather;

        if (state.format == WeatherDataFormat.json) {
          weather = await weatherRepository.fetchWeatherJson();
        } else {
          weather = await weatherRepository.fetchWeatherXml();
        }

        emit(state.copyWith(weather: weather, isLoading: false));
      } catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.toString(), weather: null));
      }
    });

    on<SwitchFormatEvent>((event, emit) {
      emit(state.copyWith(format: event.format));
      add(FetchWeatherEvent()); // Refetch using new format
    });
  }
}
