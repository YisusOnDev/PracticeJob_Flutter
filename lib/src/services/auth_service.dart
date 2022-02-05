import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/services/http_interceptor.dart';

class AuthService {
  final storage = const FlutterSecureStorage();
  final authHttp = AuthHttpClient();

  saveUserToStorage(data) async {
    Map<String, dynamic> body = jsonDecode(data);
    User u;
    u = User.fromJson(body);

    return await storage.write(
        key: 'currentUser', value: jsonEncode(u.toJson()));
  }

  Future<User?> readUserFromStorage() async {
    String? storageData = await storage.read(key: 'currentUser');
    if (storageData != null) {
      final storageJson = jsonDecode(storageData);
      final User userObject = User.fromJson(storageJson);
      return userObject;
    } else {
      return null;
    }
  }

  saveTokenToStorage(token) async {
    return await storage.write(key: 'currentToken', value: token);
  }

  Future<String> getCurrentToken() async {
    String? storageData = await storage.read(key: 'currentToken');
    if (storageData != null) {
      return storageData;
    } else {
      return "nodata";
    }
  }

  logout() async {
    await storage.deleteAll();
  }

  Future<http.Response> login(email, password) {
    var url = Uri.parse('$serverRoot/api/Auth/Login');
    return authHttp
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
        .timeout(const Duration(seconds: 30));
  }

  Future<http.Response> register(email, password) {
    var url = Uri.parse('$serverRoot/api/Auth/Create');
    return authHttp
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
        .timeout(const Duration(seconds: 30));
  }

  Future<bool> isAuthorized() async {
    var url = Uri.parse('$serverRoot/api/Student/Authorized');
    User? u = await readUserFromStorage();
    if (u != null) {
      http.Response res = await authHttp
          .post(url,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.acceptHeader: 'application/json',
              },
              body: jsonEncode(u.toJson()))
          .timeout(const Duration(seconds: 30));

      if (res.statusCode == 200) {
        await saveUserToStorage(res.body);
        return true;
      }
    }
    return false;
  }

  Future<String> getFirstPageRoute() async {
    bool isAuthenticated = await isAuthorized();
    if (isAuthenticated) {
      User? user = await readUserFromStorage();
      String token = await getCurrentToken();
      if (user != null && token != 'nodata') {
        if (user.validatedEmail == false) {
          return '/confirmemail';
        }
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
