// ignore_for_file: file_names

import 'package:geolocator/geolocator.dart';
import '../network_helper_test.dart';
import 'geolocationApi_test.dart';
import 'package:http/http.dart' as http;

class WeatherApi {

  static const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
  static const String apiKey = 'ba13cd9cbc4928bec50278b6441e3acc';

  Future<Map> getLocationWeather() async {
  Position position = await GeolocationApi(geolocator: GeolocatorPlatform.instance).currentLocationGetter;
  NetworkHelper networkHelper = NetworkHelper(
    url: '$openWeatherMapURL?lat=${position.latitude}&lon='
        '${position.longitude}&appid=$apiKey&units=metric',
    client: http.Client()
  );
  Map weatherData = await networkHelper.getData();
  return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric',
        client: http.Client()
    );
    Map weatherData = await networkHelper.getData();
    return weatherData;
  }

}