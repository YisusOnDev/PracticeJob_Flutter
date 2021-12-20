import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/user.dart';

class AuthService {
  final baseUrl = apiBaseUrl;
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

  Future<bool> isAuthorized() async {
    var url = Uri.parse('$baseUrl/api/Student/Authorized');
    User? u = await readFromStorage();
    if (u != null) {
      http.Response res = await http
          .post(url,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.authorizationHeader:
                    "Bearer " + await getCurrentToken(),
              },
              body: jsonEncode(u.toJson()))
          .timeout(const Duration(seconds: 5));

      if (res.statusCode == 200) {
        await saveDataToStorage(res.body);
        return true;
      }
    }
    return false;
  }

  Future<String> getFirstPageRoute() async {
    bool isAuthenticated = await isAuthorized();
    if (isAuthenticated) {
      User? user = await readFromStorage();
      if (user != null && user.token != null) {
        if (user.name != null) {
          return '/home';
        } else {
          return '/completeprofile';
        }
      }
    }
    return '/welcome';
  }
}
