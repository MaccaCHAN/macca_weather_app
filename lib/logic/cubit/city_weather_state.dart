part of 'city_weather_cubit.dart';

@immutable
abstract class CityWeatherState extends Equatable{}

class CityWeatherInitial extends CityWeatherState {
  @override
  List<Object> get props => [];
}
class CityWeatherLoading extends CityWeatherState {
  @override
  List<Object> get props => [];
}

class CityWeatherSuccess extends CityWeatherState {
  final WeatherOutput weatherOutput;

  CityWeatherSuccess(this.weatherOutput);

  @override
  List<Object> get props => [weatherOutput];
}
class CityWeatherError extends CityWeatherState {
  @override
  List<Object> get props => [];
}
