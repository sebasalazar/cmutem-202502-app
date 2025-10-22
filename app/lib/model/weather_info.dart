import 'dart:convert';
import 'package:app/model/weather_data.dart';

class WeatherInfo {
  final String status;
  final WeatherData data;

  WeatherInfo({required this.status, required this.data});

  factory WeatherInfo.fromJson(Map<String, dynamic> jsonMap) => WeatherInfo(
    status: jsonMap["status"] as String,
    data: WeatherData.fromJson(jsonMap["data"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };

  String toRawJson() => json.encode(toJson());

  factory WeatherInfo.fromRawJson(String str) =>
      WeatherInfo.fromJson(json.decode(str) as Map<String, dynamic>);
}
