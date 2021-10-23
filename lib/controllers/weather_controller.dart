import '../models/weather/weather_model.dart';
import '../repos/weather_repos.dart';

class WeatherController {
  WeatherRepo _weatherRepo = WeatherRepo();

  Future<WeatherModel> getWeatherByPosition({required double lat, required double lon}) async {
    return await _weatherRepo.getWeatherByPosition(lat: lat, lon: lon);
  }
}
