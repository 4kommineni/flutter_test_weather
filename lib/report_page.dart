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
  ScrollController _scrollController = new ScrollController();
  bool isFab = false;
  @override
  void initState() {
    weatherdetails = AllWeatherData();

    weatherdetails?.allData.add;
    _scrollController.addListener(() {
      if (_scrollController.offset > 20) {
        setState(() {
          isFab = true;
        });
      } else {
        setState(() {
          isFab = false;
        });
      }
    });

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
      body: //SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          // child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          //  children:
          _buildweather(),
      floatingActionButton: isFab ? buildFAB() : buildextendedFAB(),
    );
  }

  Widget buildFAB() => AnimatedContainer(
        duration: Duration(microseconds: 200),
        curve: Curves.linear,
        width: 50,
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () async {
            WeatherData newData = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailsPage()),
            );
            weatherdetails?.allData.add(newData);
            setState(() {});

            child:
            const Icon(Icons.add);
          },
          icon: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.edit),
          ),
          label: const SizedBox(),
        ),
      );

  Widget buildextendedFAB() => AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
        height: 50,
        width: 150,
        child: FloatingActionButton.extended(
            onPressed: () async {
              WeatherData newData = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailsPage()),
              );
              weatherdetails?.allData.add(newData);
              setState(() {});

              child:
              const Icon(Icons.add);
            },
            icon: Icon(Icons.edit),
            label: const Center(
              child: Text(
                "compose",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )),
      );

  // List.generate(
  //  weatherdetails?.allData.length ?? 0,
  //  (index) => weatherdetailsAsCard(index),
  //  ),

  ListView _buildweather() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: weatherdetails?.allData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 8,
              color: Colors.blueGrey,
              margin: const EdgeInsets.all(20),
              clipBehavior: Clip.antiAlias,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.memory(
                      weatherdetails!.allData.elementAt(index).profilepic,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                  text: TextSpan(
                                      text: 'Maximum Temperature :',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: (weatherdetails?.allData
                                                  .elementAt(index)
                                                  .maxtemp
                                                  .toString() ??
                                              ""),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Minimum Temperature :',
                                      style: const TextStyle(
                                          fontSize: 18,
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
                              ]),
                          const Padding(padding: EdgeInsets.only(top: 23)),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(weatherdetails?.allData
                                        .elementAt(index)
                                        .weathercondition ??
                                    ""),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        WeatherData modifiedData =
                                            await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                              weatherData: weatherdetails!
                                                  .allData
                                                  .elementAt(index),
                                            ),
                                          ),
                                        );
                                        weatherdetails!.allData[index] =
                                            modifiedData;
                                        setState(() {});
                                      },
                                      child: const Icon(Icons.edit),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        weatherdetails?.allData.removeAt(index);
                                        setState(() {});
                                      },
                                      child: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ]),
                        ])
                  ]));
        });

    // Widget listViewDetails(index) {
    // return Card(
    //    clipBehavior: Clip.antiAlias,
    //    child: Column(children: [
    //     ElevatedButton(
    //      onPressed: () async {
    //  WeatherData modifiedData = await Navigator.push(
    //    context,
    //    MaterialPageRoute(
    //      builder: (context) => DetailsPage(
    //        weatherData: weatherdetails!.allData.elementAt(index),
    //      ),
    //     ),
    //    );
    //     weatherdetails!.allData[index] = modifiedData;
    //     setState(() {});
    //   },
    //   child: const Icon(Icons.edit),
    // ),
    // ElevatedButton(
    //    onPressed: () {
    //      weatherdetails?.allData.removeAt(index);
    //     setState(() {});
    //   },
    //   child: const Icon(Icons.delete),
    //   ),
    //  ]));
    //  }
  }
}
