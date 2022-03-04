import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macca_weather_app/logic/cubit/text_field_cubit.dart';
import '../../data/model/weather_output.dart';
import '../../logic/cubit/city_weather_cubit_test.dart';
import '../../logic/cubit/location_weather_cubit_test.dart';
import '../components/reusable_text_card.dart';
import '../components/reusable_weather_card.dart';
import '../constants.dart';

// ignore_for_file: prefer_const_constructors

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {FocusManager.instance.primaryFocus?.unfocus();},
        ///  ensure the System Ui is visible by turning it to light
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/sunset_background.jpg'),
            )),
            child: SafeArea(
              /// use layoutBuilder to get constraints of safeArea,
              /// so singleChildScrollView can use the constraints
              child: LayoutBuilder(
                builder: (context, constraints) =>
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        ///ConstrainedBox to provide maxHeight for column, and its height adjusts when
                        ///keyboard pops up
                        constraints: BoxConstraints(maxHeight: constraints.maxHeight - keyboardHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: double.infinity),
                            Spacer(flex: 2),
                            /// Location Weather Card
                            BlocBuilder<LocationWeatherCubit, LocationWeatherState>(
                              builder: (context, state) {
                                if (state is WeatherLoading) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (state is WeatherSuccess) {
                                  WeatherOutput weatherOutput = state.weatherOutput;
                                  return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        /// City Name Row
                                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                          Icon(Icons.location_on, color: Colors.white, size: 20.h),
                                          SizedBox(width: 10.w),
                                          Text(weatherOutput.cityNameGetter,
                                              style: TextStyle(color: Colors.white, fontSize: 20.h))
                                        ]),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        /// weather card with details
                                        ReusableWeatherCard(
                                          temp: weatherOutput.tempGetter,
                                          humidity: weatherOutput.humidityGetter,
                                          windSpeed: weatherOutput.windSpeedGetter,
                                        ),
                                      ]);
                                } else if (state is WeatherError) {
                                  return ReusableTextCard(
                                      widget: Text('Something is wrong!',
                                          style: TextStyle(fontSize: 20.h, color: Colors.red)));
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),

                            Spacer(flex: 2),
                            /// city weather card with textField for input city name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.location_city,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 0.8.sw,
                                  child: TextField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: kTextFieldDecoration,
                                      onChanged: (entry) {
                                        BlocProvider.of<TextFieldCubit>(context).textChange(entry);
                                      }),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                                onPressed: () {
                                  String newCityName = BlocProvider.of<TextFieldCubit>(context).state.inputText;
                                  print('new city name: $newCityName');
                                  BlocProvider.of<CityWeatherCubit>(context).getCityWeather(newCityName);
                                },
                                child: Text(
                                  'Get City Weather',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            BlocBuilder<CityWeatherCubit, CityWeatherState>(builder: (context, state) {
                              if(state is CityWeatherInitial) {
                                return ReusableTextCard(
                                    widget: Text('Get weather of any city in the world!',
                                        style: TextStyle(fontSize: 20.h))
                                );
                              }
                              if (state is CityWeatherLoading) {
                                return Center(child: CircularProgressIndicator());
                              } else if (state is CityWeatherSuccess) {
                                WeatherOutput weatherOutput = state.weatherOutput;
                                print(weatherOutput);

                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // City Name Row
                                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Icon(Icons.location_on, color: Colors.white, size: 20.h),
                                        SizedBox(width: 10.w),
                                        Text(weatherOutput.cityNameGetter,
                                            style: TextStyle(color: Colors.white, fontSize: 20.h))
                                      ]),
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      // weather detail box
                                      ReusableWeatherCard(
                                        temp: weatherOutput.tempGetter,
                                        humidity: weatherOutput.humidityGetter,
                                        windSpeed: weatherOutput.windSpeedGetter,
                                      ),
                                    ]);
                              } else if (state is CityWeatherError) {
                                return ReusableTextCard(
                                    widget: Text('Something is wrong!',
                                        style: TextStyle(fontSize: 20.h, color: Colors.red)));
                              } else {
                                return SizedBox();
                              }
                            }),
                            Spacer(flex: 2),
                          ],
                        ),
                      ),

                    )
              )
              ),
          ),
        ),
      ),
    );
  }
}



