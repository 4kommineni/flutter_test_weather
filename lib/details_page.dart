import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_test_weather/report_page.dart';
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
  Uint8List? data;
  DateTime? date = DateTime.now();

  TextEditingController mintemperature = TextEditingController();
  TextEditingController maxtemperature = TextEditingController();
  TextEditingController datetime = TextEditingController();

  int weathercondition = 0;
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
                      "WEATHER CONDITION",
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
                      'SUNNY',
                      style: TextStyle(fontSize: 20),
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
                      'RAINY',
                      style: TextStyle(fontSize: 20),
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
                      'CLOUDY',
                      style: TextStyle(fontSize: 20),
                    ),
                  ]),
                  TextField(
                    readOnly: true,
                    controller: datetime,
                    decoration:
                        const InputDecoration(hintText: 'Pick your Date'),
                    onTap: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2021, 09, 30),
                        firstDate: DateTime(1950, 1),
                        lastDate: DateTime(2022, 1),
                        helpText: 'Select a date',
                      );
                      datetime.text = date?.toUtc().toString() ?? " ";
                      date = date;
                      setState(() {});
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      WeatherData inputData = WeatherData(
                          mintemp: int.parse(mintemperature.text.toString()),
                          maxtemp: int.parse(maxtemperature.text.toString()),
                          date: date,
                          weathercondition:
                              (weathercondition == 0) ? "SUNNY" : "RAINY",
                          profilepic: data!);

                      Navigator.pop(context, inputData);
                    },
                    child: const Text(
                      "ADD",
                      style: TextStyle(fontSize: 30),
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
