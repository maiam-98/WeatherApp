
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../modules/weather_screen/cubit/cubit.dart';
import 'constants.dart';


var cubit = WeatherCubit();
var models = cubit.model;
dynamic counter = cubit.index;
DateTime now = DateTime.now();
var day = DateFormat('yyyy-MM-dd');
String dateToday = day.format(now);

Widget builderWeeklyForecastItem(
    {
      dynamic index,
      required String text,
      required String textIf,
      required dynamic ifForTextTime,
      required dynamic ifForTextTemp,
      required String? dateToday,
      required Color? colorOfAir,
      required List<Color> colors,
      required String? testOfAir,
}) => Container(
      //height: 200.0,
      width: 65.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
           stops: const [
            0.3,
            1
          ],
          colors: colors,
        ),
      ),
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if(ifForTextTime == dateToday )...[
               Text(
                text,
                style:const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]else...[
              Text(
                textIf,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(
              height: 5.0,
            ),
            if(textIf == WeatherCubit().month?[index])...[
              Text(
              '$ifForTextTime'.substring(6,7),
              style:const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            ]else...[
              Text(
                '$ifForTextTime'.substring(5),
                style:  TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color:ifForTextTime == dateToday ? Colors.white : const Color.fromRGBO(158, 153, 153, 1) ,
                ),
              ),
            ],
            const SizedBox(
              height: 10.0,
            ),
            const Image(
                  image: NetworkImage('https://cdn-icons-png.flaticon.com/512/2698/2698194.png'),
                  width: 55.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              '$ifForTextTemp'.substring(0,3),
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              width: 45.0,
              height: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45.0),
                color: const Color.fromRGBO(37, 109, 133, 1),
              ),
              child: Container(
                height: 30,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: colorOfAir,
                ),
              child: Center(
                child:  Text(
                  '$testOfAir',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );