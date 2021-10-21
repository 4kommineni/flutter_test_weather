import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_weather/details_page.dart';
import 'package:flutter_test_weather/wether_model.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  AllWeatherData? weatherdetails;
  @override
  @override
  void initState() {
    weatherdetails = AllWeatherData();

    weatherdetails?.allData.add;

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
        title: const Text('WEATHER REPORT',
            style: TextStyle(fontSize: 30.0, color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            weatherdetails?.allData.length ?? 0,
            (index) => weatherdetailsAsCard(index),
          ),
        ),
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

  Widget weatherdetailsAsCard(index) {
    return Card(
        elevation: 8,
        color: Colors.blueGrey,
        clipBehavior: Clip.antiAlias,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.memory(
              weatherdetails!.allData.elementAt(index).profilepic,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(weatherdetails?.allData
                    .elementAt(index)
                    .date!
                    .toUtc()
                    .toString() ??
                ""),
            const Padding(padding: EdgeInsets.only(top: 23)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RichText(
                    text: TextSpan(text: 'maxtemp :', children: <TextSpan>[
                      TextSpan(
                        text: (weatherdetails?.allData
                                .elementAt(index)
                                .maxtemp
                                .toString() ??
                            ""),
                      )
                    ]),
                  ),
                  RichText(
                    text: TextSpan(text: 'mintemp :', children: <TextSpan>[
                      TextSpan(
                        text: (weatherdetails?.allData
                                .elementAt(index)
                                .mintemp
                                .toString() ??
                            ""),
                      )
                    ]),
                  ),
                ]),
            const Padding(padding: EdgeInsets.only(top: 23)),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(weatherdetails?.allData.elementAt(index).weathercondition ??
                  ""),
            ]),
          ])
        ]));
  }
}
