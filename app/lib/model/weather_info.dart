import 'dart:convert';

import 'package:app/model/weather_data.dart';

class WeatherInfo {
  String status;
  WeatherData data;

  WeatherInfo({required this.status, required this.data});

  Map<String, dynamic> toJson() => {"status": status, "data": data.toJson()};

  String toRawJson() => json.encode(toJson());

  factory WeatherInfo.fromJson(Map<String, dynamic> json) =>
      WeatherInfo(status: json["status"], data: json["data"]);

  factory WeatherInfo.fromRawJson(String str) =>
      WeatherInfo.fromJson(json.decode(str));
}
