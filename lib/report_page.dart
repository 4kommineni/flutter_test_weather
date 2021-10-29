import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test_weather/details_page.dart';
import 'package:flutter_test_weather/wether_model.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  final WeatherData priData;
  const ReportPage({Key? key, required this.priData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  AllWeatherData? weatherdetails;
  final ScrollController _scrollController = ScrollController();
  bool isFab = false;

  @override
  void initState() {
    weatherdetails = AllWeatherData();

    weatherdetails?.allData.add(widget.priData);

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
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 600,
            child: CustomScrollView(
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
                      stretchModes: const [
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
          ),
        ],
      ),
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
            child: Slidable(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        child: (weatherdetails!.allData.elementAt(index).profilepic == null)
                            ? Image.asset(
                                "images/profile_pic.png",
                                fit: BoxFit.fill,
                                width: 200,
                                height: 148,
                              )
                            : Image.memory(
                                weatherdetails!.allData.elementAt(index).profilepic!,
                                fit: BoxFit.fill,
                                width: 200,
                                height: 148,
                              ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 150,
                          top: 100,
                        ),
                        child: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (weatherdetails?.allData.elementAt(index).date != null)
                          Text(
                            f.format(weatherdetails?.allData.elementAt(index).date ?? DateTime.now()),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                        const Padding(padding: EdgeInsets.only(top: 16, bottom: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                  text: 'Max temp :',
                                  style: const TextStyle(
                                      fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: (weatherdetails?.allData.elementAt(index).mintemp.toString() ?? ""),
                                      style: const TextStyle(
                                          fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
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
                                    fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: (weatherdetails?.allData.elementAt(index).maxtemp.toString() ?? ""),
                                    style: const TextStyle(
                                        fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8, right: 12, left: 12)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(weatherdetails?.allData.elementAt(index).weathercondition ?? ""),
                          ],
                        ),
                        // ]),
                      ],
                    ),
                  )
                ],
              ),
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: <Widget>[
                IconSlideAction(
                    caption: 'edit',
                    color: Colors.black45,
                    icon: Icons.edit,
                    onTap: () async {
                      WeatherData modifiedData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            weatherData: weatherdetails!.allData.elementAt(index),
                          ),
                        ),
                      );
                      weatherdetails!.allData[index] = modifiedData;
                      setState(() {});
                    }),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    weatherdetails?.allData.removeAt(index);
                    setState(() {});
                  },
                ),
              ],
            ));
      },
      childCount: weatherdetails?.allData.length,
    ));
  }
}
