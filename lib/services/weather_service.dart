import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  final apiKey = 'ed83861dce9e7c81791c42143078dcbd';

  Future<Map<String, dynamic>> getWeatherByPosition(
      {required double lat, required double lon}) async {
    const exclude = 'minutely,hourly,alerts';
    const units = 'metric';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=$exclude&appid=$apiKey&units=$units');
    var response = await http.get(url);

    Map<String, dynamic> jsonData =
        jsonDecode(response.body) as Map<String, dynamic>;

    return jsonData;
  }
}
