import 'package:xml/xml.dart';

class WeatherForecastModel {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  num? visibility;
  Wind? wind;
  Clouds? clouds;
  num? dt;
  Sys? sys;
  num? timezone;
  num? id;
  String? name;
  num? cod;

  WeatherForecastModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    return WeatherForecastModel(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather:
          (json['weather'] as List?)?.map((v) => Weather.fromJson(v)).toList(),
      base: json['base'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      visibility: json['visibility'],
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }

  factory WeatherForecastModel.fromXml(XmlElement xml) {
    /// Handling missing dt in xml response
    final lastUpdateStr = xml.getElement('lastupdate')?.getAttribute('value');
    int? dtValue;
    if (lastUpdateStr != null) {
      try {
        final dateTime = DateTime.parse(lastUpdateStr);
        dtValue = dateTime.millisecondsSinceEpoch ~/ 1000; // to seconds
      } catch (e) {
        dtValue = 0;
      }
    }

    return WeatherForecastModel(
      coord: Coord.fromXml(xml.getElement('city')?.getElement('coord')),
      weather: [Weather.fromXml(xml.getElement('weather'))],
      main: Main.fromXml(xml),
      visibility: num.tryParse(
          xml.getElement('visibility')?.getAttribute('value') ?? ''),
      wind: Wind.fromXml(xml.getElement('wind')),
      clouds: Clouds.fromXml(xml.getElement('clouds')),
      sys: Sys.fromXml(xml.getElement('city')),
      name: xml.getElement('city')?.getAttribute('name'),
      dt: dtValue,
    );
  }
}

class Coord {
  num? lon;
  num? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'],
      lat: json['lat'],
    );
  }

  factory Coord.fromXml(XmlElement? xml) {
    final lonStr = xml?.getAttribute('lon');
    final latStr = xml?.getAttribute('lat');

    return Coord(
      lon: num.tryParse(lonStr ?? ''),
      lat: num.tryParse(latStr ?? ''),
    );
  }
}

class Weather {
  num? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  factory Weather.fromXml(XmlElement? xml) {
    final idStr = xml?.getAttribute('number');
    final mainStr = xml?.getAttribute('value');
    final iconStr = xml?.getAttribute('icon');

    return Weather(
      id: num.tryParse(idStr ?? ''),
      main: mainStr,
      icon: iconStr,
    );
  }
}

class Main {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  num? pressure;
  num? humidity;
  num? seaLevel;
  num? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }

  factory Main.fromXml(XmlElement xml) {
    final temperature = xml.getElement('temperature');
    final feelsLike = xml.getElement('feels_like');
    final pressure = xml.getElement('pressure');
    final humidity = xml.getElement('humidity');

    return Main(
      temp: num.tryParse(temperature?.getAttribute('value') ?? ''),
      tempMin: num.tryParse(temperature?.getAttribute('min') ?? ''),
      tempMax: num.tryParse(temperature?.getAttribute('max') ?? ''),
      feelsLike: num.tryParse(feelsLike?.getAttribute('value') ?? ''),
      pressure: num.tryParse(pressure?.getAttribute('value') ?? ''),
      humidity: num.tryParse(humidity?.getAttribute('value') ?? ''),
    );
  }
}

class Wind {
  num? speed;
  num? deg;
  num? gust;

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'],
      deg: json['deg'],
      gust: json['gust'],
    );
  }

  factory Wind.fromXml(XmlElement? xml) {
    final speed = xml?.getElement('speed');
    final gusts = xml?.getElement('gusts');
    final direction = xml?.getElement('direction');

    return Wind(
      speed: num.tryParse(speed?.getAttribute('value') ?? ''),
      gust: num.tryParse(gusts?.getAttribute('value') ?? ''),
      deg: num.tryParse(direction?.getAttribute('value') ?? ''),
    );
  }
}

class Clouds {
  num? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }

  factory Clouds.fromXml(XmlElement? xml) {
    final value = xml?.getAttribute('value');
    return Clouds(
      all: num.tryParse(value ?? ''),
    );
  }
}

class Sys {
  num? type;
  num? id;
  String? country;
  DateTime? sunrise;
  DateTime? sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['sunrise'] * 1000)
          : null,
      sunset: json['sunset'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['sunset'] * 1000)
          : null,
    );
  }

  factory Sys.fromXml(XmlElement? xml) {
    if (xml == null) return Sys();

    final sunriseStr = xml.getElement('sun')?.getAttribute('rise');
    final sunsetStr = xml.getElement('sun')?.getAttribute('set');

    DateTime? parseDateTime(String? s) {
      if (s == null) return null;
      try {
        return DateTime.parse(s);
      } catch (e) {
        print('Error parsing date time from XML: $e');
        return null;
      }
    }

    final countryElement = xml.getElement('country');
    final country = countryElement?.innerText;

    return Sys(
      country: country,
      sunrise: parseDateTime(sunriseStr),
      sunset: parseDateTime(sunsetStr),
    );
  }
}
