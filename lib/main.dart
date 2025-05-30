import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_now/bloc/weather_bloc.dart';
import 'package:weather_now/bloc/weather_event.dart';
import 'package:weather_now/data/weather_repository.dart';
import 'package:weather_now/data/weather_service.dart';
import 'package:weather_now/feature/weather/weatherpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final weatherRepository = WeatherRepositoryImpl(OpenWeatherService());

    return BlocProvider(
      create: (_) => WeatherBloc(weatherRepository: weatherRepository)
        ..add(FetchWeatherEvent()), // optional initial fetch
      child: MaterialApp(
        title: 'Weather Now',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: WeatherPage(),
      ),
    );
  }
}
