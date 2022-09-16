import 'package:flutter/cupertino.dart';

class SlideRoute extends PageRouteBuilder
{
  final page;
  SlideRoute({this.page}) : super(
    pageBuilder: (context, animation, animationTwo) => page,
    transitionsBuilder: (context, animation, animationTwo,child)
    {
     var begin = const Offset(1, 0);
     var end = const Offset(0,0);
     var tween = Tween(begin: begin, end: end);
     var curvesAnimation = CurvedAnimation(parent: animation, curve: Curves.slowMiddle);
     return SlideTransition(position:tween.animate(curvesAnimation),child: child,);
    }
  );
}