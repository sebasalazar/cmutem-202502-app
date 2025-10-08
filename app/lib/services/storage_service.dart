import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final Logger _logger = Logger();

  static Future<String> getValue(String key) async {
    String value = '';
    if (key.isNotEmpty) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      value = preferences.getString(key) ?? '';
    }
    return value;
  }
}
