import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/weather/current_weather_model.dart';
import '../../../models/weather/daily_weather_model.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_style.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../../models/weather/weather_model.dart';

class WeatherInfor extends StatelessWidget {
  const WeatherInfor({
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
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.horizontal,
            children: [
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
  final DailyWeatherModel daily;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(3, 3),
          ),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isToday ? 'Today:' : 'Tomorrow:',
            style: Theme.of(context).textTheme.caption,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('MMM d').format(
                  DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000),
                ),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Spacer(),
              BoxedIcon(
                WeatherIcons.fromString(
                  daily.weather[0].getIconName(),
                  fallback: WeatherIcons.na,
                ),
                size: 36,
                // TODO: sửa theo theme
                color: AppColors.captionTextColor,
              ),
            ],
          ),
          Text(
            daily.weather[0].description,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Spacer(),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '${daily.temp.max.round()}°',
              style: TextStyle(
                fontSize: 30,
                // TODO: sửa theo theme
                color: AppColors.captionTextColor,
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
                // TODO: sửa theo theme
                color: AppColors.subTextColor,
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

  final CurrentWeatherModel current;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(3, 3),
          ),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Right Now:',
            style: Theme.of(context).textTheme.caption,
          ),
          Row(
            children: [
              BoxedIcon(
                WeatherIcons.fromString(
                  current.weather[0].getIconName(),
                  fallback: WeatherIcons.na,
                ),
                size: 70,
                // TODO: sửa theo theme
                color: AppColors.captionTextColor,
              ),
              Spacer(),
              Text(
                '${current.temp.round()}°',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontName,
                  fontSize: 62,
                  fontWeight: FontWeight.bold,
                  // TODO: sửa theo theme
                  color: AppColors.captionTextColor,
                ),
              ),
            ],
          ),
          Text(
            'Pressure: ${current.pressure} hPa',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            'Humidity: ${current.humidity}%',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            'Wind: ${current.windSpeed} mps',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
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
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            'In $location',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 16),
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
              SizedBox(width: 5),
              Container(
                height: 3,
                width: 3,
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