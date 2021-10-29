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

  factory WeatherData.fromJson(Map<String, dynamic> data) {
    return WeatherData(
        mintemp: int.parse(data['minTemp'].toString().split(".")[0]),
        maxtemp: int.parse(data['maxTemp'].toString().split(".")[0]),
        date: DateTime.parse(data['dayDate']),
        weathercondition: data['dayType']);
  }
}
