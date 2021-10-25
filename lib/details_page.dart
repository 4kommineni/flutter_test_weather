import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_test_weather/report_page.dart';
import 'package:flutter_test_weather/wether_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  String? minErrorMessage;
  String? maxErrorMessage;
  TextEditingController mintemperature = TextEditingController();
  TextEditingController maxtemperature = TextEditingController();
  TextEditingController datetime = TextEditingController();

  int weathercondition = 0;
  @override
  void initState() {
    //print(" rollNumber= ${widget.student?.rollNumber.toString()}");
    mintemperature.text = widget.weatherData?.mintemp.toString() ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Insert Weather Report'),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                color: Colors.lightBlue[50],
                child: Center(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(50),
                          child: (data != null)
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
                          label: const Text("choose image"),
                        ),
                        TextField(
                          readOnly: true,
                          controller: datetime,
                          decoration: const InputDecoration(
                            hintText: 'Pick your Date',
                            icon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            var date = await showDatePicker(
                              context: context,
                              //  initialDate: DateTime(2021, 09, 30),
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950, 1),
                              lastDate: DateTime(2022, 1),
                              helpText: 'Select a date',
                            );

                            final f = DateFormat('dd/MM/yyyy');
                            // datetime.text = f.format(
                            //    DateTime.fromMillisecondsSinceEpoch(
                            //      date?.millisecondsSinceEpoch ?? 0));
                            datetime.text = f.format(date ?? DateTime.now());
                            date = date;
                            setState(() {});
                          },
                        ),
                        TextFormField(
                          style: const TextStyle(fontSize: 15),
                          controller: mintemperature,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          onChanged: (val) {
                            int minTemp = int.tryParse(val) ?? -100;

                            if (minTemp == -100 || minTemp < -40) {
                              minErrorMessage = "Invalid Entry.";
                            } else {
                              minErrorMessage = null;
                            }

                            setState(() {});
                          },
                          decoration: InputDecoration(
                            errorText: minErrorMessage,
                            labelText: 'Enter Minimum Temperature',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                        ),
                        TextFormField(
                          style: const TextStyle(fontSize: 15),
                          controller: maxtemperature,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          onChanged: (val) {
                            int maxTemp = int.tryParse(val) ?? -100;

                            if (maxTemp == -40 || maxTemp < 50) {
                              minErrorMessage = "Invalid Entry.";
                            } else {
                              minErrorMessage = null;
                            }

                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter Maximum Temperature',
                            errorText: maxErrorMessage,
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(width: 2.0),
                            ),
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "CHOOSE WEATHER TYPE",
                                style: TextStyle(fontSize: 15),
                              ),
                              Column(
                                children: [
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
                                    style: TextStyle(fontSize: 10),
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
                                    style: TextStyle(fontSize: 10),
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
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ]),
                        ElevatedButton(
                          onPressed: () {
                            String weathercond = "";
                            if (weathercondition == 0) {
                              weathercond = "Sunny";
                            } else if (weathercondition == 1) {
                              weathercond = "Rainy";
                            } else {
                              weathercond = "Cloudy";
                            }

                            WeatherData inputData = WeatherData(
                                mintemp:
                                    int.parse(mintemperature.text.toString()),
                                maxtemp:
                                    int.parse(maxtemperature.text.toString()),
                                date: date,
                                weathercondition: weathercond,
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
                ))));
  }
}
