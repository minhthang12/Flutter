import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/services/api_service.dart';
import 'dart:convert';

class TokenStorage {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final tokenMap = jsonDecode(token!);
    return tokenMap['token'];
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  static bool isTokenExpired(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT token');
    }

    final payload = parts[1];

    final normalized = base64Url.normalize(payload);
    final decodedBytes = base64Url.decode(normalized);
    final decodedString = utf8.decode(decodedBytes);
    final payloadMap = json.decode(decodedString);

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload structure');
    }

    final exp = payloadMap['exp'];
    if (exp == null) {
      throw Exception('Token does not contain expiration (exp) field');
    }

    final currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return currentTimeInSeconds >= exp; // ✅ true nếu đã hết hạn
  }
}
