import '../data_provider/weatherApi.dart';
import '../model/weather_output.dart';

///WeatherRepo to connect data provider (APIs) to logic layer (cubits)
class WeatherRepo {

  Future<WeatherOutput> get locationWeatherGetter async {
    WeatherOutput weatherOutput;

    Map weatherData = await WeatherApi().getLocationWeather();
    weatherOutput = WeatherOutput(weatherData);
    return weatherOutput;
  }

  Future<WeatherOutput> cityWeatherGetter (String cityName) async {
    WeatherOutput weatherOutput;

    Map weatherData = await WeatherApi().getCityWeather(cityName);
    weatherOutput = WeatherOutput(weatherData);
    return weatherOutput;
  }
}