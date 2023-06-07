import 'package:flutter/material.dart';
import 'homescreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.teal,
    ),
    home: WeatherHome(),
  ));
}
