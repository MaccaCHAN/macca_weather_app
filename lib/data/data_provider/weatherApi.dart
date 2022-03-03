// ignore_for_file: file_names

import 'package:geolocator/geolocator.dart';
import '../network_helper.dart';
import 'geolocationApi.dart';

class WeatherApi {

  static const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
  static const String apiKey = 'ba13cd9cbc4928bec50278b6441e3acc';

  Future<Map> getLocationWeather() async {
  Position position = await GeolocationApi().currentLocationGetter;
  NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapURL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric');
  Map weatherData = await networkHelper.getData();
  return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    Map weatherData = await networkHelper.getData();
    return weatherData;
  }

}