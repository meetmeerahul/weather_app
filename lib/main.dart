import 'package:flutter/material.dart';
import 'package:weather_app/homescreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.teal,
    ),
    home: const WeatherHome(),
  ));
}
