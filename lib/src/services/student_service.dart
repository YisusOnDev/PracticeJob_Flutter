import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/services/auth_service.dart';

class StudentService {
  final baseUrl = apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<http.Response> update(userJson) async {
    var url = Uri.parse('$baseUrl/api/Student');

    return http
        .put(url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader:
                  "Bearer " + await _authService.getCurrentToken(),
            },
            body: jsonEncode(userJson))
        .timeout(const Duration(seconds: 15));
  }
}
