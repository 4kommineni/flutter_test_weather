import 'dart:typed_data';

class Allweatherdata {
  List<WeatherData> allData1 = List.empty(growable: true);
}

class WeatherData {
  //File daysimage;
  Uint8List? imageshow;

  int mintemp;
  int maxtemp;

  String weathercondition;

  DateTime? todaydate;

  WeatherData({
    //required this.image,
    this.imageshow,
    required this.mintemp,
    required this.maxtemp,
    required this.weathercondition,
    required this.todaydate,
  });
}
