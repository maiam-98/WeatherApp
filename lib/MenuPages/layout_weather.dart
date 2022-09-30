import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:my_apps/MenuPages/MenuPage.dart';
import 'package:my_apps/modules/about_app.dart';
import 'package:my_apps/modules/about_us.dart';
import 'package:my_apps/modules/report.dart';
import 'package:my_apps/modules/weather_screen/weather_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  MenuItemit currentItem = MenuItems.mainScreen;

  @override
  Widget build(BuildContext context) => ZoomDrawer (
    mainScreenScale: 0.2,
    borderRadius: 40,
    angle: -1,
    menuScreenWidth: double.infinity,
    slideWidth: MediaQuery.of(context).size.width * 0.5,
    mainScreen:  getScreen(),
    menuScreen:  Builder(
      builder: (context) => MenuPage(
        onSelectedItem: (MenuItemit value) {
          setState(() => currentItem = value);

          ZoomDrawer.of(context)?.close();
        },
        currentItem: currentItem,
      ),
    ),
  );
  Widget getScreen() {
    switch (currentItem){
      case MenuItems.mainScreen:
        return const WeatherScreen();

      case MenuItems.aboutApp:
        return const AboutAppScreen();

      case MenuItems.aboutUs:
        return const AboutUsScreen();

      default:
        return const ReportScreen();
    }
  }
}

