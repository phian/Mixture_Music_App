import 'current_weather_model.dart';
import 'daily_weather_model.dart';

class WeatherModel {
  WeatherModel({
    required this.current,
    required this.daily,
  });
  late final CurrentWeatherModel current;
  late final List<DailyWeatherModel> daily;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    current = CurrentWeatherModel.fromJson(json['current']);
    daily = List.from(json['daily']).map((e) => DailyWeatherModel.fromJson(e)).toList();
  }
}
