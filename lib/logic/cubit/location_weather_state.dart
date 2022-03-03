part of 'location_weather_cubit.dart';

@immutable
abstract class LocationWeatherState extends Equatable {
}

class WeatherInitial extends LocationWeatherState {
  @override
  List<Object> get props => [];
}
class WeatherLoading extends LocationWeatherState {
  @override
  List<Object> get props => [];
}

class WeatherSuccess extends LocationWeatherState {
  final WeatherOutput weatherOutput;

  WeatherSuccess(this.weatherOutput);

  @override
  List<Object> get props => [weatherOutput];
}
class WeatherError extends LocationWeatherState {
  @override
  List<Object> get props => [];
}