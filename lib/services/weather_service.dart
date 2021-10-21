import 'dart:convert';
import 'dart:developer';

import '../models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final apiKey = "ed83861dce9e7c81791c42143078dcbd";
  Future<WeatherResponse> getWeatherByPosition({required double lat, required double lon}) async {
    const exclude = 'minutely,hourly,alerts';
    const units = 'metric';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=$exclude&appid=$apiKey&units=$units');
    var respone = await http.get(url);

    Map<String, dynamic> jsonData = jsonDecode(respone.body);
    log(jsonData.toString());
    return WeatherResponse.fromJson(jsonData);
  }
}
