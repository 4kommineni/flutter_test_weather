import 'dart:typed_data';

class AllWeatherData {
  List<WeatherData> allData = List.empty(growable: true);
}

class WeatherData {
  Uint8List? profilepic;
  int mintemp;
  int maxtemp;
  String weathercondition;
  DateTime? date;

  WeatherData({
    this.profilepic,
    required this.maxtemp,
    required this.mintemp,
    required this.weathercondition,
    this.date,
  });
}
