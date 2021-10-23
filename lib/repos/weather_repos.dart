import '../models/weather/weather_model.dart';
import '../services/weather_service.dart';

class WeatherRepo {
  WeatherService _weatherService = WeatherService();

  Future<WeatherModel> getWeatherByPosition({required double lat, required double lon}) async {
    var responseJson = await _weatherService.getWeatherByPosition(lat: lat, lon: lon);
    return WeatherModel.fromJson(responseJson);
  }
}
