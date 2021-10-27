import 'dart:typed_data';
import 'dart:ui';
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
  DateTime? locdate = DateTime.now();
  String? minErrorMessage;
  String? maxErrorMessage;
  TextEditingController mintemperature = TextEditingController();
  TextEditingController maxtemperature = TextEditingController();
  TextEditingController datetime = TextEditingController();

  int weathercondition = 0;
  @override
  void initState() {
    String weathercond = "";
    if (weathercondition == 0) {
      weathercond = "Sunny";
    } else if (weathercondition == 1) {
      weathercond = "Rainy";
    } else {
      weathercond = "Cloudy";
    }
    final f = DateFormat('dd/MM/yyyy');

    //print(" rollNumber= ${widget.student?.rollNumber.toString()}");
    mintemperature.text = widget.weatherData?.mintemp.toString() ?? "";
    maxtemperature.text = widget.weatherData?.maxtemp.toString() ?? "";
    weathercond = widget.weatherData?.weathercondition ?? "no";

    datetime.text = f.format(widget.weatherData?.date ?? DateTime.now());
    data = widget.weatherData?.profilepic;
    super.initState();
  }

  Widget _portraitMode() {
    return Align(
        alignment: Alignment.topCenter,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.indigo[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
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
                              fit: BoxFit.fill,
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
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 15),
                        controller: mintemperature,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        onChanged: (val) {
                          int minTemp = int.tryParse(val) ?? -100;

                          if (minTemp == -100 || minTemp < -40) {
                            minErrorMessage =
                                "Mintemperature is greater than -40.";
                          } else {
                            minErrorMessage = null;
                          }

                          setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          errorText: minErrorMessage,
                          labelText: 'Enter Minimum Temperature',
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(width: 2.0),
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 15),
                        controller: maxtemperature,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        onChanged: (val) {
                          print(val);
                          int maxTemp = int.tryParse(val) ?? -100;
                          print(maxTemp);
                          if (maxTemp == -100) {
                            maxErrorMessage = null;
                          } else if (maxTemp < 0 || maxTemp > 50) {
                            maxErrorMessage =
                                "Maxtemperature is greater than 50.";
                          } else {
                            maxErrorMessage = null;
                          }

                          setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Enter Maximum Temperature',
                          errorText: maxErrorMessage,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(width: 2.0),
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text(
                      "CHOOSE WEATHER TYPE ",
                      style: TextStyle(fontSize: 15),
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
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

                          datetime.text = f.format(date ?? DateTime.now());
                          date = date;

                          if (date == null) {
                            date = DateTime.now();
                          } else if (date == DateTime.now()) {
                            date = date;
                          } else if (date.isAfter(DateTime.now()) == true) {
                            date = date;
                          } else {
                            datetime.text = "Don't select past day";
                          }
                          setState(() {});
                        },
                      ),
                    ),
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

                        int mint = int.parse(mintemperature.text.toString());
                        int maxt = int.parse(maxtemperature.text.toString());
                        WeatherData? inputData;
                        if (maxt > mint) {
                          inputData = WeatherData(
                              mintemp:
                                  int.parse(mintemperature.text.toString()),
                              maxtemp:
                                  int.parse(maxtemperature.text.toString()),
                              date: locdate,
                              weathercondition: weathercond,
                              profilepic: data!);
                          Navigator.pop(context, inputData);
                        } else {
                          minErrorMessage =
                              "Mintemperature is lessthan max temperature";
                        }
                      },
                      child: const Text(
                        "ADD",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ));
        }));
  }

  Widget _landscapeMode() {
    return Align(
      alignment: Alignment.topCenter,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.indigo[100],
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
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
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton.icon(
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
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 15),
                            controller: mintemperature,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            onChanged: (val) {
                              int minTemp = int.tryParse(val) ?? -100;

                              if (minTemp == -100 || minTemp < -40) {
                                minErrorMessage =
                                    "Mintemperature is greater than -40.";
                              } else {
                                minErrorMessage = null;
                              }

                              setState(() {});
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              errorText: minErrorMessage,
                              labelText: 'Enter Minimum Temperature',
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(width: 2.0),
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 15),
                            controller: maxtemperature,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            onChanged: (val) {
                              print(val);
                              int maxTemp = int.tryParse(val) ?? -100;
                              print(maxTemp);
                              if (maxTemp == -100) {
                                maxErrorMessage = null;
                              } else if (maxTemp < 0 || maxTemp > 50) {
                                maxErrorMessage =
                                    "Maxtemperature is greater than 50.";
                              } else {
                                maxErrorMessage = null;
                              }

                              setState(() {});
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Enter Maximum Temperature',
                              errorText: maxErrorMessage,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(width: 2.0),
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              const Text(
                                "CHOOSE WEATHER TYPE ",
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
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
                          ),
                        ]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
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

                          datetime.text = f.format(date ?? DateTime.now());
                          date = date;

                          if (date == null) {
                            date = DateTime.now();
                          } else if (date == DateTime.now()) {
                            date = date;
                          } else if (date.isAfter(DateTime.now()) == true) {
                            date = date;
                          } else {
                            datetime.text = "Don't select past day";
                          }
                          setState(() {});
                        },
                      ),
                    ),
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

                        int mint = int.parse(mintemperature.text.toString());
                        int maxt = int.parse(maxtemperature.text.toString());
                        WeatherData? inputData;
                        if (maxt > mint) {
                          inputData = WeatherData(
                              mintemp:
                                  int.parse(mintemperature.text.toString()),
                              maxtemp:
                                  int.parse(maxtemperature.text.toString()),
                              date: locdate,
                              weathercondition: weathercond,
                              profilepic: data!);
                          Navigator.pop(context, inputData);
                        } else {
                          minErrorMessage =
                              "Mintemperature is lessthan max temperature";
                        }
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
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _portraitMode();
          } else {
            return _landscapeMode();
          }
        },
      ),
    );
  }
}
