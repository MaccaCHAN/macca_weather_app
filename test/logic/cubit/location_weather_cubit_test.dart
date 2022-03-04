import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../data/model/weather_output.dart';
import '../../data/repositories/weather_repository_test.dart';

part 'location_weather_state.dart';

class LocationWeatherCubit extends Cubit<LocationWeatherState> {
  LocationWeatherCubit() : super(WeatherInitial()) {
    getLocationWeather();
  }

  void getLocationWeather() async {
    try {
      emit(WeatherLoading());
      WeatherOutput weatherOutput = await WeatherRepo().locationWeatherGetter;
      emit(WeatherSuccess(weatherOutput));
    } catch (e) {
      emit(WeatherError());
    }
  }

}
