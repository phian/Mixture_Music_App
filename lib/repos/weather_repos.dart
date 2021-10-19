import 'package:mixture_music_app/models/weather.dart';
import 'package:mixture_music_app/services/weather_service.dart';

class WeatherRepo {
  WeatherService _weatherService = WeatherService();

  Future<WeatherResponse> getWeatherByPosition({required double lat, required double lon}) async {
    return _weatherService.getWeatherByPosition(lat: lat, lon: lon);
  }
}
