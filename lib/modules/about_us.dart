import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MenuWidget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          leading: const MenuWidget(),
        ),
        body: const Center(child: Text('About Us Page'))
    );
  }
}
