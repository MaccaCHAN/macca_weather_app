import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macca_weather_app/logic/cubit/city_weather_cubit.dart';
import 'package:macca_weather_app/logic/cubit/text_field_cubit.dart';
import 'package:macca_weather_app/logic/cubit/location_weather_cubit.dart';
import 'package:macca_weather_app/presentation/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Set the design size for ScreenUtil package that makes the UI adaptive to different screen sizes
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: () =>
      ///Wrap with multiBlocProvider for state management
          MultiBlocProvider(
            providers: [
              BlocProvider<LocationWeatherCubit>(
                create: (context) => LocationWeatherCubit()
              ),
              BlocProvider<CityWeatherCubit>(
                create: (context) => CityWeatherCubit(),
              ),
              BlocProvider<TextFieldCubit>(
                  create: (context) => TextFieldCubit(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: GoogleFonts.nunito().fontFamily
              ),
              home: MainScreen(),
            ),
          ),
    );
  }
}


