import 'package:flutter/material.dart';

Widget getWeatherIcon({String? weatherDescription}) {
  switch (weatherDescription) {
    case "Clear":
      {
        return Image.asset('assets/images/clear-day.png');
      }

    case "Clouds":
      {
        return Image.asset('assets/images/cloudy.png');
      }
    case "scattered clouds":
      {
        return Image.asset('assets/images/cloudy.png');
      }
    case "broken clouds":
      {
        return Image.asset('assets/images/cloudy.png');
      }
    case "Rain":
      {
        return Image.asset('assets/images/rain.png');
      }
    case "Snow":
      {
        return Image.asset('assets/images/snow.png');
      }
    default:
      {
        return Image.asset('assets/images/clear-day.png');
      }
  }
}
