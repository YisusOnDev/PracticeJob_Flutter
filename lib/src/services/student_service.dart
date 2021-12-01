import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicejob/src/services/auth_service.dart';

class StudentService {
  final baseUrl = 'http://10.0.2.2:5000';
  final AuthService _auth = AuthService();

  Future<http.Response> update(userJson) async {
    var url = Uri.parse('$baseUrl/api/Student/Update');
    String token = "Bearer " + await _auth.getCurrentToken();

    return http
        .post(url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: token
            },
            body: jsonEncode(userJson))
        .timeout(const Duration(seconds: 15));
  }
}
