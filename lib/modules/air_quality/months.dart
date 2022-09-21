import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_apps/animation/animation_route.dart';
import 'package:my_apps/modules/air_quality/cubit.dart';
import 'package:my_apps/modules/air_quality/states.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../sheard/components/components.dart';
import '../weather_screen/cubit/cubit.dart';
import '../weather_screen/weather_screen.dart';

class MonthScreen extends StatelessWidget {
  const MonthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AirQualityCubit,AirQualityStates>(
      listener: (context, state) => {},
      builder: (context, state)
      {
        var models = AirQualityCubit.get(context).airQualityModel;
        var modelsForWeather = WeatherCubit.get(context).model;
        var cubit = AirQualityCubit.get(context);
        DateTime now = DateTime.now();
        var days = DateFormat('yyyy-MM-dd');
        String dateToday = days.format(now);
        var hours = DateFormat('yyyy-MM-ddThh:00');
        String hoursToday = hours.format(now);
        var scaffoldKey = GlobalKey<ScaffoldState>();
        var isSelected = AirQualityCubit.get(context).isSelected;
        var showFirst = cubit.showFirst ;
        var pm2 = models?.hourly?.pm2_5?[cubit.indexes];
        return  Scaffold(
          key: scaffoldKey,
          body: ConditionalBuilder(
            condition: models != null,
            builder: (BuildContext context) =>SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 420,
                    decoration:const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50.0),
                            bottomLeft: Radius.circular(50.0)
                        ),
                        color: Colors.white
                    ),
                    child: SingleChildScrollView(
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
                                        Navigator.of(context).pop(SlideRoute(page:const WeatherScreen()));
                                      },
                                      child: const CircleAvatar(
                                        child: Icon(
                                          Icons.navigate_before,
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
                                            Text(
                                              'Air Quality',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20.0
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),

                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: ()
                                      {
                                        cubit.formulaAQI(pm2);
                                      },
                                      child:const CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage:NetworkImage(
                                            'https://media.istockphoto.com/id/1319763895/photo/smiling-mixed-race-mature-man-on-grey-background.webp?s=612x612&w=is&k=20&c=5HjDAgL3XnzGObOJWVAbC9M2-mVr9LSQNiTkpmNoql4='),

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) =>
                                  Center(
                                    child: Container(
                                      width: 250,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50.0),
                                        color: const Color.fromRGBO(37, 109, 133, 1),
                                      ),
                                      child: Center(
                                        child: ToggleButtons(
                                          constraints: BoxConstraints.expand(width: constraints.maxWidth/3),
                                          isSelected: isSelected,
                                          fillColor: Colors.white,
                                          selectedColor: Colors.black,
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(50.0),
                                          renderBorder: false,
                                          children: const <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'Day',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Month',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ],
                                          onPressed: (newIndex)
                                          {
                                            cubit.chiangMonthDay(newIndex);

                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: models != null,
                              builder:(context) => AnimatedCrossFade(
                                firstChild: SizedBox(
                                  height: 200.0,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:(context, index) => builderWeeklyForecastItem(
                                        testOfAir: '${cubit.resultAQI}',
                                        colorOfAir: cubit.getColors(cubit.resultAQI),
                                        index: index,
                                        dateToday: dateToday,
                                        text: 'Today',
                                        ifForTextTime: modelsForWeather?.daily?.time?[index],
                                        ifForTextTemp: models?.hourly?.pm2_5?[index],
                                        textIf: WeatherCubit.get(context).days![index].substring(0,3),
                                        color: modelsForWeather?.daily?.time?[index] == dateToday ? const Color.fromRGBO(37, 109, 133, 1) :  Colors.white,
                                      ),
                                      separatorBuilder: (context, index) =>const SizedBox(
                                        width: 30.0,
                                      ),
                                      itemCount:5
                                  ),
                                ),
                                secondChild: SizedBox(
                                  height: 200.0,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:(context, index) => builderWeeklyForecastItem(
                                        testOfAir: '${cubit.resultAQI}',
                                        colorOfAir: cubit.getColors(cubit.resultAQI),
                                        index: index,
                                        dateToday: dateToday,
                                        text: 'Sep',
                                        ifForTextTime: models?.hourly?.time?[index],
                                        ifForTextTemp: models?.hourly?.uv_index?[index],
                                        textIf: WeatherCubit.get(context).month![index].substring(0,3),
                                        color: modelsForWeather?.daily?.time?[index] == dateToday ? const Color.fromRGBO(37, 109, 133, 1) :  Colors.white,
                                      ),
                                      separatorBuilder: (context, index) =>const SizedBox(
                                        width: 30.0,
                                      ),
                                      itemCount:7
                                  ),
                                ),
                                duration: const Duration(seconds: 2),
                                crossFadeState: showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,

                              ),
                              fallback: (context) => const Center(child: CircularProgressIndicator.adaptive()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SfRadialGauge(
                    axes: [
                      RadialAxis(
                        maximum: 500,
                        minimum: 0,
                        tickOffset: 15,
                        majorTickStyle:const MajorTickStyle(
                            length: .5,
                            thickness: 10,
                            color: Colors.white
                        ),
                        minorTickStyle: const MinorTickStyle(
                            length: .5,
                            thickness: 10,
                            color: Colors.white
                        ),
                        minorTicksPerInterval: 4.0,
                        axisLineStyle: const AxisLineStyle(
                          cornerStyle: CornerStyle.bothCurve,
                        ),
                        showLabels: false,
                        ranges:  <GaugeRange>[
                          GaugeRange(
                            startValue: 0,
                            endValue: 500,
                            startWidth: 18,
                            color: Colors.grey,
                            endWidth: 18,
                          )
                        ],
                        pointers:  <GaugePointer>[
                          RangePointer(
                            value: cubit.formulaAQI(pm2)!.toDouble(),
                            cornerStyle: CornerStyle.bothCurve,
                            width: 18,
                            color: const Color.fromRGBO(37, 109, 133, 1),
                          ),
                          NeedlePointer(
                            value: cubit.formulaAQI(pm2)!.toDouble(),
                            needleStartWidth: 1.5,
                            needleEndWidth: 1.5,
                            needleColor: const  Color.fromRGBO(37, 109, 133, 1),
                            knobStyle: const  KnobStyle(
                              borderColor: Color.fromRGBO(37, 109, 133, 1),
                              borderWidth: 0.03,
                              color: Colors.white,
                            ),
                            tailStyle: const TailStyle(
                                width: 1.5,
                                length: 0.2,
                                color: Color.fromRGBO(37, 109, 133, 1)

                            ),
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(widget:
                          Column(
                            children: [
                              const Text(
                                'AQI',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                                Text(
                                  '${cubit.formulaAQI(pm2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 70.0,
                                  ),
                                ),
                              ]
                          ),
                            angle: 90,
                            positionFactor: 1.4,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      {
                        scaffoldKey.currentState?.showBottomSheet((context) =>
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.05),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap:() {
                                      Navigator.pop(context);
                                      print(hoursToday);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: const Color.fromRGBO(37, 109, 133, 1),
                                      ),
                                      child: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 40,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(60.0),
                                            color: cubit.getColors(cubit.resultAQI),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${cubit.resultAQI}',
                                              style:const TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${cubit.text}',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            )
                        );
                      }
                      print(cubit.resultAQI);
                    },
                    child: Container(
                      height: 65,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(37, 109, 133, 1),
                      ),
                      child: Row(
                        children: const[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.0,
                              child: Icon(
                                Icons.highlight_off_sharp,
                                color: Color.fromRGBO(37, 109, 133, 1),
                                size: 35,
                              ),
                            ),
                          ),
                          Text(
                            'City air quality ranking',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(
                            width: 35.0,
                          ),
                          Text(
                            'No.531',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.black,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            fallback: (BuildContext context) => const Center(child: CircularProgressIndicator.adaptive()),
          ),

        );
      },
    );
  }
}


