import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_now/bloc/weather_bloc.dart';
import 'package:weather_now/bloc/weather_event.dart';
import 'package:weather_now/bloc/weather_state.dart';
import 'package:weather_now/components/gradient_container.dart';
import 'package:weather_now/feature/weather/widgets/mid_view.dart';
import 'package:weather_now/model/weather_data_format.dart';
import 'package:weather_now/model/weather_forecast_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        Widget content;

        if (state.isLoading) {
          content = _buildLoadingView();
        } else if (state.errorMessage != null) {
          content = _buildGradientContainer(
            "Clear",
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 220.0),
                  child: Center(
                    child: Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state.weather != null) {
          final weather = state.weather!;

          content = _buildGradientContainer(
            (weather.weather?.isNotEmpty ?? false)
                ? weather.weather![0].main ?? 'Clear'
                : 'Clear',
            SingleChildScrollView(
              child: Center(
                child: SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: _buildBodyView(weather, state.format)),
              ),
            ),
          );
        } else {
          // No weather data, no error, not loading — show empty state
          content = _buildGradientContainer(
            "Clear",
            ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 220.0),
                  child: Center(
                    child: Text(
                      "No Data Found",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: content,
          bottomNavigationBar: _buildFormatToggleButtons(state.format),
        );
      },
    );
  }

  Widget _buildFormatToggleButtons(WeatherDataFormat currentFormat) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: WeatherDataFormat.values.map((format) {
          final isSelected = format == currentFormat;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.blueAccent : Colors.grey,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              onPressed: () {
                context.read<WeatherBloc>().add(SwitchFormatEvent(format));
              },
              child: Text(format.name.toUpperCase()),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBodyView(
      WeatherForecastModel weather, WeatherDataFormat format) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MidView(
          weather: weather,
          format: format,
        ),
      ],
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: SimpleDialog(
        backgroundColor:
            const Color.fromARGB(221, 160, 141, 141), // darker background
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 12, 20, 18)),
                ),
                SizedBox(height: 20),
                Text(
                  "Please Wait....",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  GradientContainer _buildGradientContainer(
      String weatherDescription, Widget child) {
    switch (weatherDescription) {
      case "Clear":
        return GradientContainer(color: Colors.yellow, child: child);
      case "Clouds":
        return GradientContainer(color: Colors.indigo, child: child);
      case "Rain":
        return GradientContainer(color: Colors.deepPurple, child: child);
      case "Snow":
        return GradientContainer(color: Colors.lightBlue, child: child);
      case "scattered clouds":
        return GradientContainer(color: Colors.indigo, child: child);
      case "broken clouds":
        return GradientContainer(color: Colors.indigo, child: child);
      default:
        return GradientContainer(color: Colors.lightGreen, child: child);
    }
  }
}
