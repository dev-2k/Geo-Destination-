import 'package:flutter/material.dart';
import 'detailPage.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ListView(
          children: [
            Text('data'),
          ],
        ),
      ),
    );
  }
}
