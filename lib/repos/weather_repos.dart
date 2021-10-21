import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherRepo {
  WeatherService _weatherService = WeatherService();

  Future<WeatherResponse> getWeatherByPosition({required double lat, required double lon}) async {
    return _weatherService.getWeatherByPosition(lat: lat, lon: lon);
  }
}
