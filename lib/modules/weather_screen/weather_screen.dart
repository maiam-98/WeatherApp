
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_apps/animation/animation_route.dart';
import 'package:my_apps/models/weather_daily_model.dart';
import 'package:my_apps/models/air_quality_model.dart';
import 'package:my_apps/modules/air_quality/months.dart';
import 'package:my_apps/modules/weather_screen/cubit/cubit.dart';
import 'package:my_apps/modules/weather_screen/cubit/states.dart';

import '../../components/components.dart';
import '../../components/constants.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WeatherCubit()..getTemperatureItem(),
      child: BlocConsumer<WeatherCubit,WeatherStates>(
        listener: (context, state) => {},
        builder: (context, states)
        {
          var models = WeatherCubit.get(context).model;
          var cubit = WeatherCubit.get(context);
          dynamic counter = WeatherCubit.get(context).index;
          DateTime now = DateTime.now();
          var day = DateFormat('yyyy-MM-dd');
          String dateToday = day.format(now);
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: ()
                              {

                              },
                              child: const CircleAvatar(
                                child: Icon(
                                  Icons.multiple_stop,
                                  size: 30.0,
                                  color: Colors.black,
                                ),
                                backgroundColor: Colors.white,
                                radius: 25.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const[
                                    Icon(
                                      Icons.location_on,
                                      color: Color.fromRGBO(66, 77, 194, 1),
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      'Rome',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20.0
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                ConditionalBuilder(
                                  condition: models != null,
                                  builder: (context) =>Container(
                                  width: 95.0,
                                  height: 20.0,
                                  child: MaterialButton(
                                    onPressed: ()
                                    {
                                      WeatherCubit.get(context).chiangTemp();
                                      //index ++;
                                      print(counter);
                                    },
                                    child: const Text(
                                      'Updating*',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(247, 234, 131, 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                  fallback: (context) => const Center(child: CircularProgressIndicator()),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage:NetworkImage(
                                  'https://media.istockphoto.com/id/1319763895/photo/smiling-mixed-race-mature-man-on-grey-background.webp?s=612x612&w=is&k=20&c=5HjDAgL3XnzGObOJWVAbC9M2-mVr9LSQNiTkpmNoql4='),

                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: colorsContainer,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Positioned(
                            top: -50,
                            left: 10,
                            child: Image(
                              image: NetworkImage('https://cdn-icons-png.flaticon.com/512/1163/1163657.png'),
                              width: 180.0,
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Rain showers',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0,
                                      color: Color.fromRGBO(108, 123, 135, 1)
                                  ),
                                ),
                                  Text(
                                  '${models?.daily?.time?[counter]}',
                                    //dateToday,
                                  //'Monday, 12 Feb',
                                  style:const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Color.fromRGBO(108, 123, 135, 1)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 8,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                  '${models?.daily?.temperature_2m_max?[counter]}'.substring(0,3),
                                  //'hallo',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 70.0,
                                      color: Color.fromRGBO(108, 123, 135, 1)
                                  ),
                                ),
                                Text(
                                  '${models?.daily_units?.temperature_2m_max}',
                                  style:const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 30.0,
                                      color: Color.fromRGBO(108, 123, 135, 1)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 190.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: colorsContainer,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.wb_cloudy_outlined,
                                  color: Color.fromRGBO(215, 213, 230,1),
                                  size: 40.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const Text(
                                  'Air Quality',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(108, 123, 135, 1),
                                  ),
                                ),
                                const SizedBox(
                                  width: 120.0,
                                ),
                                Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: const Color.fromRGBO(247, 234, 131, 1),
                                  ),
                                  child: IconButton(
                                    onPressed: ()
                                    {
                                    },
                                    icon: const Icon(
                                      Icons.replay,
                                      size: 15.0,
                                      color: Colors.white,

                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            /*Container(
                              height: 120,
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, int index) => Container(
                                  height: 60,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => builderAirQualityItem(models!,index,context,cubit),
                                    separatorBuilder: (context, index) => const SizedBox(
                                      width: 25,
                                    ),
                                    itemCount: 3,
                                  ),
                                ),
                                separatorBuilder: (context, int index) => const SizedBox(
                                  height: 1,
                                ),
                                itemCount: 2,
                              ),
                            ),*/
                            Container(
                                  height: 60,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => builderAirQualityItem(models!,index,context,cubit),
                                    separatorBuilder: (context, index) => const SizedBox(
                                      width: 25,
                                    ),
                                    itemCount: 3,
                                  ),
                                ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                                  height: 50,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => builderAirQualityItem(models!,index,context,cubit),
                                    separatorBuilder: (context, index) => const SizedBox(
                                      width: 25,
                                    ),
                                    itemCount: 3,
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Weekly forecast',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                        const SizedBox(
                          width: 65.0,
                        ),
                        GestureDetector(
                          onTap: ()
                          {
                            Navigator.of(context).push(SlideRoute(page: const MonthScreen()));
                          },
                          child: Row(
                              children:const[
                                Text(
                                  'Next Month',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(198, 195, 227,1)
                                  ),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  color: Color.fromRGBO(198, 195, 227,1),
                                ),
                              ]


                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 200.0,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context, index) => builderWeeklyForecastItem(
                            index: index,
                            dateToday: dateToday,
                            text: 'Today',
                            ifForTextTime: models?.daily?.time?[index],
                            ifForTextTemp: models?.daily?.temperature_2m_max?[index],
                            textIf: WeatherCubit.get(context).days![index].substring(0,3),
                            color: models?.daily?.time?[index] == dateToday ? colorsContainer : const Color.fromRGBO(114, 116, 129,1),
                          ),
                          separatorBuilder: (context, index) =>const SizedBox(
                            width: 30.0,
                          ),
                          itemCount:7
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      )
    );

  }



  Widget builderAirQualityItem(DailyModel model,index, context, WeatherCubit cubit) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(
        Icons.sunny,
        color: Color.fromRGBO(247, 234, 131,1),
        size: 25.0,
      ),
      const SizedBox(
        width: 5.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${cubit.airQuality?[index]}',
            style:const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(108, 123, 135, 1),
            ),
          ),
          Text(
            '${model.daily?.rain_sum?[index]}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ],
  );
  /*Widget builderWeeklyForecastItem(DailyModel model, counter, int index,context, String dateToday) => GestureDetector(
    child: Container(
      height: 200.0,
      width: 65.0,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: model.daily?.time?[index] == dateToday ? colorsContainer : const Color.fromRGBO(114, 116, 129,1) ,

      ),
      child: Column(
        children: [
          if(model.daily?.time?[index] == dateToday)...[
            const Text(
              'Today',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]else...[
             Text(
              WeatherCubit.get(context).days![index].substring(0,3),
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
           const SizedBox(
             height: 5.0,
           ),
           Text(
            '${model.daily?.time?[index]}'.substring(6),
            style:  TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color:model.daily?.time?[index] == dateToday ? const Color.fromRGBO(108, 123, 135, 1) : Colors.black ,
            ),
          ),
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
            '${model.daily?.temperature_2m_max?[index]}'.substring(0,2),
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
            width: 60.0,
            height: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: const Color.fromRGBO(247, 234, 131, 1),
            ),
            child: MaterialButton(
              onPressed: (){},
              child: const Text(
                '150',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    onTap: ()
    {
      //Navigator.push(context,MaterialPageRoute(builder:(context)=>const MonthScreen()));
    },
  );*/
}
