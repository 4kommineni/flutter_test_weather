import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_weather/report_page.dart';
import 'package:flutter_test_weather/wether_model.dart';
import 'package:image_picker/image_picker.dart';

class DetailsPage extends StatefulWidget {
  final WeatherData? weatherData;
  const DetailsPage({Key? key, this.weatherData}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? profilePic;

  TextEditingController mintemperature = TextEditingController();
  TextEditingController maxtemperature = TextEditingController();

  int weathercondition = 0;
  @override
  void initState() {
    mintemperature.text = widget.weatherData?.mintemp.toString() ?? "0";
    maxtemperature.text = widget.weatherData?.maxtemp.toString() ?? "0";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Weather Report'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Card(
          elevation: 50.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            width: 600.0,
            height: 800.0,
            color: Colors.amber[50],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (profilePic != null)
                          ? Image.memory(
                              profilePic!,
                              width: 200,
                              height: 200,
                            )
                          : Image.asset(
                              "images/profile_pic.png",
                              width: 200,
                              height: 200,
                            ),
                      TextButton.icon(
                        onPressed: () async {
                          // provide options to choose from gallery or camera
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          image?.readAsBytes().then((value) {
                            profilePic = value;
                            setState(() {});
                          });
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("change"),
                      ),
                    ],
                  ),
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
                    maxLength: 2,
                    keyboardType: TextInputType.number,
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
                      ElevatedButton.icon(
                        onPressed: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime(2021, 09, 30),
                            firstDate: DateTime(1950, 1),
                            lastDate: DateTime(2022, 1),
                            helpText: 'Select a date',
                          );
                          setState(() {});
                        },
                        icon: const Icon(Icons.calendar_today_rounded),
                        label: const Text("Select date"),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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
