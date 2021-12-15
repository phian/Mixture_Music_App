import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../../constants/app_text_style.dart';
import '../../../models/weather/current_weather_model.dart';
import '../../../models/weather/daily_weather_model.dart';
import '../../../models/weather/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    Key? key,
    required this.weatherResponse,
    required this.location,
  }) : super(key: key);

  final WeatherModel weatherResponse;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationInfor(
          current: weatherResponse.current,
          location: location,
        ),
        SizedBox(
          height: 240,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            children: [
              CurrentWeather(
                current: weatherResponse.current,
              ),
              const SizedBox(width: 16),
              DailyWeather(
                isToday: true,
                daily: weatherResponse.daily[0],
              ),
              const SizedBox(width: 16),
              DailyWeather(
                daily: weatherResponse.daily[1],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LocationInfor extends StatelessWidget {
  const LocationInfor({
    Key? key,
    required this.current,
    required this.location,
  }) : super(key: key);

  final CurrentWeatherModel current;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            current.weather[0].description,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            'In $location',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    Key? key,
    required this.current,
  }) : super(key: key);

  final CurrentWeatherModel current;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Right Now:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  BoxedIcon(
                    WeatherIcons.fromString(
                      current.weather[0].getIconName(),
                      fallback: WeatherIcons.na,
                    ),
                    size: 70,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const Spacer(),
                  Text(
                    '${current.temp.round()}°',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontName,
                      fontSize: 62,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Text(
                'Pressure: ${current.pressure} hPa',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                'Humidity: ${current.humidity}%',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                'Wind: ${current.windSpeed} mps',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyWeather extends StatelessWidget {
  const DailyWeather({
    Key? key,
    required this.daily,
    this.isToday = false,
  }) : super(key: key);

  final bool isToday;
  final DailyWeatherModel daily;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isToday ? 'Today:' : 'Tomorrow:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMM d').format(
                      DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000),
                    ),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const Spacer(),
                  BoxedIcon(
                    WeatherIcons.fromString(
                      daily.weather[0].getIconName(),
                      fallback: WeatherIcons.na,
                    ),
                    size: 36,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
              Text(
                daily.weather[0].description,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  '${daily.temp.max.round()}°',
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  '${daily.temp.min.round()}°',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
