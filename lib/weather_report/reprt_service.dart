import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_test_weather/model/http_resp.dart';
import 'package:flutter_test_weather/weather_report/wether_model.dart';

class ReportService {
  Future<List<WeatherData>> getWethewrDetails() async {
    var url = Uri.parse('https://devapi.srivijnanavihara.com/general/dummy/GET_WEATHER_DATA');
    var response = await http.post(url, body: jsonEncode({'count': '-7'}));

    HttpResponse resp = HttpResponse.fromJson(jsonDecode(response.body));

    List<WeatherData> myData = List.empty(growable: true); // []

    if (resp.code == 200) {
      for (int i = 0; i < resp.msg.length; i++) {
        WeatherData data = WeatherData.fromJson(resp.msg[i]);
        myData.add(data);
      }
    } else {}

    return myData;
  }

  Future<List<WeatherData>> getWethewrDetailsFromModal() async {
    var url = Uri.parse('https://devapi.srivijnanavihara.com/general/dummy/GET_WEATHER_DATA');
    var response = await http.post(url, body: jsonEncode({'count': '-7'}));
    HttpResponse resp = HttpResponse.fromJson(jsonDecode(response.body));

    List<WeatherData> myData = List.empty(growable: true); // []

    if (resp.code == 200) {
      myData.addAll(AllWeatherData().fromJson(resp.msg));
    } else {}

    return myData;
  }
}
