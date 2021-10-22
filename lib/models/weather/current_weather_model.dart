import 'condition_model.dart';

class CurrentWeatherModel {
  CurrentWeatherModel({
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  late final double temp;
  late final int pressure;
  late final int humidity;
  late final double windSpeed;
  late final List<Condition> weather;

  CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    temp = double.parse(json['temp'].toString());
    pressure = json['pressure'];
    humidity = json['humidity'];
    windSpeed = json['wind_speed'];
    weather = List.from(json['weather']).map((e) => Condition.fromJson(e)).toList();
  }
}