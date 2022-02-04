import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/http_interceptor.dart';

class StudentService {
  final baseUrl = apiBaseUrl;
  final authHttp = AuthHttpClient();
  final _authService = AuthService();

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

  Future<User?> uploadImage(int userId, String imagepath) async {
    var url = Uri.parse('$baseUrl/api/Student/UploadImage?studentId=$userId');
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + await _authService.getCurrentToken()
    };
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', imagepath));

    User? u;
    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          u = User.fromJson(jsonDecode(response.body));
        }
        return u;
      });
    }).timeout(const Duration(seconds: 45));
  }
}
