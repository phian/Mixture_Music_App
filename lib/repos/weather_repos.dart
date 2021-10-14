import 'dart:convert';
import 'dart:developer';

import 'package:mixture_music_app/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Weather> getWeatherByPosition({required double lat, required double lon}) async {
    var key = 'c42df737907f4153b3364951211210';
    var url = Uri.parse('https://api.weatherapi.com/v1/current.json?key=$key&q=$lat,$lon&aqi=no');
    var respone = await http.get(url);

    Map<String, dynamic> jsonData = jsonDecode(respone.body);
    log(jsonData.toString());
    return Weather.fromJson(jsonData);
  }
}
