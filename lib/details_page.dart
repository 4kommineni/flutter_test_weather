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
  Uint8List? data = null;
  DateTime? dob = DateTime.now();

  TextEditingController mintemperature = TextEditingController();
  TextEditingController maxtemperature = TextEditingController();
  TextEditingController dateofBirth = TextEditingController();

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (data != null)
                          ? Image.memory(
                              data!,
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
                            data = value;

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
                  TextField(
                    readOnly: true,
                    controller: dateofBirth,
                    decoration:
                        const InputDecoration(hintText: 'Pick your Date'),
                    // Text(widget.userData?.dateOfBirth.toString() ?? ""),
                    // ElevatedButton(
                    onTap: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2021, 09, 30),
                        firstDate: DateTime(1950, 1),
                        lastDate: DateTime(2022, 1),
                        helpText: 'Select a date',
                      );

                      dateofBirth.text = date?.toUtc().toString() ?? " ";
                      dob = date;
                      setState(() {});
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String weathercond = "";
                      if (weathercondition == 0) {
                        weathercond = "sunny";
                      } else if (weathercondition == 1) {
                        weathercond = "Rainy";
                      } else {
                        weathercond = "Cloudy";
                      }
                      WeatherData inputData = WeatherData(
                          mintemp: int.parse(mintemperature.text.toString()),
                          maxtemp: int.parse(maxtemperature.text.toString()),
                          date: dob,
                          weathercondition: weathercond,
                          // (weathercondition == 0) ? "sunny" : "rainy",
                          profilepic: data!);

                      Navigator.pop(context, inputData);
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
