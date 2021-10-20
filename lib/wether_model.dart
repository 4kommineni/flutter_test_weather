class AllWeatherData {
  List<WeatherData> allData = List.empty(growable: true);
}

class WeatherData {
  dynamic profilepic;

  int mintemp;
  int maxtemp;
  String weathercondition;
  DateTime? date;

  WeatherData({
    required this.profilepic,
    required this.maxtemp,
    required this.mintemp,
    required this.weathercondition,
    this.date,
  });
}
