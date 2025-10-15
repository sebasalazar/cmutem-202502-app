import 'dart:convert';

class WeatherData {
  String code;
  String city;
  String updatedAt;
  int temperature;
  String condition;
  int humidity;

  WeatherData({
    required this.code,
    required this.city,
    required this.updatedAt,
    required this.temperature,
    required this.condition,
    required this.humidity,
  });

  Map<String, dynamic> toJson() => {
    "code": code,
    "city": city,
    "updated_at": updatedAt,
    "temperature": temperature,
    "condition": condition,
    "humidity": humidity,
  };

  String toRawJson() => json.encode(toJson());

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
    code: json["code"],
    city: json["city"],
    updatedAt: json["updatedAt"],
    temperature: json["temperature"],
    condition: json["condition"],
    humidity: json["humidity"],
  );

  factory WeatherData.fromRawJson(String str) =>
      WeatherData.fromJson(json.decode(str));
}
