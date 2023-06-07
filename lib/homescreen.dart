import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'constants.dart' as k;

import 'dart:convert';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  bool isLoaded = false;
  late num temp = 0;
  late num pressure = 0;
  late num humid = 0;
  late num cloudCover = 0;
  String cityName = "";

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.teal, Colors.blue, Colors.green]),
        ),
        child: Visibility(
          visible: isLoaded,
          replacement: Center(
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                showLabels: true,
                showTicks: true,
                startAngle: 180,
                endAngle: 00,
                radiusFactor: 0.7,
                canScaleToFit: true,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.1,
                  color: Colors.red,
                  thicknessUnit: GaugeSizeUnit.factor,
                  cornerStyle: CornerStyle.startCurve,
                ),
                pointers: const <GaugePointer>[
                  RangePointer(
                      value: 50,
                      width: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      cornerStyle: CornerStyle.bothCurve)
                ],
              )
            ]),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.09,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: TextFormField(
                    controller: controller,
                    onFieldSubmitted: (String s) {
                      setState(() {
                        cityName = s;
                        getCItyWeather(cityName);
                        controller.clear();
                        isLoaded = false;
                      });
                    },
                    cursorColor: Colors.white,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Cityname',
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w600),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 20,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.pin_drop,
                      color: Colors.red,
                      size: 40,
                    ),
                    Text(
                      cityName,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade900,
                        offset: const Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: const AssetImage('asset/images/t.png'),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .09,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Temparature ${temp.toInt()} °C',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: const AssetImage('asset/images/c.png'),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .09,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Cloud Cover ${cloudCover.toInt()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('asset/images/h.png'),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .09,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Humidity ${humid.toInt()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.12,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('asset/images/b.png'),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .09,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Pressure ${pressure} Hpa',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        forceAndroidLocationManager: false);

    if (p != null) {
      getCurrentCityWeather(p);
    } else {
      print("Location canot be accessed");
    }
  }

  getCurrentCityWeather(Position position) async {
    var client = http.Client();

    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);

      updateUI(decodeData);

      setState(() {
        isLoaded = true;
      });
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  getCItyWeather(String city) async {
    var client = http.Client();

    var uri = '${k.domain}q=$city&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
      updateUI(decodeData);
      setState(() {
        isLoaded = true;
      });
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  void updateUI(var decodedData) {
    setState(() {
      if (decodedData == null) {
        pressure = 0;
        temp = 0;
        humid = 0;
        cloudCover = 0;
        cityName = 'Not available';
      } else {
        pressure = decodedData['main']['pressure'] - 273;
        temp = decodedData['main']['temp'] - 273;
        humid = decodedData['main']['humidity'];
        cloudCover = decodedData['clouds']['all'];
        cityName = decodedData['name'];
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
