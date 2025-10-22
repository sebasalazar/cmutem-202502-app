import 'dart:convert';

class WeatherData {
  final String code;
  final String city;
  final DateTime updatedAt; // Se serializa como "HH:mm:ss"
  final int temperature;
  final String condition;
  final int humidity;

  WeatherData({
    required this.code,
    required this.city,
    required this.updatedAt,
    required this.temperature,
    required this.condition,
    required this.humidity,
  });

  /// Acepta 'updated_at' (snake_case) o 'updatedAt' (camelCase)
  factory WeatherData.fromJson(Map<String, dynamic> jsonMap) {
    final String rawTime =
    (jsonMap["updated_at"] ?? jsonMap["updatedAt"]) as String;

    return WeatherData(
      code: jsonMap["code"] as String,
      city: jsonMap["city"] as String,
      updatedAt: _parseHms(rawTime),
      temperature: (jsonMap["temperature"] as num).toInt(),
      condition: jsonMap["condition"] as String,
      humidity: (jsonMap["humidity"] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "city": city,
    "updated_at": _formatHms(updatedAt),
    "temperature": temperature,
    "condition": condition,
    "humidity": humidity,
  };

  String toRawJson() => json.encode(toJson());

  factory WeatherData.fromRawJson(String str) =>
      WeatherData.fromJson(json.decode(str) as Map<String, dynamic>);

  /// --- Helpers ---

  /// Parsea "HH:mm:ss" a un DateTime con fecha fija UTC 1970-01-01.
  static DateTime _parseHms(String hms) {
    final List<String> parts = hms.split(':');
    if (parts.length != 3) {
      throw FormatException('Hora inválida, se esperaba "HH:mm:ss": $hms');
    }
    final int year = DateTime.timestamp().year;
    final int month = DateTime.timestamp().month;
    final int day = DateTime.timestamp().day;
    final int hour = int.parse(parts[0]);
    final int minute = int.parse(parts[1]);
    final int second = int.parse(parts[2]);
    return DateTime.utc(year, month, day, hour, minute, second);
  }

  /// Formatea DateTime como "HH:mm:ss" (usa la hora del DateTime).
  static String _formatHms(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(dt.hour)}:${two(dt.minute)}:${two(dt.second)}';
  }
}
