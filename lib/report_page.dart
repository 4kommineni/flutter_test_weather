import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_weather/details_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.backspace)),
        title: const Text('WETHER REPORT',
            style: TextStyle(fontSize: 30.0, color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text(
              'NO DATA AVALIABLE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            //   if (checked)
            // Text(
            //    'Second Widget',
            //  style: TextStyle(
            //    fontSize: 18,
            //    fontWeight: FontWeight.bold,
            //  ),
            // )
          ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailsPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
