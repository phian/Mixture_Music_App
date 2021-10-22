import 'condition_model.dart';

class DailyWeatherModel {
  DailyWeatherModel({
    required this.dt,
    required this.temp,
    required this.weather,
  });
  late final int dt;
  late final Temp temp;
  late final List<Condition> weather;

  DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = Temp.fromJson(json['temp']);
    weather = List.from(json['weather']).map((e) => Condition.fromJson(e)).toList();
  }
}

class Temp {
  Temp({
    required this.min,
    required this.max,
  });
  late final double min;
  late final double max;

  Temp.fromJson(Map<String, dynamic> json) {
    min = double.parse(json['min'].toString());
    max = double.parse(json['max'].toString());
  }
}