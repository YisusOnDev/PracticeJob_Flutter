import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/services/auth_service.dart';

class StudentService {
  final baseUrl = apiBaseUrl;
  final AuthService _authService = AuthService();

  Future<http.Response> resendConfirmEmail(userJson) async {
    var url = Uri.parse('$baseUrl/api/Student/SendEmailConfirm');

    return http
        .post(url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader:
                  "Bearer " + await _authService.getCurrentToken(),
            },
            body: jsonEncode(userJson))
        .timeout(const Duration(seconds: 15));
  }

  Future<http.Response> validateEmail(userJson, code) async {
    var url = Uri.parse('$baseUrl/api/Student/ValidateEmail?code=' + code);

    return http
        .post(url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader:
                  "Bearer " + await _authService.getCurrentToken(),
            },
            body: jsonEncode(userJson))
        .timeout(const Duration(seconds: 15));
  }

  Future<http.Response> sendResetPasswordMail(email) async {
    var url =
        Uri.parse('$baseUrl/api/Student/SendPasswordReset?email=' + email);

    return http.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          "Bearer " + await _authService.getCurrentToken(),
    }).timeout(const Duration(seconds: 15));
  }

  Future<http.Response> resetPassword(passwordResetJson) async {
    var url = Uri.parse('$baseUrl/api/Student/UpdatePassword');

    return http
        .post(url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json'
            },
            body: jsonEncode(passwordResetJson))
        .timeout(const Duration(seconds: 15));
  }

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
