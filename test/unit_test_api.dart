import 'package:flutter_test/flutter_test.dart';
import 'package:macca_weather_app/data/data_provider/weatherApi.dart';

void main() {
  group('Weather API weatherData items type test', () {
    test('Weather API gets city name correctly', () async {
      var weatherData = await WeatherApi().getCityWeather('HongKong');
      var cityName = weatherData['name'];
      expect(cityName == 'Hong Kong', true);
    });
    test('Weather API gets humidity as int', () async {
      var weatherData = await WeatherApi().getCityWeather('HongKong');
      var humidity = weatherData['main']['humidity'];
      expect(humidity.runtimeType == int, true);
    });
    test('Weather API gets temp as double', () async {
      var weatherData = await WeatherApi().getCityWeather('HongKong');
      var temp = weatherData['main']['temp'];
      expect(temp.runtimeType == double, true);
    });
    test('Weather API gets windSpeed as double', () async {
      var weatherData = await WeatherApi().getCityWeather('HongKong');
      var windSpeed = weatherData['wind']['speed'];
      expect(windSpeed.runtimeType == double, true);
    });

  });

  

}
