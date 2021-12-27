import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/playlist_controller.dart';
import 'package:mixture_music_app/controllers/song_controller.dart';
import 'package:mixture_music_app/controllers/theme_controller.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/weather_controller.dart';
import '../../../models/weather/weather_model.dart';

class HomeController extends GetxController {
  var location = ''.obs;
  var weatherModel = Rxn<WeatherModel>();
  var suggestedSongs = <SongModel>[].obs;

  late Position _pos;
  final _weatherController = WeatherController();
  final _themeController = Get.put(ThemeController());
  final _songController = SongController();
  final _playlistController = PlaylistController();

  String getWeatherType() {
    switch (weatherModel.value!.current.weather[0].main) {
      case 'Drizzle':
      case 'Mist':
      case 'Haze':
      case 'Fog':
      case 'Rain':
        return 'Rain';

      case 'Tornado':
      case 'Thunderstorm':
        return 'Thunderstorm';

      case 'Clear':
        return 'Sun';

      case 'Clouds':
        return 'Cloud';

      default:
        return 'Snow';
    }
  }

  Future<void> onPullToRefresh() async {
    await getLocationAndWeather();
    await getSuggestSongs();
  }

  Future<void> getSuggestSongs() async {
    suggestedSongs.value = await _songController.getSuggestedSongs(getWeatherType());
  }

  Future<void> saveSuggestedSongAsPlaylist() async {
    var newPlaylist = Playlist(
      createdTime: Timestamp.now(),
      title: "Today's Playlist",
      songs: suggestedSongs,
    );

    await _playlistController.createPlaylist(newPlaylist);
  }

  Future<void> getLocationAndWeather() async {
    _pos = await _determinePosition();
    location.value = await getLocationName();
    weatherModel.value = await _weatherController.getWeatherByPosition(
      lat: _pos.latitude,
      lon: _pos.longitude,
    );
    setTheme();
  }

  void setTheme() {
    var temp = weatherModel.value!.current.temp;

    if (temp <= 5) {
      _themeController.setThemeColor(AppColors.coldColor);
    } else if (temp > 5 && temp <= 17) {
      _themeController.setThemeColor(AppColors.coolColor);
    } else if (temp > 17 && temp <= 25) {
      _themeController.setThemeColor(AppColors.warmColor);
    } else {
      _themeController.setThemeColor(AppColors.hotColor);
    }
  }

  Future<String> getLocationName() async {
    Placemark placemark = Placemark();
    await placemarkFromCoordinates(_pos.latitude, _pos.longitude)
        .then((list) => placemark = list.first);

    var _location = '';
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
