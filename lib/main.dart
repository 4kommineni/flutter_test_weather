import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test_weather/weather_report/report_page_ui.dart';
import 'package:flutter_test_weather/weather_report/reprt_service.dart';
import 'package:flutter_test_weather/weather_report/wether_model.dart';

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
    List<WeatherData> myData = await ReportService().getWethewrDetails();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportPage(priData: myData)),
    );
  }
}
