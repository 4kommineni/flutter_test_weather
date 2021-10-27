import 'dart:async';

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
      home: SplashSceeenPage(),
      routes: {
        "ReportPage": (context) => ReportPage(),
      },
    );
  }
}

class SplashSceeenPage extends StatefulWidget {
  const SplashSceeenPage({Key? key}) : super(key: key);

  @override
  State<SplashSceeenPage> createState() => _SplashSceeenPage();
}

class _SplashSceeenPage extends State<SplashSceeenPage> {
  void startTimer() {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('ReportPage');
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assests/images/weatherbgimage.jpg'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Image.asset(
              'assests/images/profile_pic.png',
              width: MediaQuery.of(context).size.width - 5,
            ),
          ),
        ));
  }
}
