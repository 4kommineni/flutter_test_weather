import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test_weather/details_page.dart';
import 'package:flutter_test_weather/wether_model.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  AllWeatherData? weatherdetails;

  bool isFab = false;
  @override
  void initState() {
    weatherdetails = AllWeatherData();

    weatherdetails?.allData
        .add(WeatherData(maxtemp: 12, mintemp: 2, weathercondition: "Sunny"));
    weatherdetails?.allData
        .add(WeatherData(maxtemp: 12, mintemp: 23, weathercondition: "rainy"));
    weatherdetails?.allData
        .add(WeatherData(maxtemp: 12, mintemp: 23, weathercondition: "rainy"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.backspace)),
        title: const Text(
          'WEATHER REPORT',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.teal,
            //floating: true,
            pinned: true,
            stretch: true,
            //snap: true,
            onStretchTrigger: () async {
              Text("hi");
            },
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle
                ],
                title: Text("weather app"),
                background: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: <Color>[Colors.teal, Colors.transparent])),
                  child: Image.asset(
                    "images/wea.png",
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          buildweather(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () async {
          WeatherData newData = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailsPage()),
          );
          weatherdetails?.allData.add(newData);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildweather() {
    final f = DateFormat('dd/MM/yyyy');

    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Card(
          elevation: 8,
          color: Colors.blue[100],
          margin: const EdgeInsets.all(20),
          clipBehavior: Clip.antiAlias,
          // child: Slidable(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              (weatherdetails!.allData.elementAt(index).profilepic == null)
                  ? Image.asset("images/profile_pic.png")
                  : Image.memory(
                      weatherdetails!.allData.elementAt(index).profilepic!,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 148,
                    ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16, bottom: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (weatherdetails?.allData.elementAt(index).date != null)
                      Text(
                        f.format(
                            weatherdetails?.allData.elementAt(index).date ??
                                DateTime.now()),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                    const Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Max temp :',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (weatherdetails?.allData
                                          .elementAt(index)
                                          .mintemp
                                          .toString() ??
                                      ""),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Min Temp :',
                            style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: (weatherdetails?.allData
                                        .elementAt(index)
                                        .mintemp
                                        .toString() ??
                                    ""),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                        padding: EdgeInsets.only(top: 8, right: 12, left: 12)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(weatherdetails?.allData
                                .elementAt(index)
                                .weathercondition ??
                            ""),
                      ],
                    ),
                    // ]),
                  ],
                ),
              )
            ],
          ),
        );
      },
      childCount: weatherdetails?.allData.length,
    ));
  }
}
