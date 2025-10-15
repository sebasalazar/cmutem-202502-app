import 'package:app/model/weather_data.dart';
import 'package:app/model/weather_info.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RestService {
  static final Dio _client = Dio();
  static final Logger _logger = Logger();

  static const String _jsonMime = "application/json";
  static const String _baseUrl = "https://api.boostr.cl";

  static Future<WeatherData?> getWeather(String station) async {
    WeatherData? data;
    try {
      if (!_client.interceptors.any(
        (interceptor) => interceptor is LogInterceptor,
      )) {
        _client.interceptors.add(
          LogInterceptor(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
          ),
        );
      }

      final String url = "$_baseUrl/weather/$station.json";
      final Map<String, String> headers = {"accept": _jsonMime};

      final Response<String> response = await _client.get(url, options: Options(headers: headers));
      final int httpCode = response.statusCode ?? 400;
      if (httpCode >= 200 && httpCode < 300) {
        String json = response.data ?? '';
        if (json.isEmpty) {
          WeatherInfo info = WeatherInfo.fromRawJson(json);
          data = info.data;
        }
      }
    } catch (e) {
      _logger.f("Ha ocurrido un error $e");
    }
    return data;
  }
}
