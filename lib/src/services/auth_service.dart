import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practicejob/src/models/user.dart';

class AuthService {
  final baseUrl = 'http://10.0.2.2:5000';
  // ignore: non_constant_identifier_names
  // static final SESSION = FlutterSession();

  Future<http.Response> register(User u) {
    var url = Uri.parse('$baseUrl/api/Auth/Create');
    return http
        .post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'email': u.email, 'password': u.password}),
        )
        .timeout(const Duration(seconds: 30));
  }

  Future<http.Response> login(User u) {
    var url = Uri.parse('$baseUrl/api/Auth/Login');
    return http
        .post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': u.email,
            'password': u.password,
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
