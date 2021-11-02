import 'dart:typed_data';

class AllWeatherData {
  List<WeatherData> allData = List.empty(growable: true);

  Iterable<WeatherData> fromJson(List<dynamic> data) {
    return data.map((element) {
      return WeatherData.fromJson(element);
    });

    // for (int i = 0; i < data.length; i++) {
    //   WeatherData temp = WeatherData.fromJson(data[i]);
    //   allData.add(temp);
    // }
  }
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
    int mtemp = int.parse(data['minTemp'].toString().split(".")[0]);

    return WeatherData(
        mintemp: mtemp,
        maxtemp: int.parse(data['maxTemp'].toString().split(".")[0]),
        date: DateTime.parse(data['dayDate']),
        weathercondition: data['dayType']);
  }
}
