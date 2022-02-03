import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/http_interceptor.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<User?> uploadImage(int userId, Uint8List image) async {
    var url = Uri.parse('$baseUrl/api/Student/UploadImage?studentId=$userId');
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + await _authService.getCurrentToken()
    };
    var request = http.MultipartRequest("POST", url);
    request.files.add(http.MultipartFile.fromBytes('file', image,
        contentType: MediaType('image', 'jpeg')));
    request.headers.addAll(headers);
    var response = await request.send();
    User? u;
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        u = User.fromJson(jsonDecode(value));
      });
      return u;
    }
    return null;
  }
}
