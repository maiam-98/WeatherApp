import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_apps/animation/animation_route.dart';
import 'package:my_apps/modules/weather_screen/cubit/cubit.dart';
import 'package:my_apps/modules/weather_screen/cubit/states.dart';
import 'package:my_apps/modules/weather_screen/weather_screen.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../models/weather_daily_model.dart';

class MonthScreen extends StatelessWidget {
  const MonthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..getTemperatureItem(),
      child: BlocConsumer<WeatherCubit,WeatherStates>(
        listener: (context, state) => {},
        builder: (context, state)
        {
          var models = WeatherCubit.get(context).model;
          var cubit = WeatherCubit.get(context);
          DateTime now = DateTime.now();
          var days = DateFormat('yyyy-MM-dd');
          String dateToday = days.format(now);
          var scaffoldKey = GlobalKey<ScaffoldState>();
          var isSelected = WeatherCubit.get(context).isSelected;
          bool isBottomSheetShow = false;
          var showFirst = cubit.showFirst ;
          return  Scaffold(
            key: scaffoldKey,
            body: SingleChildScrollView(
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
                                            color: Colors.grey,
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
                                AnimatedCrossFade(
                                  firstChild: SizedBox(
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
                                          color: models?.daily?.time?[index] == dateToday ? colorsContainer :  Colors.white,
                                        ),
                                        separatorBuilder: (context, index) =>const SizedBox(
                                          width: 30.0,
                                        ),
                                        itemCount:7
                                    ),
                                  ),
                                  secondChild: SizedBox(
                                    height: 200.0,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:(context, index) => builderWeeklyForecastItem(
                                          index: index,
                                          dateToday: dateToday,
                                          text: 'Sep',
                                          ifForTextTime: models?.daily?.time?[index],
                                          ifForTextTemp: models?.daily?.temperature_2m_max?[index],
                                          textIf: WeatherCubit.get(context).month![index],
                                          color: models?.daily?.time?[index] == dateToday ? colorsContainer :  Colors.white,
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
                            color: Colors.white,
                            endWidth: 18,
                          )
                        ],
                        pointers: const <GaugePointer>[
                          RangePointer(
                            value: 300.0,
                            cornerStyle: CornerStyle.bothCurve,
                            width: 18,
                            color: Color.fromRGBO(247, 234, 131, 1),
                          ),
                          NeedlePointer(
                            value: 300,
                            needleStartWidth: 1.5,
                            needleEndWidth: 1.5,
                            needleColor: Color.fromRGBO(247, 234, 131, 1),
                            knobStyle: KnobStyle(
                              borderColor: Color.fromRGBO(247, 234, 131, 1),
                              borderWidth: 0.03,
                              color: Colors.white,
                            ),
                            tailStyle: TailStyle(
                              width: 1.5,
                              length: 0.2,
                              color: Colors.yellowAccent

                            ),
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(widget:
                          Column(
                            children: const[
                              Text(
                                'AQI',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                              Text(
                                '250',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 70.0,
                                ),
                              ),
                            ],
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
                      if(isBottomSheetShow){
                        Navigator.pop(context);
                        isBottomSheetShow = false;
                      }else{
                         scaffoldKey.currentState?.showBottomSheet((context) =>
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          TextFormField(

                          ),
                          ],
                        )
                         );
                        isBottomSheetShow = true;
                      }
                    },
                    child: Container(
                      height: 65,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(247, 234, 131, 1),
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
                                color: Color.fromRGBO(247, 234, 131, 1),
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

          );
        },
      ),
    );
  }
}


