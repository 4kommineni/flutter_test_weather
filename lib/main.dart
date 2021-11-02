import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test_weather/model/http_resp.dart';
import 'package:flutter_test_weather/wether_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_test_weather/report_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashSceeenPage(),
      scrollBehavior: MyCustomScrollBehavior(),
      // ...
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

// Set ScrollBehavior for an entire application.

class SplashSceeenPage extends StatefulWidget {
  const SplashSceeenPage({Key? key}) : super(key: key);

  @override
  State<SplashSceeenPage> createState() => _SplashSceeenPage();
}

class _SplashSceeenPage extends State<SplashSceeenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getWethewrDetails();
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/weatherbgimage.jpg'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Image.asset(
              'assets/images/weatherlogo.jpg',
              width: MediaQuery.of(context).size.width - 5,
            ),
          ),
        ));
  }

  void getWethewrDetails() async {
    var url = Uri.parse(
        'https://devapi.srivijnanavihara.com/general/dummy/GET_WEATHER_DATA');

    var response = await http.post(url, body: jsonEncode({'count': '7'}));
    print('Response code: ${response.statusCode}');

    HttpResponse resp = HttpResponse.fromJson(jsonDecode(response.body));

    print('Response code: ${resp.code}');
    print('Response msg: ${resp.msg}');

    WeatherData data = WeatherData.fromJson(resp.msg);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportPage(priData: data)),
    );
  }
}
