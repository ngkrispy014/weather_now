import 'package:dio/dio.dart';
import 'package:weather_now/model/weather_forecast_model.dart';
import 'package:xml/xml.dart' as xml;
import 'package:dio/dio.dart';
import 'package:xml/xml.dart' as xml;

class OpenWeatherService {
  final Dio dio;

  OpenWeatherService({Dio? dioClient}) : dio = dioClient ?? Dio();

  Future<WeatherForecastModel> getWeather({bool isJson = true}) async {
    final mode = isJson ? 'json' : 'xml';
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=442d8ee0ab044786450da5b668b54160&mode=$mode";

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      if (isJson) {
        // JSON response
        return WeatherForecastModel.fromJson(response.data);
      } else {
        // XML response - response.data is raw XML string
        final document = xml.XmlDocument.parse(response.data);
        return WeatherForecastModel.fromXml(document.rootElement);
      }
    } else {
      throw Exception('Failed to load weather data ($mode)');
    }
  }
}
