import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:practicejob/src/models/user.dart';

class AuthService {
  final baseUrl = 'http://10.0.2.2:5000';
  final storage = const FlutterSecureStorage();

  saveDataToStorage(data) async {
    Map<String, dynamic> body = jsonDecode(data);
    String? token = body['token'];
    User u;
    if (token != null && body['data'] != null) {
      u = User.fromJson(body['data']);
      u.token = token;
    } else {
      u = User.fromJson(body);
      u.token = await getCurrentToken();
    }

    return await storage.write(key: 'user', value: jsonEncode(u.toJson()));
  }

  Future<User?> readFromStorage() async {
    String? storageData = await storage.read(key: 'currentUser');

    if (storageData != null) {
      final storageJson = jsonDecode(storageData);
      final User userObject = User.fromJson(storageJson);
      return userObject;
    } else {
      return null;
    }
  }

  Future<String> getCurrentToken() async {
    String? storageData = await storage.read(key: 'currentUser');
    if (storageData != null) {
      final storageJson = jsonDecode(storageData);
      return storageJson['token'];
    } else {
      return "nodata";
    }
  }

  Future<http.Response> register(email, password) {
    var url = Uri.parse('$baseUrl/api/Auth/Create');
    return http
        .post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
            'loginType': 'Student'
          }),
        )
        .timeout(const Duration(seconds: 15));
  }

  Future<http.Response> login(email, password) {
    var url = Uri.parse('$baseUrl/api/Auth/Login');
    return http
        .post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
            'loginType': 'Student'
          }),
        )
        .timeout(const Duration(seconds: 15));
  }
}
