import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:practicejob/src/models/province.dart';
import 'package:practicejob/src/models/user.dart';

class AuthService {
  final baseUrl = 'http://10.0.2.2:5000';
  final storage = const FlutterSecureStorage();

  saveDataToStorage(data) async {
    Map<String, dynamic> body = jsonDecode(data);

    User u = User(
      body['data']['id'],
      body['data']['email'],
      body['data']['name'],
      body['data']['lastname'],
      DateTime.parse(body['data']['birthDate']),
      Province(
        id: body['data']['province']['id'],
        name: body['data']['province']['name'],
      ),
      body['data']['city'],
      body['token'],
    );
    return await storage.write(
        key: 'currentUser', value: u.toJson().toString());
  }

  Future<dynamic> readFromStorage() async {
    String? storageData = await storage.read(key: 'currentUser');
    if (storageData != null) {
      Map<String, dynamic> storageJson = jsonDecode(storageData);
      var storageUser = User.fromJson(storageJson);
      return storageUser;
    } else {
      return null;
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
        .timeout(const Duration(seconds: 30));
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
        .timeout(const Duration(seconds: 30));
  }

  Future<http.Response> update(email, password) {
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
        .timeout(const Duration(seconds: 30));
  }

  /*static setToken(String token, String refreshToken) async {
    _AuthData data = _AuthData(token, refreshToken);
    await SESSION.set('tokens', data);
  }*/

  /*static Future<Map<String, dynamic>> getToken() async {
    return await SESSION.get('tokens');
  }*/

  /*static removeToken() async {
    await SESSION.prefs.clear();
  }*/
}

/*class _AuthData {
  String token, refreshToken, clientId;
  _AuthData(this.token, this.refreshToken, {this.clientId});

  // toJson
  // required by Session lib
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['clientId'] = clientId;
    return data;
  }
}*/
