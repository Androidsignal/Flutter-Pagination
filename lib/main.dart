import 'package:flutter/material.dart';
import 'package:google_maps/pagination/HomePage.dart';
import 'package:google_maps/timer_notification/TimerListNotification.dart';

import 'put_marker_in_map/LatLongModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

