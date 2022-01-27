import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/services/http_interceptor.dart';

class StudentService {
  final baseUrl = apiBaseUrl;
  final authHttp = AuthHttpClient();

  Future<http.Response> resendConfirmEmail(userJson) async {
    var url = Uri.parse('$baseUrl/api/Student/SendEmailConfirm');

    return authHttp
        .post(url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            },
            body: jsonEncode(userJson))
        .timeout(const Duration(seconds: 15));
  }

  Future<http.Response> validateEmail(userJson, code) async {
    var url = Uri.parse('$baseUrl/api/Student/ValidateEmail?code=' + code);

    return authHttp
        .post(url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            },
            body: jsonEncode(userJson))
        .timeout(const Duration(seconds: 15));
  }

  Future<http.Response> sendResetPasswordMail(email) async {
    var url =
        Uri.parse('$baseUrl/api/Student/SendPasswordReset?email=' + email);

    return authHttp.post(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    }).timeout(const Duration(seconds: 15));
  }

  Future<http.Response> resetPassword(passwordResetJson) async {
    var url = Uri.parse('$baseUrl/api/Student/UpdatePassword');

    return authHttp
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

    return authHttp
        .put(url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            },
            body: jsonEncode(userJson))
        .timeout(const Duration(seconds: 15));
  }
}
