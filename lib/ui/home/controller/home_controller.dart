import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../controllers/weather_controller.dart';

import '../../../models/weather/weather_model.dart';



class HomeController extends GetxController {
  var location = "".obs;
  var weatherModel = Rxn<WeatherModel>();


  late Position _pos;
  WeatherController _weatherController = WeatherController();
  
  bool hasLoaded = false;

  @override
  void onInit() async {
    super.onInit();
    await getLocationAndWeather();
  }

  Future<void> getLocationAndWeather() async {
    _pos = await _determinePosition();
    location.value = await getLocationName();
    weatherModel.value = await _weatherController.getWeatherByPosition(
      lat: _pos.latitude,
      lon: _pos.longitude,
    );
    hasLoaded = true;
    update();
  }

  Future<String> getLocationName() async {
    Placemark placemark = Placemark();
    await placemarkFromCoordinates(_pos.latitude, _pos.longitude)
        .then((list) => placemark = list.first);

    var _location = "";
    if (placemark.subAdministrativeArea!.isNotEmpty) {
      _location = '${placemark.subAdministrativeArea}, ';
    }
    _location += '${placemark.administrativeArea}';

    return _location;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}