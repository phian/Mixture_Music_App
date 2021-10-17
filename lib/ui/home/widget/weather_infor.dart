import 'package:flutter/material.dart';
import 'package:mixture_music_app/models/weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

import '../../../constants/theme.dart';

class WeatherInfor extends StatelessWidget {
  const WeatherInfor({
    Key? key,
    required this.weatherResponse,
    required this.location,
  }) : super(key: key);

  final WeatherResponse weatherResponse;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationInfo(
          current: weatherResponse.current,
          location: location,
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 240,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: const EdgeInsets.symmetric(vertical: 10),
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(width: 16),
              CurrentWeather(
                current: weatherResponse.current,
              ),
              SizedBox(width: 16),
              DailyWeather(
                isToday: true,
                daily: weatherResponse.daily[0],
              ),
              SizedBox(width: 16),
              DailyWeather(
                daily: weatherResponse.daily[1],
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class DailyWeather extends StatelessWidget {
  const DailyWeather({
    Key? key,
    required this.daily,
    this.isToday = false,
  }) : super(key: key);

  final isToday;
  final Daily daily;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(3, 3),
          ),
        ],
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isToday ? 'Today:' : 'Tomorrow:',
            style: AppTheme.caption,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('MMM d').format(
                  DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000),
                ),
                style: AppTheme.subText,
              ),
              Spacer(),
              BoxedIcon(
                WeatherIcons.fromString(
                  daily.weather[0].getIconName(),
                  fallback: WeatherIcons.na,
                ),
                size: 36,
              ),
            ],
          ),
          Text(
            daily.weather[0].description,
            style: AppTheme.subText,
          ),
          Spacer(),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '${daily.temp.max.round()}°',
              style: TextStyle(
                fontSize: 30,
                color: AppTheme.brightGrey,
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
                color: AppTheme.subTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
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

  final Current current;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(3, 3),
          ),
        ],
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Right Now:',
            style: AppTheme.caption,
          ),
          Row(
            children: [
              BoxedIcon(
                WeatherIcons.fromString(
                  current.weather[0].getIconName(),
                  fallback: WeatherIcons.na,
                ),
                size: 70,
                color: AppTheme.brightGrey,
              ),
              Spacer(),
              Text(
                '${current.temp.round()}°',
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 62,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.brightGrey,
                ),
              ),
            ],
          ),
          Text(
            'Pressure: ${current.pressure} hPa',
            style: AppTheme.subText,
          ),
          Text(
            'Humidity: ${current.humidity}%',
            style: AppTheme.subText,
          ),
          Text(
            'Wind: ${current.windSpeed} mps',
            style: AppTheme.subText,
          ),
        ],
      ),
    );
  }
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    Key? key,
    required this.current,
    required this.location,
  }) : super(key: key);

  final Current current;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            current.weather[0].description,
            style: AppTheme.h4,
          ),
          Text(
            'In $location',
            style: AppTheme.h5,
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppTheme.primaryColor,
                ),
              ),
              SizedBox(width: 5),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppTheme.primaryColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
