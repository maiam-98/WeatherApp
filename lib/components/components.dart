
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weather_daily_model.dart';
import '../modules/weather_screen/cubit/cubit.dart';
import 'constants.dart';


var cubit = WeatherCubit();
Widget builderWeeklyForecastItem(
    {
      dynamic index,
      required Color color,
      required String text,
      required String textIf,
      required dynamic ifForTextTime,
      required dynamic ifForTextTemp,
      required String? dateToday,
}) => Container(
      //height: 200.0,
      width: 65.0,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,

      ),
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
            style:  TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color:ifForTextTime == dateToday ? const Color.fromRGBO(108, 123, 135, 1) : Colors.black ,
            ),
          ),
          ]else...[
            Text(
              '$ifForTextTime'.substring(6),
              style:  TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color:ifForTextTime == dateToday ? const Color.fromRGBO(108, 123, 135, 1) : Colors.black ,
              ),
            ),
          ],
          const SizedBox(
            height: 10.0,
          ),
          const Icon(
            Icons.sunny,
            size: 50.0,
            color: Color.fromRGBO(217, 214, 72, 1),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            '$ifForTextTemp'.substring(0,2),
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
              color: const Color.fromRGBO(247, 234, 131, 1),
            ),
            child: const Center(
              child: Text(
                '150',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );