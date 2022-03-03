import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class ReusableWeatherCard extends StatelessWidget {
  const ReusableWeatherCard({
    Key? key,
    required this.humidity,
    required this.temp,
    required this.windSpeed
  }) : super(key: key);

  final int temp;
  final double windSpeed;
  final int humidity;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 0.85.sw,
        height: 0.1.sh,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),
          color: const Color(0xffffffff).withOpacity(0.7),
        ),
        child: Row(children: [
          // Temp with Text autosizing with the Expanded widget on the left
          Expanded(flex: 7,
              child: FittedBox(child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text('$temp°C', style: GoogleFonts.nunito()),
              ),
              )),
          // Column wrapping 2 rows of weather data in the Expanded widget on the right
          Expanded(flex: 4,
              child: Align(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //humidity row
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r),
                                color: const Color(0xff808080).withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset('images/water-drop.png', height: 25.h),
                              )),
                          SizedBox(width: 5.w,),
                          Text('$humidity%', style: TextStyle(fontSize: 20.h),)
                        ]),
                    SizedBox(height: 8.h),
                    //wind speed row
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [

                              Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r),
                                    color: const Color(0xff808080).withOpacity(0.2),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.asset('images/wind_icon.png', height: 25.h),
                                  )),
                            ],
                          ),
                          SizedBox(width: 5.w),
                          Text('${windSpeed}m/s', style: TextStyle(fontSize: 20.h))
                        ])
                  ]
              ))),

        ]
        )
    );
  }
}
