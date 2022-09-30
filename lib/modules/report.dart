import 'package:flutter/material.dart';

import '../MenuPages/MenuWidget.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: const MenuWidget(),
      ),
      body: const Center(child: Text('Report Page')),
    );
  }
}
