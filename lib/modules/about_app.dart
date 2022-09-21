import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MenuWidget.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: const MenuWidget(),
      ),
        body: const Center(child: Text('About App Page'))

    );
  }
}
