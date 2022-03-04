import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/model/weather_output.dart';
import '../../data/repositories/weather_repository_test.dart';

part 'city_weather_state.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit() : super(CityWeatherInitial());

  void getCityWeather(String cityName) async {
    try {
      emit(CityWeatherLoading());
      WeatherOutput weatherOutput = await WeatherRepo().cityWeatherGetter(cityName);
      emit(CityWeatherSuccess(weatherOutput));
    } catch (e) {
      emit(CityWeatherError());
    }
  }
}
