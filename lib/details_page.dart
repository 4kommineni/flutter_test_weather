import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_weather/report_page.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController mintemperature = TextEditingController();
  TextEditingController maxtemperature = TextEditingController();

  int weathercondition = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Weather Report'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Container(
          width: 600.0,
          height: 800.0,
          child: Card(
            elevation: 50.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: Colors.amber[50],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    style: const TextStyle(fontSize: 20),
                    controller: mintemperature,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: const InputDecoration(
                      labelText: 'Enter Minimum Temperature',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 20),
                    controller: maxtemperature,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: const InputDecoration(
                      labelText: 'Enter Maximum Temperature',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(children: [
                    const Text(
                      "Weather Condition",
                      style: TextStyle(fontSize: 20),
                    ),
                    Radio(
                      value: 0,
                      groupValue: weathercondition,
                      onChanged: (value) {
                        weathercondition = 0;
                        setState(() {});
                      },
                    ),
                    const Text(
                      'Sunny',
                      style: TextStyle(fontSize: 15),
                    ),
                    const VerticalDivider(thickness: 1),
                    Radio(
                      value: 1,
                      groupValue: weathercondition,
                      onChanged: (value) {
                        weathercondition = 1;
                        setState(() {});
                      },
                    ),
                    const Text(
                      'Rainy',
                      style: TextStyle(fontSize: 15),
                    ),
                    Radio(
                      value: 2,
                      groupValue: weathercondition,
                      onChanged: (value) {
                        weathercondition = 2;
                        setState(() {});
                      },
                    ),
                    const Text(
                      'Cloudy',
                      style: TextStyle(fontSize: 15),
                    ),
                  ]),
                  Row(
                    children: [
                      const Text(
                        "Select Date:",
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_today_rounded),
                        label: const Text(""),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportPage()),
                      );
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
