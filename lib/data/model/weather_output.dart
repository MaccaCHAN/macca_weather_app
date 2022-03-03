class WeatherOutput {
  Map weatherData;

  WeatherOutput(this.weatherData);

  String get cityNameGetter {
    String cityName = weatherData['name'];
    return cityName;
  }

  int get tempGetter {
    num tempNum = weatherData['main']['temp'];
    int temp = tempNum.round();
    return temp;
  }

  int get humidityGetter {
    num humidityNum = weatherData['main']['humidity'];
    int humidity = humidityNum.toInt();
    return humidity;
  }

  double get windSpeedGetter {
    num windSpeedNum = weatherData['wind']['speed'];
    double windSpeed = windSpeedNum.toDouble();
    return windSpeed;
  }
}