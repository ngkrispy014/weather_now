import 'package:flutter/material.dart';
import 'package:weather_now/model/weather_data_format.dart';
import 'package:weather_now/model/weather_forecast_model.dart';
import 'package:weather_now/utils/convert_icon.dart';
import 'package:weather_now/utils/strings.dart';

class MidView extends StatelessWidget {
  final WeatherForecastModel weather;
  final WeatherDataFormat format;

  const MidView({super.key, required this.weather, required this.format});

  @override
  Widget build(BuildContext context) {
    final city = weather.name ?? 'N/A';
    final country = weather.sys?.country ?? 'N/A';
    final timestamp = weather.dt?.toInt() ?? 0;
    final formattedDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    final weatherMain =
        weather.weather?.isNotEmpty == true ? weather.weather![0].main : null;

    String getWeatherDescription() {
      if (format == WeatherDataFormat.json) {
        // JSON path: description in weather[0].description
        return weather.weather?.isNotEmpty == true
            ? (weather.weather![0].description?.toUpperCase() ?? 'N/A')
            : 'N/A';
      } else {
        // XML path: you can use weather[0].main or clouds.all or clouds.name
        // Assuming your Weather.fromXml puts description in main or you want to use clouds.name
        return weather.weather?.isNotEmpty == true
            ? (weather.weather![0].main?.toUpperCase() ?? 'N/A')
            : 'N/A';
      }
    }

    final temp = weather.main?.temp?.toStringAsFixed(0) ?? 'N/A';

    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$city, $country",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            Strings.getFormattedDate(formattedDate),
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: getWeatherIcon(weatherDescription: weatherMain),
          ),
          Text(
            getWeatherDescription(),
            style: const TextStyle(fontSize: 28, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$temp°F",
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
