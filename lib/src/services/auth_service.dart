import 'dart:convert';
import 'dart:io';

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

    return await storage.write(
        key: 'currentUser', value: jsonEncode(u.toJson()));
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

  logout() async {
    await storage.deleteAll();
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

  Future<bool> isAuthenticated() async {
    String? storageData = await storage.read(key: 'currentUser');
    if (storageData != null) {
      final storageJson = jsonDecode(storageData);
      // In futue we'll need to check if token is still valid and so...
      return storageJson['token'] != null;
    } else {
      return false;
    }
  }

  Future<http.Response> register(email, password) {
    var url = Uri.parse('$baseUrl/api/Auth/Create');
    return http
        .post(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
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
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
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
